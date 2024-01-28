import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:purchase_manager/endpoints/crud_purchase.dart';
import 'package:purchase_manager/models/enums/status.dart';
import 'package:purchase_manager/models/purchase.dart';

part 'bloc_purchase_details_event.dart';
part 'bloc_purchase_details_state.dart';

/// {@template BlocInicio}
/// Bloc que maneja los estados y lógica de la pagina de 'Login'
/// {@endtemplate}
class BlocPurchaseDetails
    extends Bloc<BlocPurchaseDetailsEvent, BlocPurchaseDetailsState> {
  /// {@macro BlocInicio}
  BlocPurchaseDetails() : super(const BlocPurchaseDetailsState()) {
    on<BlocPurchaseDetailsEventInitialize>(_onInitialize);
  }

  Future<void> _onInitialize(
    BlocPurchaseDetailsEventInitialize event,
    Emitter<BlocPurchaseDetailsState> emit,
  ) async {
    emit(state.copyWith(estado: Status.loading));
    try {
      final purchase = await getPurchaseById(
        purchaseId: event.idPurchase,
        financialEntityId: event.idFinancialEntity,
      );

      emit(
        state.copyWith(
          estado: Status.success,
          purchase: purchase,
        ),
      );
    } catch (e) {
      emit(state.copyWith(estado: Status.error));
    }
  }
}
