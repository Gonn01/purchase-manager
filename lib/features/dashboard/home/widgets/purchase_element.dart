import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purchase_manager/features/dashboard/bloc/bloc_dashboard.dart';
import 'package:purchase_manager/utilities/extensions/double.dart';
import 'package:purchase_manager/utilities/extensions/string.dart';
import 'package:purchase_manager/utilities/models/enums/purchase_type.dart';
import 'package:purchase_manager/utilities/models/financial_entity.dart';
import 'package:purchase_manager/utilities/models/purchase.dart';
import 'package:purchase_manager/utilities/widgets/dialogs/edit_purchase_dialog.dart';
import 'package:purchase_manager/utilities/widgets/pm_buttons.dart';

/// {@template PurchaseElement}
/// Elemento que muestra la información de una compra
/// Element that shows the information of a purchase
/// {@endtemplate}
class PurchaseElement extends StatelessWidget {
  /// {@macro PurchaseElement}
  const PurchaseElement({
    required this.purchase,
    required this.financialEntity,
    super.key,
  });

  Future<void> _editPurchase(
    BuildContext context,
    FinancialEntity financialEntity,
    Purchase purchase,
  ) async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) {
        return BlocProvider.value(
          value: context.read<BlocDashboard>(),
          child: EditPurchaseModal(
            financialEntity: financialEntity,
            purchase: purchase,
          ),
        );
      },
    );
  }

  /// Compra a mostrar
  /// Purchase to show
  final Purchase purchase;

  /// Entidad financiera a la que pertenece la compra
  /// Financial entity to which the purchase belongs
  final FinancialEntity financialEntity;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BlocDashboard, BlocDashboardState>(
      builder: (context, state) {
        final isLoading = state is BlocDashboardStateLoadingPurchase &&
            state.purchaseLoadingId == purchase.id;
        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin:
                  purchase.ignored ? Alignment.centerLeft : Alignment.topLeft,
              end: purchase.ignored
                  ? Alignment.centerRight
                  : Alignment.bottomRight,
              colors: purchase.type == PurchaseType.currentCreditorPurchase
                  ? [
                      const Color(0xff02B3A3),
                      if (purchase.ignored) ...[
                        Colors.grey,
                        Colors.grey,
                      ] else ...[
                        const Color(0xff02B3A3),
                        const Color.fromARGB(255, 41, 255, 237),
                      ],
                    ]
                  : [
                      const Color(0xffFF6B6B),
                      if (purchase.ignored) ...[
                        Colors.grey,
                        Colors.grey,
                      ] else ...[
                        const Color(0xffFF6B6B),
                        const Color.fromARGB(255, 228, 21, 21),
                      ],
                    ],
            ),
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
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          if (purchase.image != null)
                            Image.network(
                              purchase.image!,
                              width: 100,
                              height: 100,
                            ),
                          if (purchase.type.isCurrent)
                            Row(
                              children: [
                                Checkbox(
                                  value: purchase.ignored,
                                  onChanged: (value) {
                                    context.read<BlocDashboard>().add(
                                          // ignore: lines_longer_than_80_chars asd
                                          BlocDashboardEventAlternateIgnorePurchase(
                                            purchaseId: purchase.id ?? '',
                                          ),
                                        );
                                  },
                                ),
                                const Text(
                                  'ignorar',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    purchase.nameOfProduct.capitalize,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () => _editPurchase(
                                      context,
                                      financialEntity,
                                      purchase,
                                    ),
                                    child: const Icon(
                                      Icons.settings,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (!purchase.type.isCurrent)
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Fecha de finalización: '
                                    '${purchase.lastQuotaDate}',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 14,
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
                                  'Total: ${purchase.totalAmount.formatAmount}'
                                  '${purchase.currency.name}',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    decoration: !purchase.type.isCurrent
                                        ? TextDecoration.lineThrough
                                        : null,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${purchase.amountOfQuotas} '
                                  'cuotas de ${purchase.amountPerQuota.formatAmount}'
                                  '${purchase.currency.name}',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    decoration: !purchase.type.isCurrent
                                        ? TextDecoration.lineThrough
                                        : null,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Cuotas a pagar '
                                  '${purchase.amountOfQuotas - purchase.quotasPayed}',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    decoration: !purchase.type.isCurrent
                                        ? TextDecoration.lineThrough
                                        : null,
                                  ),
                                ),
                                if (purchase.type.isCurrent)
                                  const Row(
                                    // ignore: avoid_redundant_argument_values as
                                    children: [
                                      // GestureDetector(
                                      //onTap: () => context.read<BlocDashboard>().add
                                      //(
                                      //     BlocDashboardEventIncreaseAmountOfQuotas(
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
                                    ],
                                  )
                                else
                                  GestureDetector(
                                    onTap: () =>
                                        context.read<BlocDashboard>().add(
                                              BlocDashboardEventIncreaseAmountOfQuotas(
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
                            PMButtons(
                              isEnabled: !purchase.ignored,
                              onTap: () {
                                if (!purchase.ignored) {
                                  context.read<BlocDashboard>().add(
                                        BlocDashboardEventPayQuota(
                                          idPurchase: purchase.id ?? '',
                                          purchaseType: purchase.type,
                                        ),
                                      );
                                }
                              },
                              content: Text(
                                'Pagar cuota',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  decoration: purchase.ignored
                                      ? TextDecoration.lineThrough
                                      : TextDecoration.none,
                                ),
                              ),
                            ),
                          ],
                        ),
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
      },
    );
  }
}
