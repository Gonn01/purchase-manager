import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purchase_manager/extensions/date_time.dart';
import 'package:purchase_manager/extensions/double.dart';
import 'package:purchase_manager/extensions/string.dart';
import 'package:purchase_manager/features/home/bloc/bloc_home.dart';
import 'package:purchase_manager/features/home/widgets/dialogs/dialog_edit_purchase.dart';
import 'package:purchase_manager/models/financial_entity.dart';
import 'package:purchase_manager/models/purchase.dart';

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
                          '${purchase.lastCuotaDate?.formatWithHour}',
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
                    'cuotas de ${purchase.amountPerQuota.formatAmount()}'
                    '${purchase.currency.name}',
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
                        GestureDetector(
                          onTap: () => context.read<BlocHome>().add(
                                BlocHomeEventModifyAmountOfQuotas(
                                  idPurchase: purchase.id,
                                  modificationType: ModificationType.increase,
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
                          onTap: () => context.read<BlocHome>().add(
                                BlocHomeEventModifyAmountOfQuotas(
                                  idPurchase: purchase.id,
                                  modificationType: ModificationType.decrease,
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
                  else
                    GestureDetector(
                      onTap: () => context.read<BlocHome>().add(
                            BlocHomeEventModifyAmountOfQuotas(
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
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
