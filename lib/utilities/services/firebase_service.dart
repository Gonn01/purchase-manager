import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
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
  Future<void> actualizarFechaCreacionComoString() async {
    try {
      // Obtiene todos los usuarios
      final usersSnapshot = _firestore.collection('usuarios').doc(userId);

      final categorias = await usersSnapshot.collection('categorias').get();

      for (final categoriaDoc in categorias.docs) {
        // Accede a la colección "compras" de cada categoría
        final comprasSnapshot =
            await categoriaDoc.reference.collection('compras').get();

        if (comprasSnapshot.docs.isEmpty) {
          debugPrint(
            'No se encontraron compras para la categoría ${categoriaDoc.id}.',
          );
          continue;
        }

        for (final compraDoc in comprasSnapshot.docs) {
          debugPrint('Compra ID: ${compraDoc.id}, Data: ${compraDoc.data()}');

          // Revisa si el campo "fechaCreacion" existe y es un Timestamp
          final data = compraDoc.data();
          if (data.containsKey('fechaCreacion') &&
              data['fechaCreacion'] is Timestamp) {
            final timestamp = data['fechaCreacion'] as Timestamp;
            final f = timestamp.toDate().formatWithHour;
            // Actualiza la compra con "fechaCreacion" formateada
            await compraDoc.reference.update({'fechaCreacion': f});
            debugPrint(
              'Actualizado fechaCreacion en compra ${compraDoc.id}: '
              '${timestamp.toDate().formatWithHour}',
            );
          }
        }
      }

      debugPrint('Actualización completa.');
    } on Exception catch (e) {
      debugPrint('Error al actualizar las compras: $e');
    }
  }

  /// Actualiza las fechas específicas en las compras si son Timestamps,
  /// formateándolas como String.
  Future<void> actualizarFechasComoString() async {
    try {
      // Obtiene todos los usuarios
      final usersSnapshot = _firestore.collection('usuarios').doc(userId);

      final categorias = await usersSnapshot.collection('categorias').get();

      for (final categoriaDoc in categorias.docs) {
        // Accede a la colección "compras" de cada categoría
        final comprasSnapshot =
            await categoriaDoc.reference.collection('compras').get();

        if (comprasSnapshot.docs.isEmpty) {
          debugPrint(
            'No se encontraron compras para la categoría ${categoriaDoc.id}.',
          );
          continue;
        }

        for (final compraDoc in comprasSnapshot.docs) {
          debugPrint('Compra ID: ${compraDoc.id}, Data: ${compraDoc.data()}');

          final data = compraDoc.data();

          // Lista de campos de fecha a verificar
          final camposFecha = [
            'fechaFinalizacion',
            'fechaCreacion',
            'fechaPrimeraCuota',
          ];

          // Revisa y actualiza cada campo si es un Timestamp
          for (final campo in camposFecha) {
            if (data.containsKey(campo) && data[campo] is Timestamp) {
              final timestamp = data[campo] as Timestamp;
              final fechaFormateada = timestamp.toDate().formatWithHour;

              await compraDoc.reference.update({campo: fechaFormateada});
              debugPrint(
                'Actualizado $campo en compra ${compraDoc.id}: '
                '$fechaFormateada',
              );
            }
          }
        }
      }

      debugPrint('Actualización de fechas completa.');
    } on Exception catch (e) {
      debugPrint('Error al actualizar las fechas en las compras: $e');
    }
  }

  /// Actualiza las compras en Firestore.
  Future<void> crearValorCuotasPagadasYIgnored() async {
    try {
      // Obtiene todos los usuarios
      final usersSnapshot = _firestore.collection('usuarios').doc(userId);

      final categorias = await usersSnapshot.collection('categorias').get();

      for (final categoriaDoc in categorias.docs) {
        // Accede a la colección "compras" de cada categoría
        final comprasSnapshot =
            await categoriaDoc.reference.collection('compras').get();

        if (comprasSnapshot.docs.isEmpty) {
          debugPrint(
            'No se encontraron compras para la categoría ${categoriaDoc.id}.',
          );
          continue;
        }

        for (final compraDoc in comprasSnapshot.docs) {
          debugPrint('Compra ID: ${compraDoc.id}, Data: ${compraDoc.data()}');

          // Revisa si el campo "cuotasPagadas" no existe
          if (!compraDoc.data().containsKey('cuotasPagadas')) {
            // Actualiza la compra con "cuotasPagadas" establecido en 0
            await compraDoc.reference.update({'cuotasPagadas': 0});
            debugPrint('Actualizado cuotasPagadas en compra: ${compraDoc.id}');
          }
          if (!compraDoc.data().containsKey('ignored')) {
            // Actualiza la compra con "cuotasPagadas" establecido en 0
            await compraDoc.reference.update({'ignored': false});
            debugPrint('Actualizado ignored en compra: ${compraDoc.id}');
          }
        }
      }

      debugPrint('Actualización completa.');
    } on Exception catch (e) {
      debugPrint('Error al actualizar las compras: $e');
    }
  }

  /// Crea una nueva [Purchase] en Firestore.
  /// Creates a new [Purchase] in Firestore.
  Future<String> createPurchase({
    required String idUser,
    required String idFinancialEntity,
    required Purchase newPurchase,
  }) async {
    try {
      final newPurchasee = await _firestore
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
        'cuotasPagadas': 0,
        'currency': newPurchase.currencyType.value,
        'logs': <String>['Se creó la compra. ${DateTime.now().formatWithHour}'],
        'ignored': false,
        'image': newPurchase.image,
      });

      await _firestore
          .collection('usuarios')
          .doc(idUser)
          .collection('categorias')
          .doc(idFinancialEntity)
          .update({
        'logs': FieldValue.arrayUnion(
          <String>[
            '''Se creó la compra ${newPurchase.nameOfProduct}.${DateTime.now().formatWithHour}''',
          ],
        ),
      });

      return newPurchasee.id;
    } catch (e) {
      throw Exception('Error al registrar la compra: $e');
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
      String? firstQuotaDate;
      if (newPurchase.quotasPayed == 1) {
        firstQuotaDate = DateTime.now().formatWithHour;
      }
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
        'currency': newPurchase.currencyType.value,
        'logs': newPurchase.logs,
        'cuotasPagadas': newPurchase.quotasPayed,
        'fechaFinalizacion': newPurchase.lastQuotaDate,
        'fechaPrimeraCuota': firstQuotaDate,
        'ignored': newPurchase.ignored,
        'image': newPurchase.image,
      });

      debugPrint('Compra actualizada en Firestore.');
    } on Exception catch (e) {
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
            '''Se elimino la compra $idPurchase. ${DateTime.now().formatWithHour}''',
          ],
        ),
      });
      debugPrint('Compra eliminada de Firestore.');
    } on Exception catch (e) {
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
          creationDate: compraData['fechaCreacion'] as String,
          lastQuotaDate: compraData['fechaFinalizacion'] as String?,
          currencyType: CurrencyType.type(compraData['currency'] as int),
          logs: List<String>.from(compraData['logs'] as List<dynamic>),
          firstQuotaDate: compraData['fechaPrimeraCuota'] as String?,
          ignored: compraData['ignored'] as bool,
          image: compraData['image'] as String?,
        );

        return compra;
      } else {
        debugPrint('La compra con ID $purchaseId no existe.');
        return null;
      }
    } on Exception catch (e) {
      debugPrint('Error al obtener la compra: $e');
      return null;
    }
  }

  /// Crea una nueva [FinancialEntity] en Firestore.
  Future<FinancialEntity> createFinancialEntity({
    required String financialEntityName,
    required String idUser,
  }) async {
    try {
      final categories = _firestore
          .collection('usuarios')
          .doc(idUser)
          .collection('categorias');

      final newCategory = await categories.add({
        'nombre': financialEntityName,
        'logs': <String>[
          'Se creó $financialEntityName. ${DateTime.now().formatWithHour}',
        ],
      });

      debugPrint('Categoría registrada en Firestore.');
      return FinancialEntity(
        id: newCategory.id,
        name: financialEntityName,
        purchases: [],
        logs: <String>[
          'Se creó $financialEntityName. ${DateTime.now().formatWithHour}',
        ],
      );
    } catch (e) {
      throw Exception('Error al registrar la categoría: $e');
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
              currencyType: CurrencyType.type(purchaseData['currency'] as int),
              id: purchaseDoc.id,
              amountOfQuotas: purchaseData['cantidadCuotas'] as int,
              quotasPayed: purchaseData['cuotasPagadas'] as int,
              totalAmount: purchaseData['monto'] as double,
              amountPerQuota: purchaseData['montoPorCuota'] as double,
              nameOfProduct: purchaseData['producto'] as String,
              type: PurchaseType.type(purchaseData['type'] as int),
              creationDate: purchaseData['fechaCreacion'] as String,
              lastQuotaDate: purchaseData['fechaFinalizacion'] as String?,
              logs: (purchaseData['logs'] as List<dynamic>).cast<String>(),
              firstQuotaDate: purchaseData['fechaPrimeraCuota'] as String?,
              ignored: purchaseData['ignored'] as bool,
              image: purchaseData['image'] as String?,
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
    } on Exception catch (e) {
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
    } on Exception catch (e) {
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
    } on Exception catch (e) {
      debugPrint('Error al eliminar la categoría: $e');
    }
  }
}
