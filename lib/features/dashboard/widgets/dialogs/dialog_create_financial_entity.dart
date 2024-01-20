import 'package:purchase_manager/features/dashboard/bloc/bloc_dashboard.dart';
import 'package:purchase_manager/widgets/pm_dialogs.dart';
import 'package:purchase_manager/widgets/pm_textfields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DialogCreateFinancialEntity extends StatefulWidget {
  /// {@macro DialogAgregarOrganizacion}
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
  final _controller = TextEditingController();

  void _crearCategoria({required String nombreCategoria}) {
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
      onTapConfirm: () => _crearCategoria(nombreCategoria: _controller.text),
      title: 'Crear categoria',
      content: PMTextFormFields.lettersAndNumbers(
        onChanged: (value) => setState(() => _controller.text = value),
        controller: _controller,
        hintText: 'Nombre de la categoria',
      ),
    );
  }
}
