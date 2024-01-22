import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
      'logs': <String>['Se creó la compra. ${DateTime.now()}}'],
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

/// Añade un log a una [Purchase] en Firestore.
///
/// Adds a log to a [Purchase] in Firestore.
Future<void> updatePurchaseLogs({
  required String idUser,
  required String idFinancialEntity,
  required String idPurchase,
  required String newLog,
}) async {
  try {
    final DocumentReference compraRef = _firestore
        .collection('usuarios')
        .doc(idUser)
        .collection('categorias')
        .doc(idFinancialEntity)
        .collection('compras')
        .doc(idPurchase);
    final purchaseSnapshot = await compraRef.get();

    final purchaseData = purchaseSnapshot.data()! as Map<String, dynamic>;

    final logs = (purchaseData['logs'] as List<dynamic>).cast<String>()
      ..add(newLog);

    await compraRef.update({
      'logs': logs,
    });
    debugPrint('Logs añadidos en Firestore.');
  } catch (e) {
    debugPrint('Error al añadir los logs: $e');
  }
}
