/// {@template ExpresionRegular}
/// Esta clase es utilizada para agregar las expresiones regulares que
/// admitiran o restringiran utilizacion de tipos de caracteres.
/// {@endtemplate}
class ExpresionRegular {
  /// {@macro ExpresionRegular}

  /// Expresion regular que solo admite formato email.
  static RegExp get emailRegExp => RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/-=?^_`{|}~]+@[a-zA-Z0-9-]+\.[a-zA-Z]+",
      );

  /// Expresion regular que solo admite formato letras.
  static RegExp get letrasRegExp => RegExp(r'^[a-zA-ZÀ-ÿ\s]+$');

  /// Expresion regular que solo admite formato letras y números.
  static RegExp get letrasYNumerosRegExp => RegExp(r'^[a-zA-ZÀ-ÿ\s\d]*$');

  /// Expresion regular que solo admite formato datetime.
  static RegExp get dateTimeRegExp => RegExp(r'^[0-9/-\s]+$');

  /// Expresion regular que permite o no ingresar emojis.
  static RegExp get emojis => RegExp(
        r'(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])',
      );
}
