import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purchase_manager/features/dashboard/bloc/bloc_dashboard.dart';
import 'package:purchase_manager/features/dashboard/home/bloc/bloc_home.dart';
import 'package:purchase_manager/features/dashboard/home/widgets/dialogs/dialog_pay_month_alert.dart';
import 'package:purchase_manager/features/dashboard/home/widgets/purchase_element.dart';
import 'package:purchase_manager/gen/assets.gen.dart';
import 'package:purchase_manager/utilities/extensions/double.dart';
import 'package:purchase_manager/utilities/extensions/string.dart';
import 'package:purchase_manager/utilities/functions/share_result.dart';
import 'package:purchase_manager/utilities/models/financial_entity.dart';
import 'package:purchase_manager/utilities/models/purchase.dart';
import 'package:purchase_manager/utilities/widgets/pm_buttons.dart';

/// {@template FinancialEntityElement}
/// Elemento que muestra los datos de una [FinancialEntity]
///
/// Element that shows the data of a [FinancialEntity]
/// {@endtemplate}
class FinancialEntityElement extends StatelessWidget {
  /// {@macro FinancialEntityElement}
  const FinancialEntityElement({
    required this.financialEntity,
    required this.index,
    super.key,
  });

  /// Entidad financiera a mostrar
  ///
  /// Financial entity to show
  final FinancialEntity financialEntity;

  /// Indice de la lista de entidades financieras
  ///
  /// Index of the financial entities list
  final int index;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BlocHome, BlocHomeState>(
      builder: (context, state) {
        var lista = <Purchase>[];
        if (index == 1) {
          lista = state.listPurchaseStatusSettled(financialEntity);
        } else {
          lista = state.listPurchaseStatusCurrent(financialEntity);
        }
        final st = context.read<BlocDashboard>().state;
        final total = st.selectedCurrency.totalAmountPerFinancialEntity(
          purchases: lista,
          currency: st.currency,
        );
        final hasAnyPurchaseToPay = lista.any((element) => !element.ignored);
        return ExpansionTile(
          collapsedBackgroundColor: const Color(0xff02B3A3),
          title: Text(
            financialEntity.name.capitalize,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          collapsedShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          backgroundColor: const Color(0xff006255),
          collapsedIconColor: Colors.white,
          iconColor: Colors.white,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: kIsWeb
                  ? Wrap(
                      children: lista
                          .map(
                            (purchase) => Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: PurchaseElement(
                                purchase: purchase,
                                financialEntity: financialEntity,
                              ),
                            ),
                          )
                          .toList(),
                    )
                  : Column(
                      children: lista
                          .map(
                            (purchase) => PurchaseElement(
                              purchase: purchase,
                              financialEntity: financialEntity,
                            ),
                          )
                          .toList(),
                    ),
            ),
            if (index == 0)
              Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${total.isNegative ? 'Me debe en' : 'Le debo en'} total ${(total.isNegative ? total * -1 : total).formatAmount} ${st.selectedCurrency.abreviation}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (!hasAnyPurchaseToPay) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'No hay compras para pagar',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              backgroundColor: Colors.red,
                            ),
                          );
                          return;
                        }
                        onShareWithResult(
                          context: context,
                          financialEntityName: financialEntity.name,
                          purchases: lista,
                          total:
                              st.selectedCurrency.totalAmountPerFinancialEntity(
                            purchases: lista,
                            currency: st.currency,
                          ),
                          currency: st.currency,
                          selectedCurrency: st.selectedCurrency,
                        );
                      },
                      child: Image.asset(
                        Assets.icons.whatsapp.path,
                        width: 25,
                        height: 25,
                      ),
                    ),
                  ],
                ),
              ),
            if (index == 0)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: PMButtons.text(
                  backgroundColor: const Color(0xff02B3A3),
                  isEnabled: true,
                  onTap: () {
                    if (!hasAnyPurchaseToPay) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'No hay compras para pagar',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          backgroundColor: Colors.red,
                        ),
                      );
                      return;
                    }
                    showDialog<void>(
                      context: context,
                      builder: (_) => BlocProvider.value(
                        value: context.read<BlocDashboard>(),
                        child: DialogPayMonthAlert(
                          financialEntity: financialEntity,
                          purchaseList: lista,
                        ),
                      ),
                    );
                  },
                  text: 'Pagar este mes',
                ),
              ),
          ],
        );
      },
    );
  }
}
