// ignore_for_file: avoid_print, lines_longer_than_80_chars

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:purchase_manager/utilities/extensions/date_time.dart';
import 'package:purchase_manager/utilities/models/enums/currency_type.dart';
import 'package:purchase_manager/utilities/models/enums/purchase_type.dart';
import 'package:purchase_manager/utilities/models/financial_entity.dart';
import 'package:purchase_manager/utilities/models/purchase.dart';

/// {@template FirebaseService}
/// Servicio de Firebase
/// Firebase service
/// {@endtemplate}
class FirebaseService {
  final _firestore = FirebaseFirestore.instance;

  /// ID del usuario actual
  final userId = FirebaseAuth.instance.currentUser!.uid;

  /// Actualiza las compras en Firestore.
  Future<void> asd() async {
    try {
      // Obtiene todos los usuarios
      final usersSnapshot = _firestore.collection('usuarios').doc(userId);

      final categorias = await usersSnapshot.collection('categorias').get();

      for (final categoriaDoc in categorias.docs) {
        print('Categoría ID: ${categoriaDoc.id}, Data: ${categoriaDoc.data()}');

        // Accede a la colección "compras" de cada categoría
        final comprasSnapshot =
            await categoriaDoc.reference.collection('compras').get();

        if (comprasSnapshot.docs.isEmpty) {
          print(
            'No se encontraron compras para la categoría ${categoriaDoc.id}.',
          );
          continue;
        }

        for (final compraDoc in comprasSnapshot.docs) {
          print('Compra ID: ${compraDoc.id}, Data: ${compraDoc.data()}');

          // Revisa si el campo "cuotasPagadas" no existe
          if (!compraDoc.data().containsKey('cuotasPagadas')) {
            // Actualiza la compra con "cuotasPagadas" establecido en 0
            await compraDoc.reference.update({'cuotasPagadas': 0});
            print('Actualizado cuotasPagadas en compra: ${compraDoc.id}');
          }
        }
      }

      print('Actualización completa.');
    } catch (e) {
      print('Error al actualizar las compras: $e');
    }
  }

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
        'logs': <String>['Se creó la compra. ${DateTime.now().formatWithHour}'],
      });

      await _firestore
          .collection('usuarios')
          .doc(idUser)
          .collection('categorias')
          .doc(idFinancialEntity)
          .update({
        'logs': FieldValue.arrayUnion(
          <String>[
            'Se creó la compra ${newPurchase.nameOfProduct}. ${DateTime.now().formatWithHour}',
          ],
        ),
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

      await _firestore
          .collection('usuarios')
          .doc(idUser)
          .collection('categorias')
          .doc(idFinancialEntity)
          .update({
        'logs': FieldValue.arrayUnion(
          <String>[
            'Se elimino la compra $idPurchase. ${DateTime.now().formatWithHour}',
          ],
        ),
      });
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
          quotasPayed: compraData['cuotasPagadas'] as int,
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

  /// Crea una nueva [FinancialEntity] en Firestore.
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
        'logs': <String>[
          'Se creó $financialEntityName. ${DateTime.now().formatWithHour}',
        ],
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
            DateTime? lastCuotaDate;

            if (purchaseData['fechaFinalizacion'] != null) {
              if (purchaseData['fechaFinalizacion'] is Timestamp) {
                lastCuotaDate =
                    (purchaseData['fechaFinalizacion'] as Timestamp).toDate();
              } else if (purchaseData['fechaFinalizacion'] is DateTime) {
                lastCuotaDate = purchaseData['fechaFinalizacion'] as DateTime;
              }
            }
            return Purchase(
              currency: CurrencyType.type(purchaseData['currency'] as int),
              id: purchaseDoc.id,
              amountOfQuotas: purchaseData['cantidadCuotas'] as int,
              quotasPayed: purchaseData['cuotasPagadas'] as int,
              totalAmount: purchaseData['monto'] as double,
              amountPerQuota: purchaseData['montoPorCuota'] as double,
              nameOfProduct: purchaseData['producto'] as String,
              type: PurchaseType.type(purchaseData['type'] as int),
              creationDate:
                  (purchaseData['fechaCreacion'] as Timestamp).toDate(),
              lastCuotaDate: lastCuotaDate,
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
    required String idFinancialEntity,
    required String idUsuario,
  }) async {
    try {
      await _firestore
          .collection('usuarios')
          .doc(idUsuario)
          .collection('categorias')
          .doc(idFinancialEntity)
          .delete();
      debugPrint('Categoría eliminada de Firestore.');
    } catch (e) {
      debugPrint('Error al eliminar la categoría: $e');
    }
  }
}
