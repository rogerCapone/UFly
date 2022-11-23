import 'package:flights/src/models/airport_detalle_model.dart';
import 'package:flutter/widgets.dart';
import 'package:flights/src/models/airport_model.dart';
import 'package:http/http.dart' as http;

class Airportsprovider {
  Future<List<Map<String, OurAirport>>> buscarAeropuerto(
      BuildContext context, String query) async {
    List<Map<String, OurAirport>> dispList = [];

    var jsonFile = await DefaultAssetBundle.of(context)
        .loadString("assets/src/allAirports.json");
    List<Map<String, OurAirport>> decoded = ourAirportFromJson(jsonFile);

    if (query.length <= 3) {
      decoded.forEach((airport) {
        airport.forEach((key, value) {
          if (value.iata.toString().toLowerCase().startsWith(query, 0)) {
            dispList.add(airport);
          }
        });
      });
    } else {
      decoded.forEach((airport) {
        airport.forEach((key, value) {
          if (key.toLowerCase().startsWith(query, 0)) {
            dispList.add(airport);
          } else {
            if (value.cityName.toString().toLowerCase().startsWith(query, 0)) {
              dispList.add(airport);
            }
          }
        });
      });
    }
    if (dispList.length > 0) {
      return dispList;
    }
  }

  Future<List<Map<String, OurAirport>>> getIntialAeropuertos(
      BuildContext context) async {
    List<Map<String, OurAirport>> dispList = [];
    List<String> inicialIata = [
      'SIN',
      'HND',
      'DOH',
      'ICN',
      'HKG',
      'NGO',
      'MUC',
      'BCN',
      'MAD',
      'PMI',
      'LHR',
      'DUB',
      'DXB'
    ];
    var jsonFile = await DefaultAssetBundle.of(context)
        .loadString("assets/src/allAirports.json");

    var decoded = ourAirportFromJson(jsonFile);
    decoded.forEach((element) {
      element.forEach((key, value) {
        if (value.iata.toUpperCase() == inicialIata[0]) {
          dispList.add(element);
        } else {
          if (value.iata.toUpperCase() == inicialIata[1]) {
            dispList.add(element);
          }
        }
        if (value.iata.toUpperCase() == inicialIata[2]) {
          dispList.add(element);
        } else {
          if (value.iata.toUpperCase() == inicialIata[3]) {
            dispList.add(element);
          }
        }
        if (value.iata.toUpperCase() == inicialIata[4]) {
          dispList.add(element);
        } else {
          if (value.iata.toUpperCase() == inicialIata[5]) {
            dispList.add(element);
          }
        }
        if (value.iata.toUpperCase() == inicialIata[6]) {
          dispList.add(element);
        } else {
          if (value.iata.toUpperCase() == inicialIata[7]) {
            dispList.add(element);
          }
        }
        if (value.iata.toUpperCase() == inicialIata[8]) {
          dispList.add(element);
        } else {
          if (value.iata.toUpperCase() == inicialIata[9]) {
            dispList.add(element);
          }
        }
        if (value.iata.toUpperCase() == inicialIata[10]) {
          dispList.add(element);
        } else {
          if (value.iata.toUpperCase() == inicialIata[11]) {
            dispList.add(element);
          }
        }
        if (value.iata.toUpperCase() == inicialIata[12]) {
          dispList.add(element);
        }
      });
    });
    // print(dispList);
    return dispList;
  }

  Future<Airport> getDetalleAirport(String iataAirport) async {
    //final url = 'api.aviationstack.com/v1/flights?access_key=eefb6d17037bc3a6edf57a42eb55e303';

    final resp = await http.get(
        'https://us-central1-never-lost-1e5c9.cloudfunctions.net/getAirportInfo?airport=$iataAirport');
    final decodedData = airportFromJson(resp.body);

    return decodedData;
  }
}
