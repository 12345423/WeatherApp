import 'dart:convert';

Tempat tempatFromJson(String str) => Tempat.fromJson(json.decode(str));

String tempatToJson(Tempat data) => json.encode(data.toJson());

class Tempat {
  int id;
  String tempat;
  String wind;
  String pressure;
  String area;
  String humidity;
  String temperature;
  String population;

  Tempat({
    required this.id,
    required this.tempat,
    required this.wind,
    required this.pressure,
    required this.area,
    required this.humidity,
    required this.population,
    required this.temperature,
  });

  factory Tempat.fromJson(Map<String, dynamic> json) => Tempat(
        id: json["id"],
        tempat: json["tempat"],
        wind: json["wind"],
        pressure: json["pressure"],
        area: json["area"],
        humidity: json["humidity"],
        temperature: json["temperature"],
        population: json["population"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tempat": tempat,
        "wind": wind,
        "pressure": pressure,
        "area": area,
        "humidity": humidity,
        "temperature": temperature,
        "population": population,
      };
}
