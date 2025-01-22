import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purchase_manager/features/dashboard/bloc/bloc_dashboard.dart';
import 'package:purchase_manager/utilities/models/enums/currency_type.dart';
import 'package:purchase_manager/utilities/models/enums/purchase_type.dart';
import 'package:purchase_manager/utilities/models/financial_entity.dart';
import 'package:purchase_manager/utilities/models/purchase.dart';
import 'package:purchase_manager/utilities/widgets/dialogs/delete_image_dialog.dart';
import 'package:purchase_manager/utilities/widgets/dialogs/upload_image_dialog.dart';
import 'package:purchase_manager/utilities/widgets/pm_buttons.dart';
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
  List<bool> _currency = <bool>[true, false];

  final _controllerProductName = TextEditingController();

  final _controllerQuotas = TextEditingController();

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
            productName: _controllerProductName.text,
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
                : CurrencyType.usDollar,
          ),
        );
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    _controllerProductName.text = widget.purchase.nameOfProduct;
    _controllerAmount.text = widget.purchase.totalAmount.toString();
    _controllerQuotas.text = widget.purchase.amountOfQuotas.toString();
    _debtorOrCreditor = [
      widget.purchase.type.isDebtor,
      !widget.purchase.type.isDebtor,
    ];
    _currency = [
      widget.purchase.currency == CurrencyType.pesoArgentino,
      !(widget.purchase.currency == CurrencyType.pesoArgentino),
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
                // PMDropdown<FinancialEntity>(
                //   initialItem: PMDropdownItem(
                //     value: widget.financialEntity,
                //     text: widget.financialEntity.name,
                //   ),
                //   hintText: 'Elegi una entidad financiera',
                //   items: state.financialEntityList
                //       .map(
                //         (financialEntity) => PMDropdownItem(
                //           value: financialEntity,
                //           text: financialEntity.name,
                //         ),
                //       )
                //       .toList(),
                //   onChanged: (value) => setState(
                //     () => idSelectedFinancialEntity = value?.value.id,
                //   ),
                // ),
                // const SizedBox(height: 10),
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
                // if (state.images.isEmpty)
                //   GestureDetector(
                //     onTap: () => addImageDialog(context),
                //     child: Container(
                //       decoration: BoxDecoration(
                //         border: Border.all(color: const Color(0xff02B4A3)),
                //         borderRadius:
                //             const BorderRadius.all(Radius.circular(20)),
                //       ),
                //       child: const Center(
                //         child: Icon(
                //           Icons.camera_alt_outlined,
                //           size: 150,
                //           color: Color(0xff02B4A3),
                //         ),
                //       ),
                //     ),
                //   )
                // else
                //   Image.file(
                //     File(state.images[0].path),
                //     height: 150,
                //   ),

                if (widget.purchase.image != null)
                  Image.file(
                    File(state.images[0].path),
                    height: 150,
                  ),
                // const SizedBox(height: 10),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     if (state.images.isNotEmpty)
                //       PMButtons.text(
                //         isEnabled: state.images.isNotEmpty,
                //         onTap: () => removeImageDialog(context),
                //         text: 'Eliminar',
                //         backgroundColor: Colors.red,
                //       ),
                //     if (state.images.isEmpty)
                //       PMButtons.text(
                //         backgroundColor: const Color(0xff02B4A3),
                //         isEnabled: true,
                //         onTap: () {
                //           addImageDialog(context);
                //         },
                //         text: 'Agregar imagen',
                //       ),
                //   ],
                // ),
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
