import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purchase_manager/features/home/bloc/bloc_home.dart';
import 'package:purchase_manager/utilities/models/enums/currency_type.dart';
import 'package:purchase_manager/utilities/models/enums/feature_type.dart';
import 'package:purchase_manager/utilities/models/enums/purchase_type.dart';
import 'package:purchase_manager/utilities/models/financial_entity.dart';
import 'package:purchase_manager/utilities/widgets/dialogs/upload_image_dialog.dart';
import 'package:purchase_manager/utilities/widgets/pm_buttons.dart';
import 'package:purchase_manager/utilities/widgets/pm_dialogs.dart';
import 'package:purchase_manager/utilities/widgets/pm_textfields.dart';

/// {@template PMFloatingActionButton}
/// Boton flotante de la aplicacion que permite crear una compra
///
/// Application floating button that allows you to create a purchase
/// {@endtemplate}
class PMFloatingActionButton extends StatefulWidget {
  /// {@macro PMFloatingActionButton}
  const PMFloatingActionButton({
    required this.type,
    super.key,
  });

  /// Tipo de feature
  final FeatureType type;

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
              value: context.read<BlocHome>(),
              child: CreatePurchaseModal(
                current: widget.type != FeatureType.settled,
              ),
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
    required this.current,
    super.key,
  });

  /// Indica si la compra es actual o liquidada
  ///
  /// Indicates if the purchase is current or settled
  final bool current;
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
        value: context.read<BlocHome>(),
        child: UploadImageDialog(
          onImageSelected: (value) {
            context.read<BlocHome>().add(
                  BlocHomeEventAddImage(image: value),
                );
          },
        ),
      ),
    );
  }

  void _createPurchase({required FinancialEntity financialEntity}) {
    context.read<BlocHome>().add(
          BlocHomeEventCreatePurchase(
            productName: _controllerProductName.text,
            totalAmount: double.parse(_controllerAmount.text),
            amountQuotas: int.parse(_controllerQuotas.text),
            financialEntity: financialEntity,
            currency: _currency[0]
                ? CurrencyType.pesoArgentino
                : CurrencyType.usDollar,
            purchaseType: widget.current
                ? _purchaseType[0]
                    ? PurchaseType.currentDebtorPurchase
                    : PurchaseType.currentCreditorPurchase
                : _purchaseType[0]
                    ? PurchaseType.settledDebtorPurchase
                    : PurchaseType.settledCreditorPurchase,
          ),
        );
    Navigator.pop(context);
  }

  void removeImageDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (_) => BlocProvider.value(
        value: context.read<BlocHome>(),
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
    return BlocBuilder<BlocHome, BlocHomeState>(
      builder: (context, state) {
        return Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xff006F66)),
                borderRadius: BorderRadius.circular(8),
              ),
              child: DropdownButton<String>(
                hint: const Text('Elegi una entidad financiera'),
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: state.images.isEmpty
                  ? GestureDetector(
                      onTap: () => addImageDialog(context),
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(25),
                          child: Center(
                            child: Icon(
                              Icons.camera_alt_outlined,
                              size: 150,
                              color: Colors.lightBlue,
                            ),
                          ),
                        ),
                      ),
                    )
                  : Image.file(File(state.images[0].path)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PMButtons.text(
                  isEnabled: state.images.isNotEmpty,
                  onTap: () => removeImageDialog(context),
                  text: 'Eliminar',
                  backgroundColor: Colors.red,
                ),
                const SizedBox(width: 20),
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
                  text: 'Crear',
                  backgroundColor: Colors.green,
                ),
                const Spacer(),
              ],
            ),
          ],
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
        context.read<BlocHome>().add(
              const BlocHomeEventDeleteImageAt(
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
