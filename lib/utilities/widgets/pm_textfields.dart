import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:purchase_manager/utilities/constants/regex.dart';

/// {@template PRTextFormField}
/// Textformfields usados en la aplicacion
///
/// Textformfields used in the application
/// {@endtemplate}
class PMTextFormFields extends StatefulWidget {
  /// {@macro PRTextFormField}
  const PMTextFormFields({
    required this.controller,
    this.prefixIcon,
    this.validator,
    this.hintText,
    this.readOnly = false,
    this.obscureText = false,
    this.prefixIconColor,
    this.maxLines = 1,
    this.suffixIcon,
    this.onChanged,
    this.keyboardType,
    this.width,
    this.height,
    this.inputFormatters,
    this.maxLength,
    this.decoration,
    this.focusNode,
    super.key,
    this.borderColor,
  });

  /// [PMTextFormFields] que solo permite letras
  ///
  /// [PMTextFormFields] that only allows letters
  factory PMTextFormFields.onlyLetters({
    required TextEditingController controller,
    required String hintText,
    required IconData prefixIcon,
    void Function(String)? onChanged,
  }) {
    return PMTextFormFields(
      keyboardType: TextInputType.text,
      controller: controller,
      hintText: hintText,
      onChanged: onChanged,
      prefixIcon: prefixIcon,
      inputFormatters: [
        FilteringTextInputFormatter.deny(RegExp(r'[^a-zA-Z\s]')),
      ],
      validator: (value) {
        if (value?.isEmpty ?? false) {
          return 'Completa el campo';
        }
        return null;
      },
    );
  }

  /// [PMTextFormFields] que solo permite numeros
  ///
  /// [PMTextFormFields] that only allows numbers
  factory PMTextFormFields.onlyNumbers({
    required TextEditingController controller,
    required String hintText,
    void Function(String)? onChanged,
  }) {
    return PMTextFormFields(
      hintText: hintText,
      keyboardType: TextInputType.number,
      controller: controller,
      onChanged: onChanged,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      validator: (value) {
        if (value?.isEmpty ?? false) {
          return 'Completa el campo';
        }
        return null;
      },
    );
  }

  /// [PMTextFormFields] que solo permite letras y numeros
  ///
  /// [PMTextFormFields] that only allows letters and numbers
  factory PMTextFormFields.lettersAndNumbers({
    required TextEditingController controller,
    required String hintText,
    void Function(String)? onChanged,
    IconData? prefixIcon,
  }) {
    return PMTextFormFields(
      keyboardType: TextInputType.text,
      controller: controller,
      hintText: hintText,
      onChanged: onChanged,
      prefixIcon: prefixIcon,
      inputFormatters: [
        FilteringTextInputFormatter.deny(
          RegExp(r'[^a-zA-Z0-9\sñóäáéíóúüÜÁÉÍÓÚÑäÄöÖß]'),
        ),
      ],
      validator: (value) {
        if (value?.isEmpty ?? false) {
          return 'Completa el campo';
        }
        return null;
      },
    );
  }

  /// [PMTextFormFields] que es expandible verticalmente con un maximo de lineas
  ///
  /// [PMTextFormFields] that is vertically expandable with a maximum of lines
  factory PMTextFormFields.description({
    required TextEditingController controller,
    void Function(String)? onChanged,
    String? hintText,
    int? maxLines,
  }) {
    return PMTextFormFields(
      controller: controller,
      hintText: hintText,
      onChanged: onChanged,
      maxLines: maxLines ?? 5,
      validator: (texto) {
        if (texto?.isEmpty ?? false) {
          return 'Completa el campo';
        }
        return null;
      },
    );
  }

  /// [PMTextFormFields] que solo permite texto con formato de email
  ///
  /// [PMTextFormFields] that only allows email formatted text
  factory PMTextFormFields.email({
    required TextEditingController controller,
    void Function(String)? onChanged,
    String? hintText,
    bool soloLectura = false,
    bool esEstadoErroneo = false,
  }) {
    return PMTextFormFields(
      keyboardType: TextInputType.emailAddress,
      readOnly: soloLectura,
      controller: controller,
      hintText: soloLectura ? hintText : 'Email',
      prefixIcon: Icons.mail_outlined,
      onChanged: onChanged,
      borderColor: esEstadoErroneo ? Colors.red : null,
      validator: (email) {
        if (email?.isEmpty ?? false) {
          return 'Completa el campo';
        } else if (!ExpresionRegular.emailRegExp.hasMatch(email ?? '')) {
          return 'Enter a valid email';
        }
        return null;
      },
    );
  }

  /// Textfield para ingresar contraseñas
  ///
  /// Textfield to enter passwords
  factory PMTextFormFields.password({
    required TextEditingController controller,
    required String hintText,
    void Function(String)? onChanged,
    void Function()? onPress,
    bool esEstadoErroneo = false,
    bool obscureText = true,
  }) {
    return PMTextFormFields(
      borderColor: esEstadoErroneo ? Colors.red : null,
      controller: controller,
      hintText: hintText,
      prefixIcon: Icons.lock_outline,
      prefixIconColor: controller.text.isEmpty ? Colors.blue : Colors.grey,
      obscureText: obscureText,
      suffixIcon: IconButton(
        icon: obscureText
            ? const Icon(
                Icons.visibility_off_outlined,
                color: Colors.blue,
                size: 24,
              )
            : const Icon(
                Icons.visibility_outlined,
                color: Colors.blue,
                size: 24,
              ),
        onPressed: onPress,
      ),
      onChanged: onChanged,
      validator: (value) {
        if (value?.isEmpty ?? false) {
          return 'Completa el campo';
        }
        return null;
      },
    );
  }

  /// Controller de [PMTextFormFields]
  ///
  /// [PMTextFormFields] controller
  final TextEditingController controller;

  /// Define si el [PMTextFormFields] es readOnly.
  ///
  /// Defines if the [PMTextFormFields] is readOnly.
  final bool readOnly;

  /// Define si el [PMTextFormFields] es obscureText.
  ///
  /// Defines if the [PMTextFormFields] is obscureText.
  final bool obscureText;

  /// Texto a modo de placeholder
  ///
  /// Placeholder text
  final String? hintText;

  /// Icono izquierdo
  ///
  /// Left icon
  final IconData? prefixIcon;

  /// Icono derecho
  ///
  /// Right icon
  final Widget? suffixIcon;

  /// Color del icono izquierdo
  ///
  /// Left icon color
  final Color? prefixIconColor;

  /// Tipo de teclado
  ///
  /// Keyboard type
  final TextInputType? keyboardType;

  /// Funcion de validacion
  ///
  /// Validation function
  final String? Function(String? value)? validator;

  /// Funcion onChanged
  ///
  /// onChanged function
  final void Function(String)? onChanged;

  /// Ancho del campo de texto.
  ///
  /// Width of the text field.
  final double? width;

  /// Alto del campo de texto.
  ///
  /// Height of the text field.
  final double? height;

  /// Formateadores de texto para ponerle restricciones al usuario
  /// sobre que tipo de caracteres puede completar en el campo de texto.
  ///
  /// Text formatters to restrict the user on what type of characters can be
  /// completed in the text field.
  final List<TextInputFormatter>? inputFormatters;

  /// Maximo de caracteres a poner
  ///
  /// Maximum characters to put
  final int? maxLength;

  /// Decoración del textfield
  ///
  /// Textfield decoration
  final InputDecoration? decoration;

  /// Un objeto que puede ser utilizado por un Stateful widget para obtener
  /// el foco del teclado y manejar eventos del teclado.
  ///
  /// An object that can be used by a Stateful widget to obtain the focus of
  /// the keyboard and handle keyboard events.
  final FocusNode? focusNode;

  /// Las lineas maximas que puede tomar el campo de texto
  ///
  /// The maximum lines that the text field can take
  final int maxLines;

  /// Color utilizado para marcar error en el borde del textfield
  ///
  /// Color used to mark error in the border of the textfield
  final Color? borderColor;

  @override
  State<PMTextFormFields> createState() => _PMTextFormFieldsState();
}

class _PMTextFormFieldsState extends State<PMTextFormFields> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: TextFormField(
        maxLines: widget.maxLines,
        obscureText: widget.obscureText,
        maxLength: widget.maxLength,
        keyboardType: widget.keyboardType ?? TextInputType.none,
        controller: widget.controller,
        readOnly: widget.readOnly,
        textAlignVertical: TextAlignVertical.center,
        style: TextStyle(
          color: widget.readOnly ? Colors.blue.withOpacity(.5) : Colors.black,
          fontSize: 15,
        ),
        inputFormatters: widget.inputFormatters,
        decoration: widget.decoration ??
            InputDecoration(
              hintText: widget.hintText,
              hintStyle: const TextStyle(color: Colors.grey),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: widget.borderColor ?? const Color(0xff00B3A3),
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: widget.borderColor ?? const Color(0xff00B3A3),
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color:
                      widget.readOnly ? const Color(0xff00B3A3) : Colors.white,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              contentPadding: widget.prefixIcon == null
                  ? const EdgeInsets.fromLTRB(10, 16, 8, 0)
                  : const EdgeInsets.only(right: 8),
              suffixIcon: widget.suffixIcon,
              prefixIcon: widget.prefixIcon != null
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            widget.prefixIcon,
                            color: widget.controller.text.isEmpty
                                ? Colors.grey
                                : Colors.blue,
                            size: 24,
                          ),
                        ],
                      ),
                    )
                  : null,
            ),
        validator: widget.validator,
        onChanged: (value) {
          setState(() {
            widget.onChanged?.call(value);
          });
        },
      ),
    );
  }
}
