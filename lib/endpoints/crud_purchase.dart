import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

/// Obtiene una [Purchase] de Firestore por su ID.
///
/// Gets a [Purchase] from Firestore by its ID.
Future<Purchase?> getPurchaseById({
  required String financialEntityId,
  required String purchaseId,
}) async {
  try {
    final userId = FirebaseAuth.instance.currentUser!.uid;

    final querySnapshot = await _firestore
        .collection('usuarios')
        .doc(userId)
        .collection('categorias')
        .doc(financialEntityId)
        .collection('compras')
        .doc(purchaseId)
        .get();

    if (querySnapshot.exists) {
      final compraData = querySnapshot.data()!;

      final compra = Purchase(
        id: querySnapshot.id,
        amountOfQuotas: compraData['cantidadCuotas'] as int,
        totalAmount: compraData['monto'] as double,
        amountPerQuota: compraData['montoPorCuota'] as double,
        nameOfProduct: compraData['producto'] as String,
        type: PurchaseType.type(compraData['type'] as int),
        creationDate: (compraData['fechaCreacion'] as Timestamp).toDate(),
        lastCuotaDate:
            (compraData['fechaFinalizacion'] as Timestamp?)?.toDate(),
        currency: CurrencyType.type(compraData['currency'] as int),
        logs: List<String>.from(compraData['logs'] as List<dynamic>),
      );

      return compra;
    } else {
      debugPrint('La compra con ID $purchaseId no existe.');
      return null;
    }
  } catch (e) {
    debugPrint('Error al obtener la compra: $e');
    return null;
  }
}
