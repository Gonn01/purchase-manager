import 'package:flutter/material.dart';

/// {@template PMButtons}
/// Botones usados en la aplicacion
///
/// Buttons used in the application
/// {@endtemplate}
class PMButtons extends StatelessWidget {
  /// {@macro PMButtons}
  const PMButtons({
    required this.isEnabled,
    required this.onTap,
    required this.content,
    this.backgroundColorOutlined = Colors.white,
    this.backgroundColor = Colors.green,
    this.isOutlined = false,
    super.key,
  });

  /// Boton que contiene un texto
  ///
  /// Button that contains a text
  factory PMButtons.text({
    required bool isEnabled,
    required VoidCallback onTap,
    required String text,
    required Color backgroundColor,
  }) {
    return PMButtons(
      isEnabled: isEnabled,
      backgroundColor: backgroundColor,
      onTap: onTap,
      content: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.white,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  /// Boton con borde que contiene un texto
  factory PMButtons.outlined({
    required bool isEnabled,
    required VoidCallback onTap,
    required String text,
  }) {
    return PMButtons(
      isOutlined: true,
      isEnabled: isEnabled,
      onTap: onTap,
      content: Center(
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  /// Da funcionalidad al boton dependiendo de condicionales a cumplir.
  ///
  /// Gives functionality to the button depending on the conditionals to be
  final bool isEnabled;

  /// Indica si el boton tiene borde
  ///
  /// Indicates if the button has a border
  final bool isOutlined;

  /// Funcion a realizarse accionando el boton.
  ///
  /// Function to be performed by pressing the button.
  final VoidCallback? onTap;

  /// Contenido del boton
  ///
  /// Button content
  final Widget content;

  /// Color de fondo del boton con borde
  ///
  /// Background color of the outlined button
  final Color backgroundColorOutlined;

  /// Color de fondo del boton
  ///
  /// Button background color
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isEnabled ? onTap : null,
      child: IntrinsicHeight(
        child: IntrinsicWidth(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: isOutlined
                  ? backgroundColorOutlined
                  : isEnabled
                      ? backgroundColor
                      : Colors.grey.withValues(alpha: 0.5),
              border: isOutlined ? Border.all(color: Colors.grey) : null,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 5,
                horizontal: 20,
              ),
              child: Center(
                child: content,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
