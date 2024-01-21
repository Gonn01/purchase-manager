import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purchase_manager/features/dashboard/bloc/bloc_dashboard.dart';
import 'package:purchase_manager/models/financial_entity.dart';
import 'package:purchase_manager/widgets/pm_dialogs.dart';
import 'package:purchase_manager/widgets/pm_textfields.dart';

/// {@template DialogCreateFinancialEntity}
/// Dialog para crear una nueva [FinancialEntity]
///
/// Dialog to create a new [FinancialEntity]
/// {@endtemplate}
class DialogCreateFinancialEntity extends StatefulWidget {
  /// {@macro DialogCreateFinancialEntity}
  const DialogCreateFinancialEntity({
    super.key,
  });

  @override
  State<DialogCreateFinancialEntity> createState() =>
      _DialogCreateFinancialEntityState();
}

class _DialogCreateFinancialEntityState
    extends State<DialogCreateFinancialEntity> {
  /// Controlador del textfield para el nombre de la organizacion
  ///
  /// Controller of the textfield for the name of the organization
  final _controller = TextEditingController();

  /// Muestra el dialog para crear una nueva [FinancialEntity]
  ///
  /// Shows the dialog to create a new [FinancialEntity]
  void _crearFinancialEntity({required String nombreCategoria}) {
    if (_controller.text.isNotEmpty) {
      context.read<BlocDashboard>().add(
            BlocDashboardEventCreateFinancialEntity(
              financialEntityName: _controller.text,
            ),
          );
    }
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PMDialogs.actionRequest(
      isEnabled: _controller.text.isNotEmpty,
      onTapConfirm: () => _crearFinancialEntity(
        nombreCategoria: _controller.text,
      ),
      title: 'Crear categoria',
      content: PMTextFormFields.lettersAndNumbers(
        onChanged: (value) => setState(() => _controller.text = value),
        controller: _controller,
        hintText: 'Nombre de la categoria',
      ),
    );
  }
}
