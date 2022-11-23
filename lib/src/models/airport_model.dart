// To parse this JSON data, do
//
//     final ourAirport = ourAirportFromJson(jsonString);

import 'dart:convert';

List<Map<String, OurAirport>> ourAirportFromJson(String str) => List<Map<String, OurAirport>>.from(json.decode(str).map((x) => Map.from(x).map((k, v) => MapEntry<String, OurAirport>(k, OurAirport.fromMap(v)))));

String ourAirportToJson(List<Map<String, OurAirport>> data) => json.encode(List<dynamic>.from(data.map((x) => Map.from(x).map((k, v) => MapEntry<String, dynamic>(k, v.toMap())))));

class OurAirport {
    String cityName;
    String iata;
    String firebase;

    OurAirport({
        this.cityName,
        this.iata,
        this.firebase,
    });

    OurAirport copyWith({
        String cityName,
        String iata,
        String firebase,
    }) => 
        OurAirport(
            cityName: cityName ?? this.cityName,
            iata: cityName ?? this.iata,
            firebase: firebase ?? this.firebase,
        );

    factory OurAirport.fromMap(Map<String, dynamic> json) => OurAirport(
        cityName: json["cityName"] == null ? null : json["cityName"],
        iata: json["iata"] == null ? null : json["iata"],
        firebase: json["firebase"] == null ? null : json["firebase"],
    );

    Map<String, dynamic> toMap() => {
        "country": cityName == null ? null : cityName,
        "iata": iata == null ? null : iata,
        "firebase": firebase == null ? null : firebase,
    };
}