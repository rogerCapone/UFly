import 'dart:convert';

// class Airports {
  
//   List<Airport> items = new List();

//   Airports();

//   Airports.fromJson(json) {

//     if(json == null) return ;

//       final airport = new Airport.fromJson(json);
//       items.add(airport); 
    
    
//   }

// }


Airport airportFromJson(String str) => Airport.fromJson(json.decode(str));

String airportToJson(Airport data) => json.encode(data.toJson());

class Airport {
    AirportInfo airportInfo;
    List<AirportArrivalElement> airportDepartures;
    List<AirportArrivalElement> airportArrivals;

    Airport({
        this.airportInfo,
        this.airportDepartures,
        this.airportArrivals,
    });

    factory Airport.fromJson(Map<String, dynamic> json) => Airport(
        airportInfo: AirportInfo.fromJson(json["airportInfo"]),
        airportDepartures: List<AirportArrivalElement>.from(json["airportDepartures"].map((x) => AirportArrivalElement.fromJson(x))),
        airportArrivals: List<AirportArrivalElement>.from(json["airportArrivals"].map((x) => AirportArrivalElement.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "airportInfo": airportInfo.toJson(),
        "airportDepartures": List<dynamic>.from(airportDepartures.map((x) => x.toJson())),
        "airportArrivals": List<dynamic>.from(airportArrivals.map((x) => x.toJson())),
    };
}

class AirportArrivalElement {
    DateTime flightDate;
    FlightStatus flightStatus;
    Arrival departure;
    Arrival arrival;
    Airline airline;
    Flight flight;
    Aircraft aircraft;
    Live live;

    AirportArrivalElement({
        this.flightDate,
        this.flightStatus,
        this.departure,
        this.arrival,
        this.airline,
        this.flight,
        this.aircraft,
        this.live,
    });

    factory AirportArrivalElement.fromJson(Map<String, dynamic> json) => AirportArrivalElement(
        flightDate: DateTime.parse(json["flight_date"]),
        flightStatus: flightStatusValues.map[json["flight_status"]],
        departure: Arrival.fromJson(json["departure"]),
        arrival: Arrival.fromJson(json["arrival"]),
        airline: Airline.fromJson(json["airline"]),
        flight: Flight.fromJson(json["flight"]),
        aircraft: json["aircraft"] == null ? null : Aircraft.fromJson(json["aircraft"]),
        live: json["live"] == null ? null : Live.fromJson(json["live"]),
    );

    Map<String, dynamic> toJson() => {
        "flight_date": "${flightDate.year.toString().padLeft(4, '0')}-${flightDate.month.toString().padLeft(2, '0')}-${flightDate.day.toString().padLeft(2, '0')}",
        "flight_status": flightStatusValues.reverse[flightStatus],
        "departure": departure.toJson(),
        "arrival": arrival.toJson(),
        "airline": airline.toJson(),
        "flight": flight.toJson(),
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

    factory Aircraft.fromJson(Map<String, dynamic> json) => Aircraft(
        registration: json["registration"],
        iata: json["iata"],
        icao: json["icao"],
        icao24: json["icao24"],
    );

    Map<String, dynamic> toJson() => {
        "registration": registration,
        "iata": iata,
        "icao": icao,
        "icao24": icao24,
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

    factory Airline.fromJson(Map<String, dynamic> json) => Airline(
        name: json["name"],
        iata: json["iata"],
        icao: json["icao"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "iata": iata,
        "icao": icao,
    };
}

class Arrival {
    String airport;
    Timezone timezone;
    String iata;
    String icao;
    String terminal;
    String gate;
    String baggage;
    int delay;
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

    factory Arrival.fromJson(Map<String, dynamic> json) => Arrival(
        airport: json["airport"],
        timezone: timezoneValues.map[json["timezone"]],
        iata: json["iata"],
        icao: json["icao"],
        terminal: json["terminal"] == null ? null : json["terminal"],
        gate: json["gate"] == null ? null : json["gate"],
        baggage: json["baggage"] == null ? null : json["baggage"],
        delay: json["delay"] == null ? null : json["delay"],
        scheduled: json["scheduled"] == null ? null : DateTime.parse(json["scheduled"]),
        estimated: json["estimated"] == null ? null : DateTime.parse(json["estimated"]),
        actual: json["actual"] == null ? null : DateTime.parse(json["actual"]),
        estimatedRunway: json["estimated_runway"] == null ? null : DateTime.parse(json["estimated_runway"]),
        actualRunway: json["actual_runway"] == null ? null : DateTime.parse(json["actual_runway"]),
    );

    Map<String, dynamic> toJson() => {
        "airport": airport,
        "timezone": timezoneValues.reverse[timezone],
        "iata": iata,
        "icao": icao,
        "terminal": terminal == null ? null : terminal,
        "gate": gate == null ? null : gate,
        "baggage": baggage == null ? null : baggage,
        "delay": delay == null ? null : delay,
        "scheduled": scheduled == null ? null : scheduled.toIso8601String(),
        "estimated": estimated == null ? null : estimated.toIso8601String(),
        "actual": actual == null ? null : actual.toIso8601String(),
        "estimated_runway": estimatedRunway == null ? null : estimatedRunway.toIso8601String(),
        "actual_runway": actualRunway == null ? null : actualRunway.toIso8601String(),
    };
}

enum Timezone { AMERICA_NEW_YORK, AMERICA_LOS_ANGELES, AMERICA_SANTO_DOMINGO, AMERICA_PUERTO_RICO, EUROPE_LONDON, ASIA_SHANGHAI, AMERICA_TORONTO, AMERICA_MEXICO_CITY }

final timezoneValues = EnumValues({
    "America/Los_Angeles": Timezone.AMERICA_LOS_ANGELES,
    "America/Mexico_City": Timezone.AMERICA_MEXICO_CITY,
    "America/New_York": Timezone.AMERICA_NEW_YORK,
    "America/Puerto_Rico": Timezone.AMERICA_PUERTO_RICO,
    "America/Santo_Domingo": Timezone.AMERICA_SANTO_DOMINGO,
    "America/Toronto": Timezone.AMERICA_TORONTO,
    "Asia/Shanghai": Timezone.ASIA_SHANGHAI,
    "Europe/London": Timezone.EUROPE_LONDON
});

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

    factory Flight.fromJson(Map<String, dynamic> json) => Flight(
        number: json["number"],
        iata: json["iata"],
        icao: json["icao"],
        codeshared: json["codeshared"] == null ? null : Codeshared.fromJson(json["codeshared"]),
    );

    Map<String, dynamic> toJson() => {
        "number": number,
        "iata": iata,
        "icao": icao,
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

    factory Codeshared.fromJson(Map<String, dynamic> json) => Codeshared(
        airlineName: json["airline_name"],
        airlineIata: json["airline_iata"],
        airlineIcao: json["airline_icao"],
        flightNumber: json["flight_number"],
        flightIata: json["flight_iata"],
        flightIcao: json["flight_icao"],
    );

    Map<String, dynamic> toJson() => {
        "airline_name": airlineName,
        "airline_iata": airlineIata,
        "airline_icao": airlineIcao,
        "flight_number": flightNumber,
        "flight_iata": flightIata,
        "flight_icao": flightIcao,
    };
}

enum FlightStatus { ACTIVE }

final flightStatusValues = EnumValues({
    "active": FlightStatus.ACTIVE
});

class Live {
    DateTime updated;
    double latitude;
    double longitude;
    double altitude;
    int direction;
    double speedHorizontal;
    int speedVertical;
    bool isGround;

    Live({
        this.updated,
        this.latitude,
        this.longitude,
        this.altitude,
        this.direction,
        this.speedHorizontal,
        this.speedVertical,
        this.isGround,
    });

    factory Live.fromJson(Map<String, dynamic> json) => Live(
        updated: DateTime.parse(json["updated"]),
        latitude: json["latitude"].toDouble(),
        longitude: json["longitude"].toDouble(),
        altitude: json["altitude"].toDouble(),
        direction: json["direction"].hashCode,
        speedHorizontal: json["speed_horizontal"].toDouble(),
        speedVertical: json["speed_vertical"].hashCode,
        isGround: json["is_ground"],
    );

    Map<String, dynamic> toJson() => {
        "updated": updated.toIso8601String(),
        "latitude": latitude,
        "longitude": longitude,
        "altitude": altitude,
        "direction": direction,
        "speed_horizontal": speedHorizontal,
        "speed_vertical": speedVertical,
        "is_ground": isGround,
    };
}

class AirportInfo {
    int id;
    String iata;
    String icao;
    String name;
    String location;
    String streetNumber;
    String street;
    String city;
    String county;
    String state;
    String countryIso;
    String country;
    String postalCode;
    String phone;
    double latitude;
    double longitude;
    int uct;
    String website;

    AirportInfo({
        this.id,
        this.iata,
        this.icao,
        this.name,
        this.location,
        this.streetNumber,
        this.street,
        this.city,
        this.county,
        this.state,
        this.countryIso,
        this.country,
        this.postalCode,
        this.phone,
        this.latitude,
        this.longitude,
        this.uct,
        this.website,
    });

    factory AirportInfo.fromJson(Map<String, dynamic> json) => AirportInfo(
        id: json["id"],
        iata: json["iata"],
        icao: json["icao"],
        name: json["name"],
        location: json["location"],
        streetNumber: json["street_number"],
        street: json["street"],
        city: json["city"],
        county: json["county"],
        state: json["state"],
        countryIso: json["country_iso"],
        country: json["country"],
        postalCode: json["postal_code"],
        phone: json["phone"],
        latitude: json["latitude"].toDouble(),
        longitude: json["longitude"].toDouble(),
        uct: json["uct"],
        website: json["website"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "iata": iata,
        "icao": icao,
        "name": name,
        "location": location,
        "street_number": streetNumber,
        "street": street,
        "city": city,
        "county": county,
        "state": state,
        "country_iso": countryIso,
        "country": country,
        "postal_code": postalCode,
        "phone": phone,
        "latitude": latitude,
        "longitude": longitude,
        "uct": uct,
        "website": website,
    };
}

class EnumValues<T> {
    Map<String, T> map;
    Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        if (reverseMap == null) {
            reverseMap = map.map((k, v) => new MapEntry(v, k));
        }
        return reverseMap;
    }
}
