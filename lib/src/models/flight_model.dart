// To parse this JSON data, do
//
//     final flightData = flightDataFromJson(jsonString);

import 'dart:convert';

FlightData flightDataFromJson(String str) =>
    FlightData.fromJson(json.decode(str));

String flightDataToJson(FlightData data) => json.encode(data.toJson());

class FlightData {
  FlightInfo flightInfo;
  City depCity;
  City arrCity;

  FlightData({
    this.flightInfo,
    this.depCity,
    this.arrCity,
  });

  FlightData copyWith({
    FlightInfo flightInfo,
    City depCity,
    City arrCity,
  }) =>
      FlightData(
        flightInfo: flightInfo ?? this.flightInfo,
        depCity: depCity ?? this.depCity,
        arrCity: arrCity ?? this.arrCity,
      );

  factory FlightData.fromJson(Map<String, dynamic> json) => FlightData(
        flightInfo: json["flightInfo"] == null
            ? null
            : FlightInfo.fromJson(json["flightInfo"]),
        depCity:
            json["depCity"] == null ? null : City.fromJson(json["depCity"]),
        arrCity:
            json["arrCity"] == null ? null : City.fromJson(json["arrCity"]),
      );

  Map<String, dynamic> toJson() => {
        "flightInfo": flightInfo == null ? null : flightInfo.toJson(),
        "depCity": depCity == null ? null : depCity.toJson(),
        "arrCity": arrCity == null ? null : arrCity.toJson(),
      };
}

class City {
  String airportName;
  double latitude;
  double longitude;

  City({
    this.airportName,
    this.latitude,
    this.longitude,
  });

  City copyWith({
    String airportName,
    double latitude,
    double longitude,
  }) =>
      City(
        airportName: airportName ?? this.airportName,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
      );

  factory City.fromJson(Map<String, dynamic> json) => City(
        airportName: json["airportName"] == null ? null : json["airportName"],
        latitude: json["latitude"] == null ? null : json["latitude"].toDouble(),
        longitude:
            json["longitude"] == null ? null : json["longitude"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "airportName": airportName == null ? null : airportName,
        "latitude": latitude == null ? null : latitude,
        "longitude": longitude == null ? null : longitude,
      };
}

class FlightInfo {
  DateTime flightDate;
  String flightStatus;
  Arrival departure;
  Arrival arrival;
  Airline airline;
  Flight flight;
  Aircraft aircraft;
  Live live;

  FlightInfo({
    this.flightDate,
    this.flightStatus,
    this.departure,
    this.arrival,
    this.airline,
    this.flight,
    this.aircraft,
    this.live,
  });

  FlightInfo copyWith({
    DateTime flightDate,
    String flightStatus,
    Arrival departure,
    Arrival arrival,
    Airline airline,
    Flight flight,
    Aircraft aircraft,
    Live live,
  }) =>
      FlightInfo(
        flightDate: flightDate ?? this.flightDate,
        flightStatus: flightStatus ?? this.flightStatus,
        departure: departure ?? this.departure,
        arrival: arrival ?? this.arrival,
        airline: airline ?? this.airline,
        flight: flight ?? this.flight,
        aircraft: aircraft ?? this.aircraft,
        live: live ?? this.live,
      );

  factory FlightInfo.fromJson(Map<String, dynamic> json) => FlightInfo(
        flightDate: json["flight_date"] == null
            ? null
            : DateTime.parse(json["flight_date"]),
        flightStatus:
            json["flight_status"] == null ? null : json["flight_status"],
        departure: json["departure"] == null
            ? null
            : Arrival.fromJson(json["departure"]),
        arrival:
            json["arrival"] == null ? null : Arrival.fromJson(json["arrival"]),
        airline:
            json["airline"] == null ? null : Airline.fromJson(json["airline"]),
        flight: json["flight"] == null ? null : Flight.fromJson(json["flight"]),
        aircraft: json["aircraft"] == null
            ? null
            : Aircraft.fromJson(json["aircraft"]),
        live: json["live"] == null ? null : Live.fromJson(json["live"]),
      );

  Map<String, dynamic> toJson() => {
        "flight_date": flightDate == null
            ? null
            : "${flightDate.year.toString().padLeft(4, '0')}-${flightDate.month.toString().padLeft(2, '0')}-${flightDate.day.toString().padLeft(2, '0')}",
        "flight_status": flightStatus == null ? null : flightStatus,
        "departure": departure == null ? null : departure.toJson(),
        "arrival": arrival == null ? null : arrival.toJson(),
        "airline": airline == null ? null : airline.toJson(),
        "flight": flight == null ? null : flight.toJson(),
        "aircraft": aircraft == null ? null : aircraft.toJson(),
        "live": live == null ? null : live.toJson(),
      };
}

class Aircraft {
  String registration;
  String iata;
  String icao;
  String icao24;

  Aircraft({
    this.registration,
    this.iata,
    this.icao,
    this.icao24,
  });

  Aircraft copyWith({
    String registration,
    String iata,
    String icao,
    String icao24,
  }) =>
      Aircraft(
        registration: registration ?? this.registration,
        iata: iata ?? this.iata,
        icao: icao ?? this.icao,
        icao24: icao24 ?? this.icao24,
      );

  factory Aircraft.fromJson(Map<String, dynamic> json) => Aircraft(
        registration:
            json["registration"] == null ? null : json["registration"],
        iata: json["iata"] == null ? null : json["iata"],
        icao: json["icao"] == null ? null : json["icao"],
        icao24: json["icao24"] == null ? null : json["icao24"],
      );

  Map<String, dynamic> toJson() => {
        "registration": registration == null ? null : registration,
        "iata": iata == null ? null : iata,
        "icao": icao == null ? null : icao,
        "icao24": icao24 == null ? null : icao24,
      };
}

class Airline {
  String name;
  String iata;
  String icao;

  Airline({
    this.name,
    this.iata,
    this.icao,
  });

  Airline copyWith({
    String name,
    String iata,
    String icao,
  }) =>
      Airline(
        name: name ?? this.name,
        iata: iata ?? this.iata,
        icao: icao ?? this.icao,
      );

  factory Airline.fromJson(Map<String, dynamic> json) => Airline(
        name: json["name"] == null ? null : json["name"],
        iata: json["iata"] == null ? null : json["iata"],
        icao: json["icao"] == null ? null : json["icao"],
      );

  Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "iata": iata == null ? null : iata,
        "icao": icao == null ? null : icao,
      };
}

class Arrival {
  String airport;
  String timezone;
  String iata;
  String icao;
  String terminal;
  String gate;
  String baggage;
  double delay;
  DateTime scheduled;
  DateTime estimated;
  DateTime actual;
  DateTime estimatedRunway;
  DateTime actualRunway;

  Arrival({
    this.airport,
    this.timezone,
    this.iata,
    this.icao,
    this.terminal,
    this.gate,
    this.baggage,
    this.delay,
    this.scheduled,
    this.estimated,
    this.actual,
    this.estimatedRunway,
    this.actualRunway,
  });

  Arrival copyWith({
    String airport,
    String timezone,
    String iata,
    String icao,
    String terminal,
    String gate,
    String baggage,
    double delay,
    DateTime scheduled,
    DateTime estimated,
    DateTime actual,
    DateTime estimatedRunway,
    DateTime actualRunway,
  }) =>
      Arrival(
        airport: airport ?? this.airport,
        timezone: timezone ?? this.timezone,
        iata: iata ?? this.iata,
        icao: icao ?? this.icao,
        terminal: terminal ?? this.terminal,
        gate: gate ?? this.gate,
        baggage: baggage ?? this.baggage,
        delay: delay ?? this.delay,
        scheduled: scheduled ?? this.scheduled,
        estimated: estimated ?? this.estimated,
        actual: actual ?? this.actual,
        estimatedRunway: estimatedRunway ?? this.estimatedRunway,
        actualRunway: actualRunway ?? this.actualRunway,
      );

  factory Arrival.fromJson(Map<String, dynamic> json) => Arrival(
        airport: json["airport"] == null ? null : json["airport"],
        timezone: json["timezone"] == null ? null : json["timezone"],
        iata: json["iata"] == null ? null : json["iata"],
        icao: json["icao"] == null ? null : json["icao"],
        terminal: json["terminal"] == null ? null : json["terminal"],
        gate: json["gate"] == null ? null : json["gate"],
        baggage: json["baggage"] == null ? null : json["baggage"],
        delay: json["delay"] == null ? null : json["delay"].toDouble(),
        scheduled: json["scheduled"] == null
            ? null
            : DateTime.parse(json["scheduled"]),
        estimated: json["estimated"] == null
            ? null
            : DateTime.parse(json["estimated"]),
        actual: json["actual"] == null ? null : DateTime.parse(json["actual"]),
        estimatedRunway: json["estimated_runway"] == null
            ? null
            : DateTime.parse(json["estimated_runway"]),
        actualRunway: json["actual_runway"] == null
            ? null
            : DateTime.parse(json["actual_runway"]),
      );

  Map<String, dynamic> toJson() => {
        "airport": airport == null ? null : airport,
        "timezone": timezone == null ? null : timezone,
        "iata": iata == null ? null : iata,
        "icao": icao == null ? null : icao,
        "terminal": terminal == null ? null : terminal,
        "gate": gate == null ? null : gate,
        "baggage": baggage == null ? null : baggage,
        "delay": delay == null ? null : delay,
        "scheduled": scheduled == null ? null : scheduled.toIso8601String(),
        "estimated": estimated == null ? null : estimated.toIso8601String(),
        "actual": actual == null ? null : actual.toIso8601String(),
        "estimated_runway":
            estimatedRunway == null ? null : estimatedRunway.toIso8601String(),
        "actual_runway":
            actualRunway == null ? null : actualRunway.toIso8601String(),
      };
}

class Flight {
  String number;
  String iata;
  String icao;
  Codeshared codeshared;

  Flight({
    this.number,
    this.iata,
    this.icao,
    this.codeshared,
  });

  Flight copyWith({
    String number,
    String iata,
    String icao,
    Codeshared codeshared,
  }) =>
      Flight(
        number: number ?? this.number,
        iata: iata ?? this.iata,
        icao: icao ?? this.icao,
        codeshared: codeshared ?? this.codeshared,
      );

  factory Flight.fromJson(Map<String, dynamic> json) => Flight(
        number: json["number"] == null ? null : json["number"],
        iata: json["iata"] == null ? null : json["iata"],
        icao: json["icao"] == null ? null : json["icao"],
        codeshared: json["codeshared"] == null
            ? null
            : Codeshared.fromJson(json["codeshared"]),
      );

  Map<String, dynamic> toJson() => {
        "number": number == null ? null : number,
        "iata": iata == null ? null : iata,
        "icao": icao == null ? null : icao,
        "codeshared": codeshared == null ? null : codeshared.toJson(),
      };
}

class Codeshared {
  String airlineName;
  String airlineIata;
  String airlineIcao;
  String flightNumber;
  String flightIata;
  String flightIcao;

  Codeshared({
    this.airlineName,
    this.airlineIata,
    this.airlineIcao,
    this.flightNumber,
    this.flightIata,
    this.flightIcao,
  });

  Codeshared copyWith({
    String airlineName,
    String airlineIata,
    String airlineIcao,
    String flightNumber,
    String flightIata,
    String flightIcao,
  }) =>
      Codeshared(
        airlineName: airlineName ?? this.airlineName,
        airlineIata: airlineIata ?? this.airlineIata,
        airlineIcao: airlineIcao ?? this.airlineIcao,
        flightNumber: flightNumber ?? this.flightNumber,
        flightIata: flightIata ?? this.flightIata,
        flightIcao: flightIcao ?? this.flightIcao,
      );

  factory Codeshared.fromJson(Map<String, dynamic> json) => Codeshared(
        airlineName: json["airline_name"] == null ? null : json["airline_name"],
        airlineIata: json["airline_iata"] == null ? null : json["airline_iata"],
        airlineIcao: json["airline_icao"] == null ? null : json["airline_icao"],
        flightNumber:
            json["flight_number"] == null ? null : json["flight_number"],
        flightIata: json["flight_iata"] == null ? null : json["flight_iata"],
        flightIcao: json["flight_icao"] == null ? null : json["flight_icao"],
      );

  Map<String, dynamic> toJson() => {
        "airline_name": airlineName == null ? null : airlineName,
        "airline_iata": airlineIata == null ? null : airlineIata,
        "airline_icao": airlineIcao == null ? null : airlineIcao,
        "flight_number": flightNumber == null ? null : flightNumber,
        "flight_iata": flightIata == null ? null : flightIata,
        "flight_icao": flightIcao == null ? null : flightIcao,
      };
}

class Live {
  DateTime updated;
  double latitude;
  double longitude;
  double altitud;
  double direction;
  double speedHorizontal;
  double speedVertical;
  bool isGround;

  Live({
    this.updated,
    this.latitude,
    this.longitude,
    this.altitud,
    this.direction,
    this.speedHorizontal,
    this.speedVertical,
    this.isGround,
  });

  Live copyWith({
    DateTime updated,
    double latitude,
    double longitude,
    double altitud,
    double direction,
    double speedHorizontal,
    double speedVertical,
    bool isGround,
  }) =>
      Live(
        updated: updated ?? this.updated,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
        altitud: altitud ?? this.altitud,
        direction: direction ?? this.direction,
        speedHorizontal: speedHorizontal ?? this.speedHorizontal,
        speedVertical: speedVertical ?? this.speedVertical,
        isGround: isGround ?? this.isGround,
      );

  factory Live.fromJson(Map<String, dynamic> json) => Live(
        updated:
            json["updated"] == null ? null : DateTime.parse(json["updated"]),
        latitude: json["latitude"] == null ? null : json["latitude"].toDouble(),
        longitude:
            json["longitude"] == null ? null : json["longitude"].toDouble(),
        altitud: json["altitud"] == null ? null : json["altitud"].toDouble(),
        direction:
            json["direction"] == null ? null : json["direction"].toDouble(),
        speedHorizontal: json["speed_horizontal"] == null
            ? null
            : json["speed_horizontal"].toDouble(),
        speedVertical: json["speed_vertical"] == null
            ? null
            : json["speed_vertical"].toDouble(),
        isGround: json["is_ground"] == null ? null : json["is_ground"],
      );

  Map<String, dynamic> toJson() => {
        "updated": updated == null ? null : updated.toIso8601String(),
        "latitude": latitude == null ? null : latitude,
        "longitude": longitude == null ? null : longitude,
        "altitud": altitud == null ? null : altitud,
        "direction": direction == null ? null : direction,
        "speed_horizontal": speedHorizontal == null ? null : speedHorizontal,
        "speed_vertical": speedVertical == null ? null : speedVertical,
        "is_ground": isGround == null ? null : isGround,
      };
}
