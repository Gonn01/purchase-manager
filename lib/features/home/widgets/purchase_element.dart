import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purchase_manager/features/home/bloc/bloc_home.dart';
import 'package:purchase_manager/features/home/widgets/dialogs/dialog_edit_purchase.dart';
import 'package:purchase_manager/utilities/extensions/double.dart';
import 'package:purchase_manager/utilities/extensions/string.dart';
import 'package:purchase_manager/utilities/models/enums/purchase_type.dart';
import 'package:purchase_manager/utilities/models/financial_entity.dart';
import 'package:purchase_manager/utilities/models/purchase.dart';

/// {@template PurchaseElement}
/// Elemento que muestra la información de una compra
/// Element that shows the information of a purchase
/// {@endtemplate}
class PurchaseElement extends StatelessWidget {
  /// {@macro PurchaseElement}
  const PurchaseElement({
    required this.purchase,
    required this.financialEntity,
    this.isLoading = false,
    super.key,
  });

  Future<void> _editPurchase(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (_) => BlocProvider.value(
        value: context.read<BlocHome>(),
        child: DialogEditPurchase(
          purchase: purchase,
          financialEntity: financialEntity,
        ),
      ),
    );
  }

  /// Compra a mostrar
  /// Purchase to show
  final Purchase purchase;

  /// Entidad financiera a la que pertenece la compra
  /// Financial entity to which the purchase belongs
  final FinancialEntity financialEntity;

  /// Indica si se está cargando la información
  /// Indicates if the information is being loaded
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: purchase.type == PurchaseType.currentCreditorPurchase
            ? const Color(0xff02B3A3)
            : const Color(0xffFF6B6B),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Stack(
          children: [
            Visibility(
              visible: !isLoading,
              maintainSize: true,
              maintainAnimation: true,
              maintainState: true,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(),
                        Text(
                          purchase.nameOfProduct.capitalize,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => _editPurchase(context),
                          child: const Icon(
                            Icons.settings,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        purchase.type.isCurrent
                            ? 'Total: ${purchase.totalAmount.formatAmount()}'
                                '${purchase.currency.name}'
                            : 'Fecha de finalización: '
                                '${purchase.lastQuotaDate}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${purchase.amountOfQuotas} '
                        'cuotas de ${purchase.amountPerQuota.formatAmount()}'
                        '${purchase.currency.name}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Cuotas a pagar '
                        '${purchase.amountOfQuotas - purchase.quotasPayed} ',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          decoration: !purchase.type.isCurrent
                              ? TextDecoration.lineThrough
                              : null,
                        ),
                      ),
                      if (purchase.type.isCurrent)
                        Row(
                          children: [
                            // GestureDetector(
                            //   onTap: () => context.read<BlocHome>().add(
                            //         BlocHomeEventIncreaseAmountOfQuotas(
                            //           idPurchase: purchase.id ?? '',
                            //           purchaseType: purchase.type,
                            //         ),
                            //       ),
                            //   child: const Icon(
                            //     Icons.keyboard_double_arrow_up_sharp,
                            //     size: 25,
                            //     color: Colors.white,
                            //   ),
                            // ),
                            // const SizedBox(width: 10),
                            GestureDetector(
                              onTap: () => context.read<BlocHome>().add(
                                    BlocHomeEventPayQuota(
                                      idPurchase: purchase.id ?? '',
                                      purchaseType: purchase.type,
                                    ),
                                  ),
                              child: const Text(
                                'Pagar cuota',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        )
                      else
                        GestureDetector(
                          onTap: () => context.read<BlocHome>().add(
                                BlocHomeEventIncreaseAmountOfQuotas(
                                  idPurchase: purchase.id ?? '',
                                  purchaseType: purchase.type,
                                ),
                              ),
                          child: const Icon(
                            Icons.restore,
                            size: 25,
                            color: Colors.white,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
            if (isLoading)
              const Positioned.fill(
                child: Align(
                  child: CircularProgressIndicator(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
