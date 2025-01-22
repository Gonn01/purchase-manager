import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purchase_manager/features/dashboard/home/bloc/bloc_home.dart';
import 'package:purchase_manager/features/dashboard/home/widgets/dialogs/dialog_delete_purchase.dart';
import 'package:purchase_manager/utilities/models/enums/currency_type.dart';
import 'package:purchase_manager/utilities/models/enums/purchase_type.dart';
import 'package:purchase_manager/utilities/models/financial_entity.dart';
import 'package:purchase_manager/utilities/models/purchase.dart';
import 'package:purchase_manager/utilities/widgets/pm_buttons.dart';
import 'package:purchase_manager/utilities/widgets/pm_dialogs.dart';
import 'package:purchase_manager/utilities/widgets/pm_textfields.dart';

/// {@template DialogEditPurchase}
/// Dialog para editar una compra
///
/// Dialog to edit a purchase
/// {@endtemplate}
class DialogEditPurchase extends StatefulWidget {
  /// {@macro DialogEditPurchase}
  const DialogEditPurchase({
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
  State<DialogEditPurchase> createState() => _DialogEditPurchaseState();
}

class _DialogEditPurchaseState extends State<DialogEditPurchase> {
  List<bool> _debtorOrCreditor = <bool>[true, false];
  List<bool> _currency = <bool>[true, false];

  final _controllerProductName = TextEditingController();

  final _controllerQuotas = TextEditingController();

  final _controllerAmount = TextEditingController();

  void _editPurchase() {
    context.read<BlocHome>().add(
          BlocHomeEventEditPurchase(
            purchase: widget.purchase,
            productName: _controllerProductName.text,
            amount: double.parse(_controllerAmount.text),
            amountOfQuotas: int.parse(_controllerQuotas.text),
            idFinancialEntity: dropdownValue ?? '',
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

  Future<void> _deletePurchase(BuildContext context) {
    return showDialog(
      context: context,
      builder: (_) => BlocProvider.value(
        value: context.read<BlocHome>(),
        child: DialogDeletePurchase(
          purchase: widget.purchase,
          idFinancialEntity: widget.financialEntity.id,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _controllerProductName.text = widget.purchase.nameOfProduct;
    _controllerAmount.text = widget.purchase.totalAmount.toString();
    _controllerQuotas.text = widget.purchase.amountOfQuotas.toString();
    dropdownValue = widget.financialEntity.id;
    _debtorOrCreditor = [
      widget.purchase.type.isDebtor,
      !widget.purchase.type.isDebtor,
    ];
    _currency = [
      widget.purchase.currency == CurrencyType.pesoArgentino,
      !(widget.purchase.currency == CurrencyType.pesoArgentino),
    ];
  }

  @override
  void dispose() {
    _controllerProductName.dispose();
    _controllerQuotas.dispose();
    _controllerAmount.dispose();
    super.dispose();
  }

  String? dropdownValue;
  @override
  Widget build(BuildContext context) {
    return PMDialogs.actionRequest(
      isEnabled: _controllerQuotas.text.isNotEmpty &&
          _controllerAmount.text.isNotEmpty &&
          _controllerProductName.text.isNotEmpty &&
          dropdownValue != null &&
          dropdownValue != '' &&
          double.tryParse(_controllerAmount.text)?.round() != 0 &&
          int.tryParse(_controllerQuotas.text) != 0,
      onTapConfirm: _editPurchase,
      title: 'Editar compra',
      content: Column(
        children: [
          PMButtons.text(
            onTap: () {
              Navigator.pop(context);
              _deletePurchase(context);
            },
            backgroundColor: Colors.redAccent,
            text: 'Eliminar compra',
            isEnabled: true,
          ),
          BlocBuilder<BlocHome, BlocHomeState>(
            builder: (context, state) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xff006F66)),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: DropdownButton<String>(
                  hint: const Text('Elegi una entidad financiera'),
                  value: dropdownValue,
                  elevation: 16,
                  style: const TextStyle(color: Color(0xff02B4A3)),
                  onChanged: (String? value) =>
                      setState(() => dropdownValue = value),
                  items: state.financialEntityList
                      .map<DropdownMenuItem<String>>((FinancialEntity cat) {
                    return DropdownMenuItem<String>(
                      value: cat.id,
                      child: Text(cat.name),
                    );
                  }).toList(),
                ),
              );
            },
          ),
          const SizedBox(height: 10),
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
            fillColor: const Color(0xff02B4A3).withValues(
              alpha: 0.3,
              red: 0x02 / 255,
              green: 0xB4 / 255,
              blue: 0xA3 / 255,
            ),
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
                SizedBox(
                  width: 180,
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
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  selectedBorderColor: const Color(0xff02B4A3),
                  selectedColor: const Color(0xff006F66),
                  fillColor: const Color(0xff02B4A3).withValues(
                    alpha: 0.3,
                    red: 0x02 / 255,
                    green: 0xB4 / 255,
                    blue: 0xA3 / 255,
                  ),
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
        ],
      ),
    );
  }
}
