import 'package:flutter/material.dart';
import 'package:purchase_manager/utilities/widgets/pm_buttons.dart';

/// {@template PMDialogs}
/// Dialog personalizado
///
/// Custom dialog
/// {@endtemplate}
class PMDialogs extends StatelessWidget {
  /// {@macro PMDialogs}
  const PMDialogs({
    required this.onTapConfirm,
    this.withCancelButton = false,
    this.withOutlineButton = false,
    this.withCloseIcon = true,
    this.isEnabled = true,
    this.height,
    this.width,
    this.title,
    this.content,
    this.confirmButtonText,
    this.cancelButtonText,
    this.backgroundColorCancelButton = Colors.red,
    this.backgroundColorConfirmButton = Colors.green,
    super.key,
  });

  /// Dialog de alerta solo muestra un boton de ok
  ///
  /// Alert dialog only shows an ok button
  factory PMDialogs.alert({
    required VoidCallback onTap,
    required Widget content,
    required String title,
  }) {
    return PMDialogs(
      onTapConfirm: onTap,
      confirmButtonText: 'OK',
      title: title,
      content: content,
    );
  }

  /// Dialog de aviso que dice que la funcionalidad no esta disponible
  ///
  /// Warning dialog that says the functionality is not available
  factory PMDialogs.featNotAvailable({
    required BuildContext context,
  }) {
    return PMDialogs(
      onTapConfirm: () => Navigator.of(context).pop(),
      title: 'Funcionalidad no disponible',
      content: const Center(
        child: Text(
          'Esta funcionalidad no se encuentra disponible en esta versión de la '
          'aplicación',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  /// Dialog de confirmacion que muestra un boton de confirmar y otro de
  /// cancelar
  ///
  /// Confirmation dialog that shows a confirm button and a cancel button
  factory PMDialogs.actionRequest({
    required VoidCallback onTapConfirm,
    required Widget content,
    required String title,
    required bool isEnabled,
  }) {
    return PMDialogs(
      isEnabled: isEnabled,
      onTapConfirm: onTapConfirm,
      withCloseIcon: false,
      withCancelButton: true,
      cancelButtonText: 'Cancelar',
      content: content,
      title: title,
    );
  }

  /// Altura del [PMDialogs].
  ///
  /// Height of the [PMDialogs].
  final double? height;

  /// Ancho del [PMDialogs].
  ///
  /// Width of the [PMDialogs].
  final double? width;

  /// Indica si quiere mostrar el Icono de cerrar en el [PMDialogs].
  ///
  /// Indicates whether to show the close icon in the [PMDialogs].
  final bool withCloseIcon;

  /// Indica si quiere mostrar con botón outline en el [PMDialogs].
  ///
  /// Indicates whether to show with outline button in the [PMDialogs].
  final bool withOutlineButton;

  /// Indica si quiere mostrar con botón de cancelar en el [PMDialogs].
  ///
  /// Indicates whether to show with cancel button in the [PMDialogs].
  final bool withCancelButton;

  /// Callback para el botón de confirmar, este se ejecuta al presionar
  /// el botón de confirmar.
  ///
  /// Callback for the confirm button, this is executed when pressing
  final void Function() onTapConfirm;

  /// Titulo del [PMDialogs].
  ///
  /// Title of [PMDialogs].
  final String? title;

  /// Contenido del [PMDialogs].
  ///
  /// Content of [PMDialogs].
  final Widget? content;

  /// Texto del botón de `Confirmar` de [PMDialogs].
  ///
  /// Text of the `Confirm` button of [PMDialogs].
  final String? confirmButtonText;

  /// Titulo del botón de `Cancelar` de [PMDialogs].
  ///
  /// Title of the `Cancel` button of [PMDialogs].
  final String? cancelButtonText;

  /// Color de fondo del botón de `Cancelar` de [PMDialogs].
  ///
  /// Background color of the `Cancel` button of [PMDialogs].
  final Color backgroundColorCancelButton;

  /// Color de fondo del botón de `Confirmar` de [PMDialogs].
  ///
  /// Background color of the `Confirm` button of [PMDialogs].
  final Color backgroundColorConfirmButton;

  /// Indica si el botón de `Confirmar` de [PMDialogs] está habilitado.
  ///
  /// Indicates whether the `Confirm` button of [PMDialogs] is enabled.
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
        height: height,
        width: width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (title != null)
                  Text(
                    title ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                if (withCloseIcon) const Spacer(),
                if (withCloseIcon)
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: const Icon(
                      Icons.close,
                      size: 18,
                      color: Colors.grey,
                    ),
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: content ?? const SizedBox.shrink(),
            ),
          ],
        ),
      ),
      actionsAlignment: MainAxisAlignment.spaceEvenly,
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            if (withCancelButton)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: PMButtons.text(
                  onTap: () => Navigator.of(context).pop(),
                  isEnabled: true,
                  text: cancelButtonText ?? 'Cancelar',
                  backgroundColor: backgroundColorCancelButton,
                ),
              ),
            if (withOutlineButton)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: PMButtons.outlined(
                  onTap: isEnabled ? onTapConfirm : () {},
                  isEnabled: isEnabled,
                  text: confirmButtonText ?? 'OK',
                ),
              )
            else
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: PMButtons.text(
                  onTap: isEnabled ? onTapConfirm : () {},
                  isEnabled: isEnabled,
                  backgroundColor: isEnabled
                      ? backgroundColorConfirmButton
                      : Colors.grey.withValues(alpha: 0.5),
                  text: confirmButtonText ?? 'Confirmar',
                ),
              ),
          ],
        ),
      ],
    );
  }
}
