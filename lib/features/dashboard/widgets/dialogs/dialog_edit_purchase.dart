import 'package:purchase_manager/features/dashboard/bloc/bloc_dashboard.dart';
import 'package:purchase_manager/features/dashboard/widgets/dialogs/dialog_delete_purchase.dart';
import 'package:purchase_manager/models/enums/purchase_type.dart';
import 'package:purchase_manager/models/financial_entity.dart';
import 'package:purchase_manager/models/purchase.dart';
import 'package:purchase_manager/widgets/pm_buttons.dart';
import 'package:purchase_manager/widgets/pm_dialogs.dart';
import 'package:purchase_manager/widgets/pm_textfields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DialogEditPurchase extends StatefulWidget {
  const DialogEditPurchase({
    required this.purchase,
    required this.financialEntity,
    super.key,
  });

  final Purchase purchase;
  final FinancialEntity financialEntity;

  @override
  State<DialogEditPurchase> createState() => _DialogEditPurchaseState();
}

class _DialogEditPurchaseState extends State<DialogEditPurchase> {
  List<bool> _debtorOrCreditor = <bool>[true, false];

  final _controllerProductName = TextEditingController();

  final _controllerQuotas = TextEditingController();

  final _controllerAmount = TextEditingController();

  void _editPurchase() {
    context.read<BlocDashboard>().add(
          BlocDashboardEventEditPurchase(
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
          ),
        );

    Navigator.pop(context);
  }

  Future<void> _confirmDeletePurchase(BuildContext context) {
    return showDialog(
      context: context,
      builder: (_) => BlocProvider.value(
        value: context.read<BlocDashboard>(),
        child: DialogDeletePurchase(
          idPurchase: widget.purchase.id,
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
      !widget.purchase.type.isDebtor
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
          int.tryParse(_controllerQuotas.text)?.round() != 0,
      onTapConfirm: _editPurchase,
      title: 'Editar compra',
      content: Column(
        children: [
          PMButtons.text(
            onTap: () => _confirmDeletePurchase(context),
            backgroundColor: Colors.redAccent,
            text: 'Eliminar compra',
            isEnabled: true,
          ),
          BlocBuilder<BlocDashboard, BlocDashboardState>(
            builder: (context, state) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xff006F66)),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: DropdownButton<String>(
                  hint: const Text('Elegi Categoria'),
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
            direction: Axis.horizontal,
            onPressed: (int index) {
              setState(() {
                for (int i = 0; i < _debtorOrCreditor.length; i++) {
                  _debtorOrCreditor[i] = i == index;
                }
              });
            },
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            selectedBorderColor: const Color(0xff02B4A3),
            selectedColor: const Color(0xff006F66),
            fillColor: const Color(0xff02B4A3).withOpacity(.3),
            color: Colors.grey,
            constraints: const BoxConstraints(
              minHeight: 40.0,
              minWidth: 130.0,
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
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: PMTextFormFields.onlyNumbers(
              controller: _controllerAmount,
              hintText: 'Monto total',
              onChanged: (value) => setState(() {}),
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
