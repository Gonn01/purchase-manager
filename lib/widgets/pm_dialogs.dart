import 'package:flutter/material.dart';
import 'package:purchase_manager/widgets/pm_buttons.dart';

/// {@template EscuelasDialog}
/// {@endtemplate}
class PMDialogs extends StatelessWidget {
  /// {@macro EscuelasDialog}
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

  factory PMDialogs.featNotAvailable({
    required BuildContext context,
  }) {
    return PMDialogs(
      onTapConfirm: () => Navigator.of(context).pop(),
      title: 'Funcionalidad no disponible',
      content: const Center(
        child: Text(
          'Esta funcionalidad no se encuentra disponible en esta versión de la aplicación',
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

  /// Altura del dialogo por defecto en `300` (sin .ph) de [PMDialogs].
  final double? height;

  /// Ancho del dialogo (sin .pw) de [PMDialogs].
  final double? width;

  /// Indica si quiere mostrar el Icono de cerrar en el dialogo
  /// `(por defecto esta el .pop)`de [PMDialogs].
  final bool withCloseIcon;

  /// Indica si quiere mostrar con botón outline en el dialogo
  /// `(por defecto esta el .pop)` de [PMDialogs].
  final bool withOutlineButton;

  /// Indica si quiere mostrar con botón de cancelar en el Dialog
  /// `(por defecto esta el .pop)`de [PMDialogs].
  final bool withCancelButton;

  /// Callback para el botón de confirmar,este se ejecuta al presionar
  /// el botón de [PMDialogs].
  final void Function() onTapConfirm;

  /// Titulo del dialogo de [PMDialogs].
  final String? title;

  /// Cuerpo/contenido del dialogo de [PMDialogs].
  final Widget? content;

  /// Titulo del botón de `Confirmar` de [PMDialogs].
  final String? confirmButtonText;

  /// Titulo del botón de `Cancelar` o `Rechazar` de [PMDialogs].
  final String? cancelButtonText;

  /// Color de fondo del botón de `Cancelar` o `Rechazar` de [PMDialogs].
  final Color backgroundColorCancelButton;

  final Color backgroundColorConfirmButton;

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
                      : Colors.grey.withOpacity(0.5),
                  text: confirmButtonText ?? 'Confirmar',
                ),
              ),
          ],
        ),
      ],
    );
  }
}
