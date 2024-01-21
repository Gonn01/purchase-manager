import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:purchase_manager/models/purchase.dart';
import 'package:flutter/material.dart';

final _firestore = FirebaseFirestore.instance;
Future<void> createCompra({
  required String usuarioId,
  required String categoriaId,
  required Purchase nuevaCompra,
}) async {
  try {
    await _firestore
        .collection('usuarios')
        .doc(usuarioId)
        .collection('categorias')
        .doc(categoriaId)
        .collection('compras')
        .add({
      'cantidadCuotas': nuevaCompra.amountOfQuotas,
      'monto': nuevaCompra.totalAmount,
      'montoPorCuota': nuevaCompra.amountPerQuota,
      'producto': nuevaCompra.nameOfProduct,
      'type': nuevaCompra.type.value,
      'fechaCreacion': nuevaCompra.creationDate,
      'fechaFinalizacion': null,
      'fechaPrimeraCuota': null,
      'currency': nuevaCompra.currency.value,
    });

    debugPrint('Compra registrada en Firestore.');
  } catch (e) {
    debugPrint('Error al registrar la compra: $e');
  }
}

Future<void> updatePurchase({
  required String idUser,
  required String idFinancialEntity,
  required Purchase newPurchase,
}) async {
  try {
    DocumentReference compraRef = _firestore
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
    });

    debugPrint('Compra actualizada en Firestore.');
  } catch (e) {
    debugPrint('Error al actualizar la compra: $e');
  }
}

Future<void> deleteCompra({
  required String usuarioId,
  required String categoriaId,
  required String compraId,
}) async {
  try {
    await _firestore
        .collection('usuarios')
        .doc(usuarioId)
        .collection('categorias')
        .doc(categoriaId)
        .collection('compras')
        .doc(compraId)
        .delete();

    debugPrint('Compra eliminada de Firestore.');
  } catch (e) {
    debugPrint('Error al eliminar la compra: $e');
  }
}
