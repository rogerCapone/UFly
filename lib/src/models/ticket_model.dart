// class Tickets {
  
//   List<Ticket> items = new List();

//   Tickets();

//   Tickets.fromJson(List<dynamic> json) {

//     if(json == null) return ;

//     for (var item in json) {
//       final flight = new Ticket.fromJson(item);
//       items.add(flight);
//     }
    
//   }

// }

// To parse this JSON data, do
//
//     final kiwiTickets = kiwiTicketsFromJson(jsonString);

import 'dart:convert';

List<KiwiTickets> kiwiTicketsFromJson(String str) => List<KiwiTickets>.from(json.decode(str).map((x) => KiwiTickets.fromJson(x)));

String kiwiTicketsToJson(List<KiwiTickets> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class KiwiTickets {
    String airline;
    String flightId;
    String from;
    String to;
    String fromCity;
    String toCity;
    String countryFrom;
    String countryTo;
    DateTime depTime;
    DateTime arrTime;
    String date;
    String duration;
    double distance;
    double price;
    int availability;
    String bookingToken;
    String deepLink;

    KiwiTickets({
        this.airline,
        this.flightId,
        this.from,
        this.to,
        this.fromCity,
        this.toCity,
        this.countryFrom,
        this.countryTo,
        this.depTime,
        this.arrTime,
        this.date,
        this.duration,
        this.distance,
        this.price,
        this.availability,
        this.bookingToken,
        this.deepLink,
    });

    KiwiTickets copyWith({
        String airline,
        String flightId,
        String from,
        String to,
        String fromCity,
        String toCity,
        String countryFrom,
        String countryTo,
        DateTime depTime,
        DateTime arrTime,
        String date,
        String duration,
        double distance,
        double price,
        int availability,
        String bookingToken,
        String deepLink,
    }) => 
        KiwiTickets(
            airline: airline ?? this.airline,
            flightId: flightId ?? this.flightId,
            from: from ?? this.from,
            to: to ?? this.to,
            fromCity: fromCity ?? this.fromCity,
            toCity: toCity ?? this.toCity,
            countryFrom: countryFrom ?? this.countryFrom,
            countryTo: countryTo ?? this.countryTo,
            depTime: depTime ?? this.depTime,
            arrTime: arrTime ?? this.arrTime,
            date: date ?? this.date,
            duration: duration ?? this.duration,
            distance: distance ?? this.distance,
            price: price ?? this.price,
            availability: availability ?? this.availability,
            bookingToken: bookingToken ?? this.bookingToken,
            deepLink: deepLink ?? this.deepLink,
        );

    factory KiwiTickets.fromJson(Map<String, dynamic> json) => KiwiTickets(
        airline: json["airline"] == null ? null : json["airline"],
        flightId: json["flightId"] == null ? null : json["flightId"],
        from: json["from"] == null ? null : json["from"],
        to: json["to"] == null ? null : json["to"],
        fromCity: json["from_city"] == null ? null : json["from_city"],
        toCity: json["to_city"] == null ? null : json["to_city"],
        countryFrom: json["country_from"] == null ? null : json["country_from"],
        countryTo: json["country_to"] == null ? null : json["country_to"],
        depTime: json["depTime"] == null ? null : DateTime.parse(json["depTime"]),
        arrTime: json["arrTime"] == null ? null : DateTime.parse(json["arrTime"]),
        date: json["date"] == null ? null : json["date"],
        duration: json["duration"] == null ? null : json["duration"],
        distance: json["distance"] == null ? null : json["distance"].toDouble(),
        price: json["price"] == null ? null : json["price"].toDouble(),
        availability: json["availability"] == null ? null : json["availability"],
        bookingToken: json["bookingToken"] == null ? null : json["bookingToken"],
        deepLink: json["deep_link"] == null ? null : json["deep_link"],
    );

    Map<String, dynamic> toJson() => {
        "airline": airline == null ? null : airline,
        "flightId": flightId == null ? null : flightId,
        "from": from == null ? null : from,
        "to": to == null ? null : to,
        "from_city": fromCity == null ? null : fromCity,
        "to_city": toCity == null ? null : toCity,
        "country_from": countryFrom == null ? null : countryFrom,
        "country_to": countryTo == null ? null : countryTo,
        "depTime": depTime == null ? null : depTime.toIso8601String(),
        "arrTime": arrTime == null ? null : arrTime.toIso8601String(),
        "date": date == null ? null : date,
        "duration": duration == null ? null : duration,
        "distance": distance == null ? null : distance,
        "price": price == null ? null : price,
        "availability": availability == null ? null : availability,
        "bookingToken": bookingToken == null ? null : bookingToken,
        "deep_link": deepLink == null ? null : deepLink,
    };
}