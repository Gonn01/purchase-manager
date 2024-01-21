import 'dart:convert';

Coin coinFromJson(String str) => Coin.fromJson(json.decode(str));

String coinToJson(Coin data) => json.encode(data.toJson());

class Coin {
  int compra;
  int venta;
  String casa;
  String nombre;
  String moneda;
  DateTime fechaActualizacion;

  Coin({
    required this.compra,
    required this.venta,
    required this.casa,
    required this.nombre,
    required this.moneda,
    required this.fechaActualizacion,
  });

  factory Coin.fromJson(Map<String, dynamic> json) => Coin(
        compra: json["compra"],
        venta: json["venta"],
        casa: json["casa"],
        nombre: json["nombre"],
        moneda: json["moneda"],
        fechaActualizacion: DateTime.parse(json["fechaActualizacion"]),
      );

  Map<String, dynamic> toJson() => {
        "compra": compra,
        "venta": venta,
        "casa": casa,
        "nombre": nombre,
        "moneda": moneda,
        "fechaActualizacion": fechaActualizacion.toIso8601String(),
      };
}
