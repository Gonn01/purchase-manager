import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:purchase_manager/extensions/date_time.dart';
import 'package:purchase_manager/models/enums/currency_type.dart';
import 'package:purchase_manager/models/enums/purchase_type.dart';
import 'package:purchase_manager/models/purchase.dart';

final _firestore = FirebaseFirestore.instance;

/// Crea una nueva [Purchase] en Firestore.
/// Creates a new [Purchase] in Firestore.
Future<void> createPurchase({
  required String idUser,
  required String idFinancialEntity,
  required Purchase newPurchase,
}) async {
  try {
    await _firestore
        .collection('usuarios')
        .doc(idUser)
        .collection('categorias')
        .doc(idFinancialEntity)
        .collection('compras')
        .add({
      'cantidadCuotas': newPurchase.amountOfQuotas,
      'monto': newPurchase.totalAmount,
      'montoPorCuota': newPurchase.amountPerQuota,
      'producto': newPurchase.nameOfProduct,
      'type': newPurchase.type.value,
      'fechaCreacion': newPurchase.creationDate,
      'fechaFinalizacion': null,
      'fechaPrimeraCuota': null,
      'currency': newPurchase.currency.value,
      'logs': <String>['Se creó la compra. ${DateTime.now().formatWithHour}}'],
    });

    debugPrint('Compra registrada en Firestore.');
  } catch (e) {
    debugPrint('Error al registrar la compra: $e');
  }
}

/// Actualiza una [Purchase] en Firestore.
///
/// Updates a [Purchase] in Firestore.
Future<void> updatePurchase({
  required String idUser,
  required String idFinancialEntity,
  required Purchase newPurchase,
}) async {
  try {
    final DocumentReference compraRef = _firestore
        .collection('usuarios')
        .doc(idUser)
        .collection('categorias')
        .doc(idFinancialEntity)
        .collection('compras')
        .doc(newPurchase.id);

    await compraRef.update({
      'cantidadCuotas': newPurchase.amountOfQuotas,
      'monto': newPurchase.totalAmount,
      'producto': newPurchase.nameOfProduct,
      'montoPorCuota': newPurchase.amountPerQuota,
      'type': newPurchase.type.value,
      'currency': newPurchase.currency.value,
      'logs': newPurchase.logs,
      'fechaFinalizacion': newPurchase.lastCuotaDate,
    });

    debugPrint('Compra actualizada en Firestore.');
  } catch (e) {
    debugPrint('Error al actualizar la compra: $e');
  }
}

/// Elimina una [Purchase] de Firestore.
/// Deletes a [Purchase] from Firestore.
Future<void> deletePurchase({
  required String idUser,
  required String idFinancialEntity,
  required String idPurchase,
}) async {
  try {
    await _firestore
        .collection('usuarios')
        .doc(idUser)
        .collection('categorias')
        .doc(idFinancialEntity)
        .collection('compras')
        .doc(idPurchase)
        .delete();

    debugPrint('Compra eliminada de Firestore.');
  } catch (e) {
    debugPrint('Error al eliminar la compra: $e');
  }
}

Future<Purchase?> getPurchaseById({required String id}) async {
  try {
    final purchaseSnapshot =
        await _firestore.collection('compras').doc(id).get();
    DateTime? lastCuotaDate;
    if (purchaseSnapshot.exists) {
      if (purchaseSnapshot['fechaFinalizacion'] != null) {
        if (purchaseSnapshot['fechaFinalizacion'] is Timestamp) {
          lastCuotaDate =
              (purchaseSnapshot['fechaFinalizacion'] as Timestamp).toDate();
        } else if (purchaseSnapshot['fechaFinalizacion'] is DateTime) {
          lastCuotaDate = purchaseSnapshot['fechaFinalizacion'] as DateTime;
        }
      }
    }
    final purchase = Purchase(
      currency: CurrencyType.type(purchaseSnapshot['currency'] as int),
      id: purchaseSnapshot.id,
      amountOfQuotas: purchaseSnapshot['cantidadCuotas'] as int,
      totalAmount: purchaseSnapshot['monto'] as double,
      amountPerQuota: purchaseSnapshot['montoPorCuota'] as double,
      nameOfProduct: purchaseSnapshot['producto'] as String,
      type: PurchaseType.type(purchaseSnapshot['type'] as int),
      creationDate: (purchaseSnapshot['fechaCreacion'] as Timestamp).toDate(),
      lastCuotaDate: lastCuotaDate,
      logs: (purchaseSnapshot['logs'] as List<dynamic>).cast<String>(),
    );
    return purchase;
  } catch (e) {
    debugPrint('Error retrieving purchase: $e');
    return null;
  }
}
