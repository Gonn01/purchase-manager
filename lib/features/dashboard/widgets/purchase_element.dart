import 'package:purchase_manager/extensions/double.dart';
import 'package:purchase_manager/extensions/string.dart';
import 'package:purchase_manager/features/dashboard/bloc/bloc_dashboard.dart';
import 'package:purchase_manager/features/dashboard/widgets/dialogs/dialog_edit_purchase.dart';
import 'package:purchase_manager/models/financial_entity.dart';
import 'package:purchase_manager/models/purchase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class PurchaseElement extends StatelessWidget {
  const PurchaseElement({
    required this.purchase,
    required this.financialEntity,
    super.key,
  });

  final Purchase purchase;
  final FinancialEntity financialEntity;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: const Color(0xff02B3A3),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                    onTap: () => showDialog(
                      context: context,
                      builder: (_) => BlocProvider.value(
                        value: context.read<BlocDashboard>(),
                        child: DialogEditPurchase(
                          purchase: purchase,
                          financialEntity: financialEntity,
                        ),
                      ),
                    ),
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
                      ? 'Total: ${purchase.totalAmount.formatAmount()}${purchase.currency.name}'
                      : 'Fecha de finalización: ${DateFormat('dd/MM/yyyy').format(purchase.lastCuotaDate ?? purchase.creationDate)}',
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
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${purchase.amountOfQuotas} '
                    'cuotas de ${purchase.amountPerQuota.formatAmount()}${purchase.currency.name}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        decoration: !purchase.type.isCurrent
                            ? TextDecoration.lineThrough
                            : null),
                  ),
                  purchase.type.isCurrent
                      ? Row(
                          children: [
                            GestureDetector(
                              onTap: () => context.read<BlocDashboard>().add(
                                    BlocDashboardEventModifyAmountOfQuotas(
                                      idPurchase: purchase.id,
                                      modificationType:
                                          ModificationType.increase,
                                      purchaseType: purchase.type,
                                    ),
                                  ),
                              child: const Icon(
                                Icons.keyboard_double_arrow_up_sharp,
                                size: 25,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(width: 10),
                            GestureDetector(
                              onTap: () => context.read<BlocDashboard>().add(
                                    BlocDashboardEventModifyAmountOfQuotas(
                                      idPurchase: purchase.id,
                                      modificationType:
                                          ModificationType.decrease,
                                      purchaseType: purchase.type,
                                    ),
                                  ),
                              child: const Icon(
                                Icons.keyboard_double_arrow_down_sharp,
                                size: 25,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        )
                      : GestureDetector(
                          onTap: () => context.read<BlocDashboard>().add(
                                BlocDashboardEventModifyAmountOfQuotas(
                                  idPurchase: purchase.id,
                                  modificationType: ModificationType.increase,
                                  purchaseType: purchase.type,
                                ),
                              ),
                          child: const Icon(
                            Icons.restore,
                            size: 25,
                            color: Colors.white,
                          ),
                        )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
