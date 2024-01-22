import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:purchase_manager/models/enums/currency_type.dart';
import 'package:purchase_manager/models/enums/purchase_type.dart';
import 'package:purchase_manager/models/financial_entity.dart';
import 'package:purchase_manager/models/purchase.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

// CRUD para Categorias

/// Crea una nueva [FinancialEntity] en Firestore.
/// Creates a new [FinancialEntity] in Firestore.
Future<void> createFinancialEntity({
  required String financialEntityName,
  required String idUser,
}) async {
  try {
    await _firestore
        .collection('usuarios')
        .doc(idUser)
        .collection('categorias')
        .add({
      'nombre': financialEntityName,
      'logs': <String>['Se creó la categoría. ${DateTime.now()}}'],
    });

    debugPrint('Categoría registrada en Firestore.');
  } catch (e) {
    debugPrint('Error al registrar la categoría: $e');
  }
}

/// Lee las [FinancialEntity]s de Firestore.
/// Reads the [FinancialEntity]s from Firestore.
Future<List<FinancialEntity>> readFinancialEntities({
  required String idUser,
}) async {
  try {
    final QuerySnapshot querySnapshot = await _firestore
        .collection('usuarios')
        .doc(idUser)
        .collection('categorias')
        .get();
    final list = Future.wait(
      querySnapshot.docs.map((doc) async {
        final QuerySnapshot purchaseManagersnapshot =
            await doc.reference.collection('compras').get();

        final purchases = purchaseManagersnapshot.docs.map((purchaseDoc) {
          final purchaseData = purchaseDoc.data()! as Map<String, dynamic>;

          return Purchase(
            currency: CurrencyType.type(purchaseData['currency'] as int),
            id: purchaseDoc.id,
            amountOfQuotas: purchaseData['cantidadCuotas'] as int,
            totalAmount: purchaseData['monto'] as double,
            amountPerQuota: purchaseData['montoPorCuota'] as double,
            nameOfProduct: purchaseData['producto'] as String,
            type: PurchaseType.type(purchaseData['type'] as int),
            creationDate: (purchaseData['fechaCreacion'] as Timestamp).toDate(),
            lastCuotaDate:
                (purchaseData['FechaFinalizacion'] as DateTime?) != null
                    ? (purchaseData['FechaFinalizacion'] as DateTime)
                    : null,
            logs: (purchaseData['logs'] as List<dynamic>).cast<String>(),
          );
        }).toList();

        debugPrint('Éxito al leer las categorías');
        return FinancialEntity(
          id: doc.id,
          name: doc['nombre'] as String,
          purchases: purchases,
          logs: (doc['logs'] as List<dynamic>).cast<String>(),
        );
      }).toList(),
    );
    return list;
  } catch (e) {
    debugPrint('Error al leer las categorías: $e');
    return [];
  }
}

/// Actualiza una [FinancialEntity] en Firestore.
/// Updates a [FinancialEntity] in Firestore.
Future<void> updateFinancialEntity({
  required String idFinancialEntity,
  required String idUser,
  required String newName,
  required List<String> newLogs,
}) async {
  try {
    await _firestore
        .collection('usuarios')
        .doc(idUser)
        .collection('categorias')
        .doc(idFinancialEntity)
        .update({
      'nombre': newName,
      'logs': newLogs,
    });
    debugPrint('Categoría actualizada en Firestore.');
  } catch (e) {
    debugPrint('Error al actualizar la categoría: $e');
  }
}

/// Elimina una [FinancialEntity] de Firestore.
/// Deletes a [FinancialEntity] from Firestore.
Future<void> deleteFinancialEntity({
  required String categoriaId,
  required String idUsuario,
}) async {
  try {
    await _firestore
        .collection('usuarios')
        .doc(idUsuario)
        .collection('categorias')
        .doc(categoriaId)
        .delete();
    debugPrint('Categoría eliminada de Firestore.');
  } catch (e) {
    debugPrint('Error al eliminar la categoría: $e');
  }
}
