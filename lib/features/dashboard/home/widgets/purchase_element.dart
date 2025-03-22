import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purchase_manager/features/dashboard/bloc/bloc_dashboard.dart';
import 'package:purchase_manager/utilities/extensions/date_time.dart';
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

        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: SizedBox(
            width: kIsWeb ? 400 : double.infinity,
            child: IntrinsicHeight(
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        duration: Durations.long4,
                        backgroundColor: purchase.purchaseType ==
                                PurchaseType.currentCreditorPurchase
                            ? const Color.fromARGB(255, 0, 189, 25)
                            : const Color.fromARGB(255, 255, 81, 81),
                        content: Text(
                          purchase.purchaseType ==
                                      PurchaseType.currentCreditorPurchase ||
                                  purchase.purchaseType ==
                                      PurchaseType.settledCreditorPurchase
                              ? 'Te deben'
                              : 'Debes',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    child: Stack(
                      children: [
                        Container(
                          width: 25,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                            ),
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: purchase.purchaseType ==
                                      PurchaseType.currentCreditorPurchase
                                  ? [
                                      const Color.fromARGB(255, 0, 189, 25),
                                      const Color.fromARGB(255, 0, 145, 19),
                                    ]
                                  : [
                                      const Color.fromARGB(255, 255, 81, 81),
                                      const Color.fromARGB(255, 228, 21, 21),
                                    ],
                            ),
                          ),
                        ),
                        if (purchase.ignored)
                          Container(
                            width: 25,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                              ),
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.grey.withValues(alpha: .55),
                                  Colors.grey.withValues(alpha: .55),
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        gradient: LinearGradient(
                          begin: Alignment.centerRight,
                          end: Alignment.centerLeft,
                          colors: purchase.ignored
                              ? [
                                  const Color.fromARGB(255, 255, 255, 255),
                                  const Color.fromARGB(255, 255, 255, 255),
                                  Colors.grey,
                                ]
                              : [
                                  const Color.fromARGB(255, 255, 255, 255),
                                  const Color.fromARGB(255, 255, 255, 255),
                                ],
                        ),
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 10,
                        ),
                        child: Stack(
                          children: [
                            Visibility(
                              visible: !isLoading,
                              maintainSize: true,
                              maintainAnimation: true,
                              maintainState: true,
                              child: IntrinsicHeight(
                                child: Row(
                                  children: [
                                    if (purchase.image != null)
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8),
                                        child: GestureDetector(
                                          onTap: () => showDialog<void>(
                                            context: context,
                                            builder: (context) => Dialog(
                                              child: SizedBox(
                                                child: Image.network(
                                                  purchase.image!,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),
                                          child: Image.network(
                                            purchase.image!,
                                            width: 80,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    Campos(
                                      purchase: purchase,
                                      financialEntity: financialEntity,
                                    ),
                                  ],
                                ),
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
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

/// {@template Campos}
/// Campos de la compra
///
/// Purchase fields
/// {@endtemplate}
class Campos extends StatelessWidget {
  /// {@macro Campos}
  const Campos({
    required this.purchase,
    required this.financialEntity,
    super.key,
  });

  /// Compra a mostrar
  ///
  /// Purchase to show
  final Purchase purchase;

  /// Entidad financiera a la que pertenece la compra
  ///
  /// Financial entity to which the purchase belongs
  final FinancialEntity financialEntity;

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

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(left: 8),
        child: DefaultTextStyle(
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      purchase.name.capitalize,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 18,
                      ),
                    ),
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () => _editPurchase(
                            context,
                            financialEntity,
                            purchase,
                          ),
                          child: const Icon(
                            Icons.settings_outlined,
                          ),
                        ),
                        SizedBox(
                          height: 24,
                          width: 24,
                          child: Checkbox(
                            value: purchase.ignored,
                            activeColor: const Color(0xff02B3A3),
                            checkColor: Colors.white,
                            onChanged: (value) {
                              if (value ?? false) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    duration: Durations.long4,
                                    backgroundColor: Colors.grey,
                                    content: Text(
                                      'Compra ignorada',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    duration: Durations.long4,
                                    backgroundColor: Colors.grey,
                                    content: Text(
                                      'La compra ya no está ignorada',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                );
                              }
                              context.read<BlocDashboard>().add(
                                    BlocDashboardEventAlternateIgnorePurchase(
                                      purchaseId: purchase.id,
                                    ),
                                  );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              if (!purchase.purchaseType.isCurrent)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: DetailField(
                    value: purchase.finalizationDate?.formatWithHour,
                    hint: 'Fecha de finalización:',
                    isLoading: false,
                  ),
                ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    DetailField(
                      value: '${purchase.amount.formatAmount}'
                          '${purchase.currencyType.abreviation}',
                      hint: 'Total:',
                      isLoading: false,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${purchase.numberOfQuotas} '
                      'cuotas x ${purchase.amountPerQuota.formatAmount} '
                      '${purchase.currencyType.abreviation}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DetailField(
                    value: (purchase.numberOfQuotas - purchase.payedQuotas)
                        .toString(),
                    hint: 'Restantes:',
                    isLoading: false,
                  ),
                  if (!purchase.purchaseType.isCurrent)
                    GestureDetector(
                      onTap: () => context.read<BlocDashboard>().add(
                            BlocDashboardEventIncreaseAmountOfQuotas(
                              purchaseId: purchase.id,
                              purchaseType: purchase.purchaseType,
                            ),
                          ),
                      child: const Icon(
                        Icons.restore,
                        size: 25,
                        color: Colors.black,
                      ),
                    ),
                  // const Row(
                  // children: [
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
                  // ],
                  // ),
                ],
              ),
              if (purchase.purchaseType.isCurrent)
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    PMButtons.text(
                      backgroundColor: !purchase.ignored
                          ? const Color(0xff02B3A3)
                          : Colors.grey.withValues(alpha: 0.5),
                      isEnabled: true,
                      onTap: () {
                        if (!purchase.ignored) {
                          context.read<BlocDashboard>().add(
                                BlocDashboardEventPayQuota(
                                  idPurchase: purchase.id,
                                  purchaseType: purchase.purchaseType,
                                ),
                              );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              duration: Durations.long4,
                              backgroundColor: Colors.grey,
                              content: Text(
                                'No puedes pagar una compra ignorada',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          );
                        }
                      },
                      text: 'Pagar',
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}

/// {@template DetailField}
/// Campo de detalle
///
/// Detail field
/// {@endtemplate}
class DetailField extends StatelessWidget {
  /// {@macro ShipmentDetailsField}
  const DetailField({
    required this.value,
    required this.hint,
    required this.isLoading,
    super.key,
  });

  /// The value of the field
  final String? value;

  /// The hint of the field
  final String hint;

  /// If the field is loading
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 4),
          child: Text(
            hint,
            style: const TextStyle(
              fontSize: 15,
              color: Colors.black,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        Flexible(
          child: Text(
            value == '' || value == null ? 'No especificado' : value!,
            style: const TextStyle(
              fontSize: 13,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
