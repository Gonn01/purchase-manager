import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purchase_manager/features/dashboard/bloc/bloc_dashboard.dart';
import 'package:purchase_manager/utilities/models/enums/currency_type.dart';
import 'package:purchase_manager/utilities/models/enums/purchase_type.dart';
import 'package:purchase_manager/utilities/models/financial_entity.dart';
import 'package:purchase_manager/utilities/widgets/dialogs/upload_image_dialog.dart';
import 'package:purchase_manager/utilities/widgets/pm_buttons.dart';
import 'package:purchase_manager/utilities/widgets/pm_dialogs.dart';
import 'package:purchase_manager/utilities/widgets/pm_dropdown.dart';
import 'package:purchase_manager/utilities/widgets/pm_textfields.dart';

/// {@template PMFloatingActionButton}
/// Boton flotante de la aplicacion que permite crear una compra
///
/// Application floating button that allows you to create a purchase
/// {@endtemplate}
class PMFloatingActionButton extends StatefulWidget {
  /// {@macro PMFloatingActionButton}
  const PMFloatingActionButton({
    super.key,
  });

  @override
  State<PMFloatingActionButton> createState() => _PMFloatingActionButtonState();
}

class _PMFloatingActionButtonState extends State<PMFloatingActionButton> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: const Color(0xff02B3A3),
      child: const Icon(
        Icons.add,
        color: Colors.white,
        size: 40,
      ),
      onPressed: () {
        showModalBottomSheet<void>(
          context: context,
          isScrollControlled: true,
          useSafeArea: true,
          builder: (_) {
            return BlocProvider.value(
              value: context.read<BlocDashboard>(),
              child: const CreatePurchaseModal(),
            );
          },
        );
      },
    );
  }
}

/// {@template CreatePurchaseModal}
/// Modal para crear una compra
///
/// Modal to create a purchase
/// {@endtemplate}
class CreatePurchaseModal extends StatefulWidget {
  /// {@macro CreatePurchaseModal}
  const CreatePurchaseModal({
    super.key,
  });

  @override
  State<CreatePurchaseModal> createState() => _CreatePurchaseModalState();
}

class _CreatePurchaseModalState extends State<CreatePurchaseModal> {
  final List<bool> _purchaseType = <bool>[true, false];

  final List<bool> _currency = <bool>[true, false];

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

  void _createPurchase({required FinancialEntity financialEntity}) {
    context.read<BlocDashboard>().add(
          BlocDashboardEventCreatePurchase(
            productName: _controllerProductName.text,
            totalAmount: double.parse(_controllerAmount.text),
            amountQuotas: int.parse(_controllerQuotas.text),
            financialEntity: financialEntity,
            currency: _currency[0]
                ? CurrencyType.pesoArgentino
                : CurrencyType.usDollar,
            purchaseType: _purchaseType[0]
                ? PurchaseType.currentDebtorPurchase
                : PurchaseType.currentCreditorPurchase,
          ),
        );
    Navigator.pop(context);
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
    return BlocBuilder<BlocDashboard, BlocDashboardState>(
      builder: (context, state) {
        return Container(
          color: Colors.white,
          padding: const EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: Column(
              children: [
                PMDropdown<FinancialEntity>(
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
                    () => idSelectedFinancialEntity = value?.value.id,
                  ),
                ),
                const SizedBox(height: 10),
                ToggleButtons(
                  onPressed: (int index) {
                    setState(() {
                      for (var i = 0; i < _purchaseType.length; i++) {
                        _purchaseType[i] = i == index;
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
                  isSelected: _purchaseType,
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
                if (state.images.isEmpty)
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
                else
                  Image.file(
                    File(state.images[0].path),
                    height: 150,
                  ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (state.images.isNotEmpty)
                      PMButtons.text(
                        isEnabled: state.images.isNotEmpty,
                        onTap: () => removeImageDialog(context),
                        text: 'Eliminar',
                        backgroundColor: Colors.red,
                      ),
                    if (state.images.isEmpty)
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
                      onTap: () => _createPurchase(
                        financialEntity: state.financialEntityList.firstWhere(
                          (financialEntity) =>
                              financialEntity.id == idSelectedFinancialEntity,
                        ),
                      ),
                      text: 'Agregar compra',
                      backgroundColor: Colors.green,
                    ),
                    const Spacer(),
                  ],
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        );
      },
    );
  }
}

/// {@template DialogDeleteImage}
/// Dialog to confirm the deletion of an image
/// {@endtemplate}
class DialogDeleteImage extends StatelessWidget {
  /// {@macro DialogDeleteImage}
  const DialogDeleteImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PMDialogs.actionRequest(
      content: const Text('¿Estás seguro que deseas eliminar la imagen?'),
      onTapConfirm: () {
        context.read<BlocDashboard>().add(
              const BlocDashboardEventDeleteImageAt(
                index: 0,
              ),
            );
        Navigator.pop(context);
      },
      title: 'Eliminar imagen',
      isEnabled: true,
    );
  }
}
