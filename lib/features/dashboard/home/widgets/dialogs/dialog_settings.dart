import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purchase_manager/features/dashboard/bloc/bloc_dashboard.dart';
import 'package:purchase_manager/utilities/models/enums/currency_type.dart';
import 'package:purchase_manager/utilities/widgets/pm_dialogs.dart';

/// {@template DialogSettings}
/// Dialog para eliminar una compra
///
/// Dialog to delete a purchase
/// {@endtemplate}
class DialogSettings extends StatefulWidget {
  /// {@macro DialogSettings}
  const DialogSettings({
    super.key,
  });

  @override
  State<DialogSettings> createState() => _DialogSettingsState();
}

class _DialogSettingsState extends State<DialogSettings> {
  List<bool> _currency = <bool>[true, false, false];

  @override
  void initState() {
    super.initState();
    final state = context.read<BlocDashboard>().state;
    _currency = [
      state.selectedCurrency.isPesoArgentino,
      state.selectedCurrency.isDolar,
      state.selectedCurrency.isEuro,
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PMDialogs.actionRequest(
      onTapConfirm: () {
        context.read<BlocDashboard>().add(
              BlocDashboardEventSelectCurrency(
                selectedCurrency: _currency[0]
                    ? CurrencyType.pesoArgentino
                    : _currency[1]
                        ? CurrencyType.usDollar
                        : CurrencyType.euro,
              ),
            );

        Navigator.pop(context);
      },
      content: ToggleButtons(
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
        fillColor: const Color(0xff02B4A3).withValues(alpha: 0.3),
        color: Colors.grey,
        constraints: const BoxConstraints(
          minHeight: 40,
          minWidth: 50,
        ),
        isSelected: _currency,
        children: const [
          Text('ARS'),
          Text('USD'),
          Text('EUR'),
        ],
      ),
      title: 'Elejir moneda',
      isEnabled: true,
    );
  }
}
