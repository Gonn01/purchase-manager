import 'package:flutter/material.dart';

/// {@templates EscuelasBoton}
/// Boton personalizado para utilizar
/// {@endtemplates}
class PMButtons extends StatelessWidget {
  /// {@macro EscuelasBoton}
  const PMButtons({
    required this.isEnabled,
    required this.onTap,
    required this.content,
    this.backgroundColorOutlined = Colors.white,
    this.backgroundColor = Colors.green,
    this.isOutlined = false,
    super.key,
  });

  factory PMButtons.text({
    /// Da funcionalidad al boton dependiendo de condicionales a cumplir.
    required bool isEnabled,

    /// Funcion a realizarse accionando el boton.
    required VoidCallback onTap,

    /// Texto interno del boton.
    required String text,

    /// Color de fondo del boton.
    Color backgroundColor = Colors.green,
  }) {
    return PMButtons(
      isEnabled: isEnabled,
      onTap: onTap,
      backgroundColor: backgroundColor,
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

  factory PMButtons.outlined({
    /// Funcion a realizarse accionando el boton.
    required VoidCallback onTap,

    /// Da funcionalidad al boton dependiendo de condicionales a cumplir.
    required bool isEnabled,

    /// Texto interno del boton
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
  final bool isEnabled;

  /// Da diseño dependiendo si es outlined o fill.
  final bool isOutlined;

  /// Funcion al presionar el boton
  final VoidCallback? onTap;

  /// Widget que va a contener el boton, puede ser un texto o texto e iconos
  final Widget content;

  final Color backgroundColorOutlined;

  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isEnabled ? onTap : null,
      child: IntrinsicHeight(
        child: IntrinsicWidth(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: isOutlined
                  ? backgroundColorOutlined
                  : isEnabled
                      ? backgroundColor
                      : Colors.grey.withOpacity(.5),
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
