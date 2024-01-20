import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:purchase_manager/models/financial_entity.dart';
import 'package:flutter/foundation.dart';
import 'package:purchase_manager/models/purchase.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

// CRUD para Categorias

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
    });

    debugPrint('Categoría registrada en Firestore.');
  } catch (e) {
    debugPrint('Error al registrar la categoría: $e');
  }
}

Future<List<FinancialEntity>> readFinancialEntities({
  required String idUser,
}) async {
  try {
    QuerySnapshot querySnapshot = await _firestore
        .collection('usuarios')
        .doc(idUser)
        .collection('categorias')
        .get();

    return Future.wait(querySnapshot.docs.map((doc) async {
      QuerySnapshot purchase_managerSnapshot =
          await doc.reference.collection('purchase_manager').get();

      List<Purchase> purchases = purchase_managerSnapshot.docs.map((compraDoc) {
        Map<String, dynamic> compraData =
            compraDoc.data() as Map<String, dynamic>;

        return Purchase(
          id: compraDoc.id,
          amountOfQuotas: compraData['cantidadCuotas'],
          totalAmount: compraData['monto'],
          amountPerQuota: compraData['montoPorCuota'],
          nameOfProduct: compraData['producto'],
          current: compraData['vigente'],
          debt: compraData['debo'],
          creationDate: compraData['fechaCreacion'].toDate(),
          lastCuotaDate: compraData['FechaFinalizacion'] != null
              ? compraData['FechaFinalizacion'].toDate()
              : null,
        );
      }).toList();

      debugPrint('Éxito al leer las categorías');
      return FinancialEntity(
        id: doc.id,
        name: doc['nombre'],
        purchases: purchases,
      );
    }).toList());
  } catch (e) {
    debugPrint('Error al leer las categorías: $e');
    return [];
  }
}

Future<void> updateCategoria({
  required String categoriaId,
  required String nuevoNombre,
  required String idUsuario,
}) async {
  try {
    await _firestore
        .collection('usuarios')
        .doc(idUsuario)
        .collection('categorias')
        .doc(categoriaId)
        .update({
      'nombre': nuevoNombre,
    });
    debugPrint('Categoría actualizada en Firestore.');
  } catch (e) {
    debugPrint('Error al actualizar la categoría: $e');
  }
}

Future<void> deleteCategoria({
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
