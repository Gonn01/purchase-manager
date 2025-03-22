import 'package:bloc/bloc.dart';
import 'package:purchase_manager/features/dashboard/repositories/purchases_repository.dart';
import 'package:purchase_manager/utilities/models/purchase.dart';
import 'package:purchase_manager/utilities/services/firebase_service.dart';

part 'bloc_purchase_details_event.dart';
part 'bloc_purchase_details_state.dart';

/// {@template BlocInicio}
/// Bloc que maneja los estados y lógica de la pagina de 'Login'
/// {@endtemplate}
class BlocPurchaseDetails
    extends Bloc<BlocPurchaseDetailsEvent, BlocPurchaseDetailsState> {
  /// {@macro BlocInicio}
  BlocPurchaseDetails() : super(BlocPurchaseDetailsStateInitial()) {
    on<BlocPurchaseDetailsEventInitialize>(_onInitialize);
  }
  final _purchasesRepository = PurchasesRepository();
  Future<void> _onInitialize(
    BlocPurchaseDetailsEventInitialize event,
    Emitter<BlocPurchaseDetailsState> emit,
  ) async {
    emit(BlocPurchaseDetailsStateLoading.from(state));
    try {
      final purchase = await _purchasesRepository.getPurchaseById(
        purchaseId: event.idPurchase,
      );

      emit(
        BlocPurchaseDetailsStateSuccess.from(
          state,
          purchase: purchase,
        ),
      );
    } on Exception catch (e) {
      emit(BlocPurchaseDetailsStateError.from(state, error: e.toString()));
    }
  }
}
