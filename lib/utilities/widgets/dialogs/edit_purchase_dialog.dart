import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purchase_manager/features/dashboard/bloc/bloc_dashboard.dart';
import 'package:purchase_manager/features/dashboard/home/widgets/dialogs/dialog_delete_purchase.dart';
import 'package:purchase_manager/utilities/models/enums/currency_type.dart';
import 'package:purchase_manager/utilities/models/enums/purchase_type.dart';
import 'package:purchase_manager/utilities/models/financial_entity.dart';
import 'package:purchase_manager/utilities/models/purchase.dart';
import 'package:purchase_manager/utilities/widgets/dialogs/delete_image_dialog.dart';
import 'package:purchase_manager/utilities/widgets/dialogs/upload_image_dialog.dart';
import 'package:purchase_manager/utilities/widgets/pm_buttons.dart';
import 'package:purchase_manager/utilities/widgets/pm_dropdown.dart';
import 'package:purchase_manager/utilities/widgets/pm_textfields.dart';

/// {@template EditPurchaseModal}
/// Modal para editar una compra
///
/// Modal to edit a purchase
/// {@endtemplate}
class EditPurchaseModal extends StatefulWidget {
  /// {@macro EditPurchaseModal}
  const EditPurchaseModal({
    required this.purchase,
    required this.financialEntity,
    super.key,
  });

  /// Compra a editar
  ///
  /// Purchase to edit
  final Purchase purchase;

  /// Entidad financiera a la que pertenece la compra
  ///
  /// Financial entity to which the purchase belongs
  final FinancialEntity financialEntity;
  @override
  State<EditPurchaseModal> createState() => _EditPurchaseModalState();
}

class _EditPurchaseModalState extends State<EditPurchaseModal> {
  List<bool> _debtorOrCreditor = <bool>[true, false];
  List<bool> _currency = <bool>[true, false, false];

  final _controllerProductName = TextEditingController();

  final _controllerQuotas = TextEditingController();
  final _controllerPayedQuotas = TextEditingController();

  final _controllerAmount = TextEditingController();

  void addImageDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (_) => BlocProvider.value(
        value: context.read<BlocDashboard>(),
        child: UploadImageDialog(
          onImageSelected: (value) {
            context.read<BlocDashboard>().add(
                  BlocDashboardEventAddImage(image: value),
                );
          },
        ),
      ),
    );
  }

  void _editPurchase({required FinancialEntity financialEntity}) {
    context.read<BlocDashboard>().add(
          BlocDashboardEventEditPurchase(
            purchase: widget.purchase,
            name: _controllerProductName.text,
            amount: double.parse(_controllerAmount.text),
            amountOfQuotas: int.parse(_controllerQuotas.text),
            idFinancialEntity: widget.financialEntity.id,
            purchaseType: widget.purchase.type.isCurrent
                ? _debtorOrCreditor[0]
                    ? PurchaseType.currentDebtorPurchase
                    : PurchaseType.currentCreditorPurchase
                : !_debtorOrCreditor[0]
                    ? PurchaseType.settledDebtorPurchase
                    : PurchaseType.settledCreditorPurchase,
            currency: _currency[0]
                ? CurrencyType.pesoArgentino
                : _currency[1]
                    ? CurrencyType.usDollar
                    : CurrencyType.euro,
            isFixedExpenses: widget.purchase.fixedExpense,
            payedQuotas: int.parse(_controllerPayedQuotas.text),
            ignored: widget.purchase.ignored,
            image: context.read<BlocDashboard>().state.images.isNotEmpty
                ? context.read<BlocDashboard>().state.images[0].path
                : '',
          ),
        );
    Navigator.pop(context);
  }

  int idSelectedFinancialEntity = 0;
  bool isFixedExpense = false;
  bool ignored = false;
  @override
  void initState() {
    super.initState();
    idSelectedFinancialEntity = widget.financialEntity.id;
    _controllerPayedQuotas.text = widget.purchase.payedQuotas.toString();
    isFixedExpense = widget.purchase.fixedExpense;
    ignored = widget.purchase.ignored;
    _controllerProductName.text = widget.purchase.name;
    _controllerAmount.text = widget.purchase.amount.toString();
    _controllerQuotas.text = widget.purchase.numberOfQuotas.toString();
    _debtorOrCreditor = [
      widget.purchase.type.isDebtor,
      !widget.purchase.type.isDebtor,
    ];
    _currency = [
      widget.purchase.currencyType.isPesoArgentino,
      widget.purchase.currencyType.isDolar,
      widget.purchase.currencyType.isEuro,
    ];
  }

  void removeImageDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (_) => BlocProvider.value(
        value: context.read<BlocDashboard>(),
        child: const DialogDeleteImage(),
      ),
    );
  }

  @override
  void dispose() {
    _controllerProductName.dispose();
    _controllerQuotas.dispose();
    _controllerAmount.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BlocDashboard, BlocDashboardState>(
      builder: (context, state) {
        return Container(
          color: Colors.white,
          padding: const EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: Column(
              children: [
                PMDropdown<FinancialEntity>(
                  initialItem: PMDropdownItem(
                    value: widget.financialEntity,
                    text: widget.financialEntity.name,
                  ),
                  hintText: 'Elegi una entidad financiera',
                  items: state.financialEntityList
                      .map(
                        (financialEntity) => PMDropdownItem(
                          value: financialEntity,
                          text: financialEntity.name,
                        ),
                      )
                      .toList(),
                  onChanged: (value) => setState(
                    () => idSelectedFinancialEntity =
                        value?.value.id ?? widget.financialEntity.id,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(
                      Icons.delete_outline,
                      color: Colors.transparent,
                    ),
                    ToggleButtons(
                      onPressed: (int index) {
                        setState(() {
                          for (var i = 0; i < _debtorOrCreditor.length; i++) {
                            _debtorOrCreditor[i] = i == index;
                          }
                        });
                      },
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      selectedBorderColor: const Color(0xff02B4A3),
                      selectedColor: const Color(0xff006F66),
                      fillColor: const Color(0xff02B4A3).withValues(alpha: 0.3),
                      color: Colors.grey,
                      constraints: const BoxConstraints(
                        minHeight: 40,
                        minWidth: 130,
                      ),
                      isSelected: _debtorOrCreditor,
                      children: const [
                        Text('Debo'),
                        Text('Me deben'),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        showDialog<void>(
                          context: context,
                          builder: (context) => DialogDeletePurchase(
                            purchase: widget.purchase,
                            idFinancialEntity: widget.financialEntity.id,
                          ),
                        ).then((value) {
                          // ignore: use_build_context_synchronously asd
                          Navigator.pop(context);
                        });
                      },
                      child: const Icon(
                        Icons.delete_outline,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Checkbox(
                      value: isFixedExpense,
                      onChanged: (bool? value) {
                        setState(() {
                          isFixedExpense = value ?? false;
                        });
                      },
                    ),
                    const Text('Es un gasto fijo'),
                  ],
                ),
                Row(
                  children: [
                    Checkbox(
                      value: ignored,
                      onChanged: (bool? value) {
                        setState(() {
                          ignored = value ?? false;
                        });
                      },
                    ),
                    const Text('Ignorar'),
                  ],
                ),
                const SizedBox(height: 10),
                PMTextFormFields.lettersAndNumbers(
                  controller: _controllerProductName,
                  hintText: 'Producto',
                  onChanged: (value) => setState(() {}),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                  ),
                  child: Row(
                    children: [
                      Flexible(
                        child: PMTextFormFields.onlyNumbers(
                          controller: _controllerAmount,
                          hintText: 'Monto total',
                          onChanged: (value) => setState(() {}),
                        ),
                      ),
                      const SizedBox(width: 10),
                      ToggleButtons(
                        onPressed: (int index) {
                          setState(() {
                            for (var i = 0; i < _currency.length; i++) {
                              _currency[i] = i == index;
                            }
                          });
                        },
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                        selectedBorderColor: const Color(0xff02B4A3),
                        selectedColor: const Color(0xff006F66),
                        fillColor:
                            const Color(0xff02B4A3).withValues(alpha: 0.3),
                        color: Colors.grey,
                        constraints: const BoxConstraints(
                          minHeight: 40,
                          minWidth: 40,
                        ),
                        isSelected: _currency,
                        children: const [
                          Text('ARS'),
                          Text('USD'),
                          Text('EUR'),
                        ],
                      ),
                    ],
                  ),
                ),
                PMTextFormFields.onlyNumbers(
                  controller: _controllerQuotas,
                  hintText: 'Cantidad de cuotas',
                  onChanged: (value) => setState(() {}),
                ),
                const SizedBox(height: 10),
                if (state.images.isEmpty && widget.purchase.image == null)
                  GestureDetector(
                    onTap: () => addImageDialog(context),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xff02B4A3)),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.camera_alt_outlined,
                          size: 150,
                          color: Color(0xff02B4A3),
                        ),
                      ),
                    ),
                  )
                else if (state.images.isNotEmpty)
                  Image.file(
                    File(state.images[0].path),
                    height: 150,
                  )
                else
                  Image.network(
                    widget.purchase.image!,
                    height: 150,
                  ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    PMButtons.text(
                      isEnabled: state.images.isNotEmpty,
                      onTap: () => removeImageDialog(context),
                      text: 'Eliminar',
                      backgroundColor: Colors.red,
                    ),
                    PMButtons.text(
                      backgroundColor: const Color(0xff02B4A3),
                      isEnabled: true,
                      onTap: () {
                        addImageDialog(context);
                      },
                      text: 'Agregar imagen',
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Spacer(),
                    PMButtons.text(
                      isEnabled: true,
                      onTap: () => Navigator.pop(context),
                      text: 'Cancelar',
                      backgroundColor: Colors.red,
                    ),
                    const Spacer(),
                    PMButtons.text(
                      isEnabled: true,
                      onTap: () => _editPurchase(
                        financialEntity: widget.financialEntity,
                      ),
                      text: 'Editar compra',
                      backgroundColor: Colors.green,
                    ),
                    const Spacer(),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
