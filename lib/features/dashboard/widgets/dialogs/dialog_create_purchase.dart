import 'package:purchase_manager/features/dashboard/bloc/bloc_dashboard.dart';
import 'package:purchase_manager/models/enums/purchase_type.dart';
import 'package:purchase_manager/models/financial_entity.dart';
import 'package:purchase_manager/widgets/pm_dialogs.dart';
import 'package:purchase_manager/widgets/pm_textfields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DialogCreatePurchase extends StatefulWidget {
  const DialogCreatePurchase({
    required this.current,
    super.key,
  });
  final bool current;
  @override
  State<DialogCreatePurchase> createState() => _DialogCreatePurchaseState();
}

class _DialogCreatePurchaseState extends State<DialogCreatePurchase> {
  final List<bool> _selectedItems = <bool>[true, false];

  final _controllerProductName = TextEditingController();

  final _controllerQuotas = TextEditingController();

  final _controllerAmount = TextEditingController();

  void _createPurchase() {
    context.read<BlocDashboard>().add(
          BlocDashboardEventCreatePurchase(
            productName: _controllerProductName.text,
            totalAmount: double.parse(_controllerAmount.text),
            amountQuotas: int.parse(_controllerQuotas.text),
            idFinancialEntity: idSelectedFinancialEntity ?? '',
            purchaseType: _selectedItems[0]
                ? widget.current
                    ? PurchaseType.currentDebtorPurchase
                    : PurchaseType.settledDebtorPurchase
                : !widget.current
                    ? PurchaseType.currentCreditorPurchase
                    : PurchaseType.settledCreditorPurchase,
          ),
        );
    Navigator.pop(context);
  }

  String? idSelectedFinancialEntity;

  @override
  void dispose() {
    _controllerProductName.dispose();
    _controllerQuotas.dispose();
    _controllerAmount.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PMDialogs.actionRequest(
      isEnabled: _controllerQuotas.text.isNotEmpty &&
          _controllerAmount.text.isNotEmpty &&
          _controllerProductName.text.isNotEmpty &&
          idSelectedFinancialEntity != null &&
          idSelectedFinancialEntity != '' &&
          double.tryParse(_controllerAmount.text)?.round() != 0 &&
          int.tryParse(_controllerQuotas.text)?.round() != 0,
      onTapConfirm: _createPurchase,
      title: 'Crear compra',
      content: Column(
        children: [
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
                  value: idSelectedFinancialEntity,
                  elevation: 16,
                  style: const TextStyle(color: Color(0xff02B4A3)),
                  onChanged: (String? value) =>
                      setState(() => idSelectedFinancialEntity = value),
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
                for (int i = 0; i < _selectedItems.length; i++) {
                  _selectedItems[i] = i == index;
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
            isSelected: _selectedItems,
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
