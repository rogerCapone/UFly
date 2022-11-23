import 'package:flights/src/services/local_DB/trip_db.dart';
import 'package:flights/src/services/profile_services.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MyFlights extends StatelessWidget {
  MyTrip myFlight;
  MyFlights({@required this.myFlight});

  @override
  Widget build(BuildContext context) {
    final dbuser = Provider.of<ProfileServices>(context).dbUser;

    final size = MediaQuery.of(context).size;
    DateTime before = DateTime.parse(myFlight.dateArr);
    DateTime after = DateTime.parse(myFlight.dateDep);

    print(before.difference(after).inHours);
    print(before.difference(after).inMinutes % 60);

    return Scaffold(
      body: Container(
          height: size.height,
          width: size.width,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/wing.jpeg'),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.2), BlendMode.dstATop))),
          child: Column(
            children: <Widget>[
              SizedBox(height: size.height * 0.075),
              Container(
                padding: EdgeInsets.symmetric(vertical: 20),
                height: size.height * 0.2,
                width: size.width * 0.85,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Icon(Icons.flight_takeoff),
                        SizedBox(height: 7),
                        Text(myFlight.org,
                            style: GoogleFonts.rubik(
                                fontSize: 50, fontWeight: FontWeight.w300)),
                        SizedBox(height: 7),
                        Text(
                            DateTime.parse(myFlight.dateDep).hour > 13
                                ? DateTime.parse(myFlight.dateDep)
                                        .hour
                                        .toString()
                                        .padLeft(2, '0') +
                                    ':' +
                                    DateTime.parse(myFlight.dateDep)
                                        .minute
                                        .toString()
                                        .padLeft(2, '0') +
                                    ' PM'
                                : DateTime.parse(myFlight.dateDep)
                                        .hour
                                        .toString()
                                        .padLeft(2, '0') +
                                    ':' +
                                    DateTime.parse(myFlight.dateDep)
                                        .minute
                                        .toString()
                                        .padLeft(2, '0') +
                                    ' AM',
                            style: GoogleFonts.rubik(
                                fontSize: 17, fontWeight: FontWeight.w200)),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Icon(Icons.flight_land),
                        SizedBox(height: 7),
                        Text(myFlight.dest,
                            style: GoogleFonts.rubik(
                                fontSize: 50, fontWeight: FontWeight.w300)),
                        SizedBox(height: 7),
                        Text(
                            DateTime.parse(myFlight.dateArr).hour > 13
                                ? DateTime.parse(myFlight.dateArr)
                                        .hour
                                        .toString()
                                        .padLeft(2, '0') +
                                    ':' +
                                    DateTime.parse(myFlight.dateArr)
                                        .minute
                                        .toString()
                                        .padLeft(2, '0') +
                                    ' PM'
                                : DateTime.parse(myFlight.dateArr)
                                        .hour
                                        .toString()
                                        .padLeft(2, '0') +
                                    ':' +
                                    DateTime.parse(myFlight.dateArr)
                                        .minute
                                        .toString()
                                        .padLeft(2, '0') +
                                    ' AM',
                            style: GoogleFonts.rubik(
                                fontSize: 17, fontWeight: FontWeight.w200)),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                height: size.height * 0.4,
                width: size.width * 0.8,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.white.withOpacity(0.65)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(width: 20.0),
                        Text('Passanger: ',
                            style: GoogleFonts.montserrat(
                                fontSize: 18, fontWeight: FontWeight.w500)),
                        SizedBox(width: 15.0),
                        Text(dbuser.userName,
                            style: GoogleFonts.montserrat(
                                fontSize: 20, fontWeight: FontWeight.w300))
                      ],
                    ),
                    SizedBox(height: 15.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(width: 20.0),
                        Text('Trip Duration: ',
                            style: GoogleFonts.montserrat(
                                fontSize: 18, fontWeight: FontWeight.w500)),
                        SizedBox(width: 15.0),
                        Text(
                            before.difference(after).inHours >= 1
                                ? before.difference(after).inHours.toString() +
                                    'h ' +
                                    (before.difference(after).inMinutes % 60)
                                        .toString() +
                                    'm'
                                : (before.difference(after).inMinutes % 60)
                                        .toString() +
                                    'm',
                            style: GoogleFonts.montserrat(
                                fontSize: 20, fontWeight: FontWeight.w300))
                      ],
                    ),
                    SizedBox(height: 15.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(width: 20.0),
                        Text('Date: ',
                            style: GoogleFonts.montserrat(
                                fontSize: 18, fontWeight: FontWeight.w500)),
                        SizedBox(width: 15.0),
                        Text(
                            before.difference(after).inDays < 1
                                ? before.day.toString().padLeft(2, '0') +
                                    '-' +
                                    before.month.toString().padLeft(2, '0') +
                                    '-' +
                                    before.year.toString()
                                : before.day.toString() +
                                    '-' +
                                    before.month.toString().padLeft(2, '0') +
                                    '-' +
                                    before.year.toString() +
                                    '  ' +
                                    after.day.toString().padLeft(2, '0') +
                                    '-' +
                                    after.month.toString().padLeft(2, '0') +
                                    '-' +
                                    after.year.toString(),
                            style: GoogleFonts.montserrat(
                                fontSize: 20, fontWeight: FontWeight.w300))
                      ],
                    ),
                    SizedBox(height: 40.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(width: 20.0),
                        Text('Flight ID: ',
                            style: GoogleFonts.montserrat(
                                fontSize: 18, fontWeight: FontWeight.w500)),
                        SizedBox(width: 15.0),
                        Text(myFlight.idVuelo,
                            style: GoogleFonts.montserrat(
                                fontSize: 20, fontWeight: FontWeight.w300))
                      ],
                    ),
                    SizedBox(height: 15.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(width: 20.0),
                        Text('Class:',
                            style: GoogleFonts.montserrat(
                                fontSize: 18, fontWeight: FontWeight.w500)),
                        SizedBox(width: 15.0),
                        Text('Business',
                            style: GoogleFonts.montserrat(
                                fontSize: 20, fontWeight: FontWeight.w300))
                      ],
                    ),
                    SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        SizedBox(width: 20.0),
                        Icon(Icons.assignment)
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.015),
              Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: <Widget>[
                    SizedBox(width: size.width * 0.105),
                    Text('Departure',
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style: GoogleFonts.rubik(
                            fontSize: 25,
                            fontWeight: FontWeight.w400,
                            color: Colors.blue)),
                  ],
                ),
              ),
              SizedBox(height: 5.0),
              Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: <Widget>[
                    SizedBox(width: size.width * 0.105),
                    Text(myFlight.orgName,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.rubik(
                            fontSize: 15, fontWeight: FontWeight.w400)),
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.015),
              Align(
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text('Arrival',
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.right,
                        style: GoogleFonts.rubik(
                            fontSize: 25,
                            fontWeight: FontWeight.w400,
                            color: Colors.blue)),
                    SizedBox(width: size.width * 0.105),
                  ],
                ),
              ),
              SizedBox(height: 5.0),
              Align(
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(myFlight.destName,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.rubik(
                            fontSize: 15, fontWeight: FontWeight.w400)),
                    SizedBox(width: size.width * 0.105),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(width: size.width * 0.105),
                    GestureDetector(
                        child: Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.lightBlueAccent.withOpacity(0.2)),
                          child: Icon(
                            Icons.done_outline,
                            color: Colors.black.withOpacity(0.65),
                            size: 40,
                          ),
                        ),
                        onTap: () => Navigator.pop(context)),
                    SizedBox(width: 15.5),
                    Text('Nice! ',
                        style: GoogleFonts.rubik(
                            fontSize: 20, fontWeight: FontWeight.w200))
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
