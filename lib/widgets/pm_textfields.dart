import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:purchase_manager/constants/regex.dart';

/// Textformfields base y variantes para uso en PRLab
class PMTextFormFields extends StatefulWidget {
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
    this.cursorColor,
    this.decoration,
    this.onTap,
    this.focusNode,
    super.key,
    this.borderColor,
  });

  /// TFF utilizable para nombre y apellido.
  /// Iconos a utilizar:
  /// Name/Last name: Icons.person_outlined
  /// Company: Icons.apartment
  /// Company location: Icons.location_on_outlined
  factory PMTextFormFields.onlyLetters({
    /// Controller de [PRTextFormField]
    required TextEditingController controller,

    /// Texto interno
    required String hintText,

    /// Icono izquierdo
    required IconData prefixIcon,

    /// Funcion onChanged
    void Function(String)? onChanged,

    /// usa el colores.tertiary para el texto del textfield
    bool colorTerciario = false,
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

  /// TFF a utilizar en caso de necesitarse informacion numerica.
  /// Contact: Icons.call_outlined
  /// Birthdate: Icons.calendar_month_outlined
  factory PMTextFormFields.onlyNumbers({
    /// Controller de [PRTextFormField]
    required TextEditingController controller,

    /// Texto interno
    required String hintText,

    /// Funcion onChanged
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

  /// TFF utilizable para nombres de empresas o ubicación en caso de una calle.
  /// Iconos a utilizar:
  /// Name/Last name: Icons.person_outlined
  /// Company: Icons.apartment
  /// Company location: Icons.location_on_outlined
  factory PMTextFormFields.lettersAndNumbers({
    /// Controller de [PRTextFormField]
    required TextEditingController controller,

    /// Texto interno
    required String hintText,

    /// Icono izquierdo
    IconData? prefixIcon,

    /// Funcion onChanged
    void Function(String)? onChanged,
    bool colorTerciario = false,
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

  /// TFF de una descripcion, pudiendo precisar la altura, cantidad de lineas.
  factory PMTextFormFields.description({
    /// Controller de [PRTextFormField]
    required TextEditingController controller,

    /// Funcion onChanged
    void Function(String)? onChanged,

    /// Texto interno
    String? hintText,

    /// Las lineas maximas que puede tomar el campo de texto
    int? maxLines,

    /// usa el colores.tertiary para el texto del textfield
    bool colorTerciario = false,
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

  /// TFF de email, con dos configuraciones, solo lectura o completable
  factory PMTextFormFields.email({
    /// Controller de [PRTextFormField]
    required TextEditingController controller,

    /// Define si el tff es readOnly.
    bool soloLectura = false,

    /// Funcion onChanged
    void Function(String)? onChanged,

    /// Texto interno
    String? hintText,

    /// Verifica el estado para definir el color del borde
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

  factory PMTextFormFields.password({
    /// Controller de [PRTextFormField]
    required TextEditingController controller,

    /// Texto interno
    required String hintText,

    /// Icono izquierdo
    required IconData prefixIcon,

    /// Funcion onChanged
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
  final TextEditingController controller;

  /// Define si el tff es readOnly.
  final bool readOnly;

  /// Define si los caracteres son ocultos
  final bool obscureText;

  /// Texto interno
  final String? hintText;

  /// Icono izquierdo
  final IconData? prefixIcon;

  /// Icono derecho
  final Widget? suffixIcon;

  /// Color de icono izquierdo
  final Color? prefixIconColor;

  /// Tipo de teclado
  final TextInputType? keyboardType;

  /// Validators para cada textformfield
  final String? Function(String? value)? validator;

  /// Funcion onChanged
  final void Function(String)? onChanged;

  /// Ancho del campo de texto.
  final double? width;

  /// Alto del campo de texto.
  final double? height;

  /// Formateadores de texto para ponerle restricciones a el usuario
  /// sobre que tipo de caracteres puede completar en el campo de texto.
  final List<TextInputFormatter>? inputFormatters;

  /// Máximo de caracteres a poner
  final int? maxLength;

  /// color del cursor al estar escribiendo
  final Color? cursorColor;

  /// Decoración del textfield
  final InputDecoration? decoration;

  /// Al Apretar el Campo ejecuta esta Accion.
  final void Function()? onTap;

  /// Un objeto que puede ser utilizado por un Stateful widget para obtener
  /// el foco del teclado y manejar eventos del teclado.
  final FocusNode? focusNode;

  /// Las lineas maximas que puede tomar el campo de texto
  final int maxLines;

  /// Color utilizado para marcar error en el borde del textfield
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
        onTap: widget.onTap,
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
