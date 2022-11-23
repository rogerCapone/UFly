
import 'package:flights/src/services/database.dart';
import 'package:flights/src/models/flight_model.dart';
import 'package:flights/src/services/profile_services.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_drawing/path_drawing.dart';
import 'package:provider/provider.dart';
import 'package:flights/src/services/local_DB/trip_db.dart';


class FlightDetalle extends StatelessWidget {
  final String flightId;
  FlightDetalle({@required this.flightId});
  
  @override
  Widget build(BuildContext context) {
    final res = Provider.of<ProfileServices>(context, listen: false);
    final flightProvider = DataBase(uid: res.dbUser.uid);
    final size = MediaQuery.of(context).size;

  FlightData flightsDetalle;

  TripDb db = TripDb();

    double padding = 24;
    Color _color = Color.fromRGBO(1, 100, 212, 1);
    Color _accentColor = Color.fromRGBO(34, 82, 136, 1);

    return Scaffold(
       
        body: FutureBuilder(
            future: flightProvider.getFlightInfo(flightId),
            builder:
                (BuildContext context, AsyncSnapshot<FlightData> snapshot) {
              final flight = snapshot.data;
              flightsDetalle = snapshot.data;

              return flight != null
                  ? LayoutBuilder(
                    builder: (BuildContext context, BoxConstraints constraints) { 
                     return _flightDetalle(padding: padding, size: size, color: _color, accentColor: _accentColor, flight: flight);
                     },
                    
                  )
                  : Center(child: CircularProgressIndicator());
            }),
            
            floatingActionButton: FutureBuilder(
              future: db.initDB(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
               if (snapshot.connectionState == ConnectionState.done) {
                 return _buttonSave(db: db, flight: flightsDetalle);
               } else {
                 return CircularProgressIndicator();
               }
              },
            ),
    );
  }
}

class _buttonSave extends StatelessWidget {
  
  final TripDb db;
  final FlightData flight;

_buttonSave({@required this.db, @required this.flight});

  

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      
      onPressed: () {
       
         var fly = MyTrip(
                        idVuelo: flight.flightInfo.flight.iata,
                        org: flight.flightInfo.departure.iata,
                        orgName: flight.depCity.airportName,
                        dest: flight.flightInfo.arrival.iata,
                        destName: flight.arrCity.airportName,
                        dateDep: flight.flightInfo.departure.estimated.toString(),
                        dateArr: flight.flightInfo.arrival.estimated.toString(),
                        airline: flight.flightInfo.airline.name,
                        airlineImg:
                            'https://images.kiwi.com/airlines/64/${flight.flightInfo.airline.iata}.png',
                        arrTime: flight.flightInfo.arrival.estimated.toString(),
                        depTime: flight.flightInfo.departure.estimated.toString(),
                      );
                      db.insert(fly);
      },
      child: Icon(FontAwesomeIcons.save),
    );
  }
}

class _flightDetalle extends StatelessWidget {
  const _flightDetalle({
    Key key,
    @required this.padding,
    @required this.size,
    @required Color color,
    @required Color accentColor,
    @required this.flight,
  }) : _color = color, _accentColor = accentColor, super(key: key);

  final double padding;
  final Size size;
  final Color _color;
  final Color _accentColor;
  final FlightData flight;

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: padding),
              height: size.height * 0.30,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [_color, _accentColor],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter)),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          flight.flightInfo.departure.iata
                              .toUpperCase(),
                          style: GoogleFonts.rubik(
                              fontSize: 32.0,
                              color: Colors.white,
                              fontWeight: FontWeight.w300),
                        ),
                        // Text('Jakarta ID',
                        // style: TextStyle(
                        //   fontSize: 15.0, color: Colors.white, fontWeight: FontWeight.w600
                        // ),
                        // ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      height: 120.0,
                      child: Stack(
                        children: <Widget>[
                          // dotted line
                          Positioned(
                            top: 0,
                            left: padding * 0.5,
                            right: padding * 0.5,
                            bottom: 0,
                            child: CustomPaint(
                              painter: MyPainter(),
                            ),
                          ),
                          // left circle
                          Positioned(
                            top: 58,
                            left: padding * 0.5 - 8.0,
                            child: Container(
                              height: 8.0,
                              width: 8.0,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle),
                            ),
                          ),
                          // Right circle
                          Positioned(
                            top: 58,
                            right: padding * 0.5 - 8.0,
                            child: Container(
                              height: 8.0,
                              width: 8.0,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle),
                            ),
                          ),

                          //plane icon
                          Positioned(
                            top: 1.0,
                            left: 50.0,
                            right: 50.0,
                            child: Icon(
                              Icons.flight_takeoff,
                              size: 30.0,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          flight.flightInfo.arrival.iata
                              .toUpperCase(),
                          style: GoogleFonts.rubik(
                              fontSize: 32.0,
                              color: Colors.white,
                              fontWeight: FontWeight.w300),
                        ),
                        // Text('London, UK ',
                        // style: TextStyle(
                        //   fontSize: 15.0, color: Colors.white, fontWeight: FontWeight.w600
                        // ),
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // appbar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            // bottom: ,
            child: SafeArea(
              top: true,
              left: true,
              right: true,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: padding),
                height: 40.0,
                child: Row(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        size: 28.0,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    // IconButton(
                    //   icon: (Icons.arrow_back, size: 28.0, color:Colors.white),),
                    Spacer(),
                  ],
                ),
              ),
            ),
          ),

          // TAKEOFF & LANDING
          Positioned(
            top: size.height * 0.22,
            left: size.width * 0.07,
            right: size.width * 0.07,
            bottom: size.height * 0.12,
            child: Column(
              children: <Widget>[
                //take off
                Flexible(
                  child: Container(
                    padding: EdgeInsets.all(padding * 0.5),
                    height: size.height,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black12,
                              spreadRadius: 1,
                              blurRadius: 1)
                        ]),
                    child: Column(
                      children: <Widget>[
                        //first row departure
                        Expanded(
                          child: Row(
                            children: <Widget>[
                              // sheduled departure
                              Expanded(
                                flex: 2,
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Column(
                                    // crossAxisAlignment: CrossAxisAlignment.start,
                                    // mainAxisAlignment: MainAxisAlignment.center,

                                    children: <Widget>[
                                      SizedBox(
                                        height: 15.0,
                                      ),
                                      Text(
                                        'SCHEDULED',
                                        style: GoogleFonts
                                            .montserrat(
                                                fontSize:
                                                    size.height *
                                                        0.018,
                                                color:
                                                    Colors.grey,
                                                fontWeight:
                                                    FontWeight
                                                        .w500),
                                      ),
                                      SizedBox(
                                        height: 7.0,
                                      ),
                                      flight.flightInfo.departure
                                                  .scheduled !=
                                              null
                                          ? Text(
                                              flight
                                                      .flightInfo
                                                      .departure
                                                      .scheduled
                                                      .hour
                                                      .toString().padLeft(2,'0') +
                                                  ':' +
                                                  flight
                                                      .flightInfo
                                                      .departure
                                                      .scheduled
                                                      .minute
                                                      .toString().padLeft(2,'0'),
                                              style: GoogleFonts.montserrat(
                                                  fontSize:
                                                      size.height *
                                                          0.03,
                                                  color: Colors
                                                      .black,
                                                  fontWeight:
                                                      FontWeight
                                                          .w400),
                                            )
                                          : Text(
                                              flight
                                                      .flightInfo
                                                      .departure
                                                      .estimated
                                                      .hour
                                                      .toString().padLeft(2,'0') +
                                                  ':' +
                                                  flight
                                                      .flightInfo
                                                      .departure
                                                      .estimated
                                                      .minute
                                                      .toString().padLeft(2,'0'),
                                              style: GoogleFonts.montserrat(
                                                  fontSize:
                                                      size.height *
                                                          0.03,
                                                  color: Colors
                                                      .black,
                                                  fontWeight:
                                                      FontWeight
                                                          .w400),
                                            ),
                                    ],
                                  ),
                                ),
                              ),

                              // take off icon / data
                              Expanded(
                                flex: 2,
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Column(
                                    children: <Widget>[
                                      Expanded(
                                        child: Text(
                                          'TAKE-OFF',
                                          style: GoogleFonts.rubik(
                                              fontSize:
                                                  size.height *
                                                      0.018,
                                              color: Colors.grey,
                                              fontWeight:
                                                  FontWeight
                                                      .w400),
                                        ),
                                      ),
                                      Icon(
                                        Icons.flight_takeoff,
                                        size: size.height * 0.034,
                                        color: Colors.black,
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                      Expanded(
                                        child: Text(
                                          '${flight.flightInfo.departure.estimated.year.toString()}-${flight.flightInfo.departure.estimated.month.toString().padLeft(2,'0')}-${flight.flightInfo.departure.estimated.day.toString().padLeft(2,'0')}',
                                          textAlign:
                                              TextAlign.center,
                                          style: GoogleFonts.rubik(
                                              fontSize:
                                                  size.height *
                                                      0.02,
                                              color: Colors.grey,
                                              fontWeight:
                                                  FontWeight
                                                      .w200),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              // estimated diparture
                              Expanded(
                                flex: 2,
                                child: Container(
                                  alignment:
                                      Alignment.centerRight,
                                  child: Column(
                                    // crossAxisAlignment: CrossAxisAlignment.start,
                                    // mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      SizedBox(
                                        height: 15.0,
                                      ),
                                      Text(
                                        'ESTIMATED',
                                        style: GoogleFonts
                                            .montserrat(
                                                fontSize:
                                                    size.height *
                                                        0.018,
                                                color:
                                                    Colors.grey,
                                                fontWeight:
                                                    FontWeight
                                                        .w500),
                                      ),
                                      SizedBox(
                                        height: 7.0,
                                      ),
                                      Text(
                                        flight
                                                .flightInfo
                                                .departure
                                                .estimated
                                                .hour
                                                .toString().padLeft(2,'0') +
                                            ':' +
                                            flight
                                                .flightInfo
                                                .departure
                                                .estimated
                                                .minute
                                                .toString().padLeft(2,'0'),
                                        style: GoogleFonts
                                            .montserrat(
                                                fontSize:
                                                    size.height *
                                                        0.03,
                                                color:
                                                    Colors.black,
                                                fontWeight:
                                                    FontWeight
                                                        .w400),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // second row departure
                        Expanded(
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                flex: 2,
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Column(
                                    children: <Widget>[
                                      // name airport departure
                                      Row(
                                        children: <Widget>[
                                          Expanded(
                                              child: Text(
                                            flight.depCity
                                                .airportName,
                                            textAlign:
                                                TextAlign.center,
                                            style: GoogleFonts
                                                .montserrat(
                                                    color: Colors
                                                        .black,
                                                    fontWeight:
                                                        FontWeight
                                                            .w500,
                                                    fontSize: size
                                                            .height *
                                                        0.025),
                                            overflow: TextOverflow
                                                .ellipsis,
                                          )),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      // terminal /gate/ delay airport depart
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceEvenly,
                                          children: <Widget>[
                                            Column(
                                              children: <Widget>[
                                                //terminal depart
                                                Expanded(
                                                  child: Row(
                                                    children: <
                                                        Widget>[
                                                      Text(
                                                        'TERMINAL: ',
                                                        style: GoogleFonts.rubik(
                                                            fontSize: size.height *
                                                                0.018,
                                                            fontWeight: FontWeight
                                                                .w400,
                                                            color:
                                                                Colors.grey),
                                                      ),
                                                      Text(
                                                        flight.flightInfo.departure.terminal !=
                                                                null
                                                            ? flight
                                                                .flightInfo
                                                                .departure
                                                                .terminal
                                                            : '?',
                                                        style: TextStyle(
                                                            fontSize: size.height *
                                                                0.018,
                                                            fontWeight: FontWeight
                                                                .bold,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                            Column(
                                              children: <Widget>[
                                                //gate departure
                                                Expanded(
                                                  child: Row(
                                                    children: <
                                                        Widget>[
                                                      Text(
                                                        'GATE: ',
                                                        style: GoogleFonts.rubik(
                                                            fontSize: size.height *
                                                                0.018,
                                                            fontWeight: FontWeight
                                                                .w400,
                                                            color:
                                                                Colors.grey),
                                                      ),
                                                      Text(
                                                        flight.flightInfo.departure.gate !=
                                                                null
                                                            ? flight
                                                                .flightInfo
                                                                .departure
                                                                .gate
                                                            : '?',
                                                        style: TextStyle(
                                                            fontSize: size.height *
                                                                0.018,
                                                            fontWeight: FontWeight
                                                                .bold,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                            Column(
                                              children: <Widget>[
                                                //delay departure
                                                Expanded(
                                                  child: Row(
                                                    children: <
                                                        Widget>[
                                                      Text(
                                                        'DELAY: ',
                                                        style: GoogleFonts.rubik(
                                                            fontSize: size.height *
                                                                0.018,
                                                            fontWeight: FontWeight
                                                                .w400,
                                                            color:
                                                                Colors.grey),
                                                      ),
                                                      Text(
                                                        flight.flightInfo.departure.delay !=
                                                                null
                                                            ? flight
                                                                .flightInfo
                                                                .departure
                                                                .delay
                                                                .toString()
                                                            : '0',
                                                        style: TextStyle(
                                                            fontSize: size.height *
                                                                0.018,
                                                            fontWeight: FontWeight
                                                                .bold,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                
                                                
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),

                                      SizedBox(
                                        height: 4.0,
                                      ),

                                      Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius
                                                    .circular(
                                                        20)),
                                        child: Divider(
                                          color: _accentColor,
                                          thickness: 4,
                                        ),
                                      ),
                                      SizedBox(height: 5)
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          
                        ),
                        
                        
                        //third row departure
                        Expanded(
                          child: Row(
                            children: <Widget>[
                              // aircraft info depart
                              Expanded(
                                flex: 2,
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Column(
                                    children: <Widget>[
                                      Expanded(
                                        child: Text(
                                          'Aircraft',
                                          style: TextStyle(
                                              fontSize:
                                                  size.height *
                                                      0.025,
                                              color:
                                                  Colors.black87,
                                              fontWeight:
                                                  FontWeight
                                                      .w600),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 3.0,
                                      ),
                                      flight.flightInfo
                                                  .aircraft !=
                                              null
                                          ? Expanded(
                                              child: Row(
                                                children: <
                                                    Widget>[
                                                  Text(
                                                    'Regist: ',
                                                    style: TextStyle(
                                                        fontSize:
                                                            size.height *
                                                                0.018,
                                                        color: Colors
                                                            .grey,
                                                        fontWeight:
                                                            FontWeight
                                                                .w600),
                                                  ),
                                                  Text(
                                                    flight
                                                        .flightInfo
                                                        .aircraft
                                                        .registration,
                                                    style: TextStyle(
                                                        fontSize:
                                                            size.height *
                                                                0.014,
                                                        color: Colors
                                                            .black87,
                                                        fontWeight:
                                                            FontWeight
                                                                .w600),
                                                  ),
                                                ],
                                              ),
                                            )
                                          : SizedBox(),
                                      Expanded(
                                        child: Row(
                                          children: <Widget>[
                                            Text(
                                              'Iata: ',
                                              style: TextStyle(
                                                  fontSize:
                                                      size.height *
                                                          0.018,
                                                  color:
                                                      Colors.grey,
                                                  fontWeight:
                                                      FontWeight
                                                          .w600),
                                            ),
                                            Text(
                                              'A320-800',
                                              style: TextStyle(
                                                  fontSize:
                                                      size.height *
                                                          0.014,
                                                  color: Colors
                                                      .black87,
                                                  fontWeight:
                                                      FontWeight
                                                          .w600),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              //airline info depart
                              Expanded(
                                flex: 2,
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Column(
                                    children: <Widget>[
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      Expanded(
                                        child: Text(
                                          flight.flightInfo
                                              .airline.iata,
                                          style: TextStyle(
                                              fontSize:
                                                  size.height *
                                                      0.018,
                                              color: Colors.black,
                                              fontWeight:
                                                  FontWeight
                                                      .bold),
                                        ),
                                      ),
                                      Expanded(
                                          child: Icon(
                                        Icons.flight,
                                        size: size.height * 0.03,
                                      )),
                                      Expanded(
                                        child: Text(
                                          flight.flightInfo
                                              .airline.name,
                                          style: TextStyle(
                                              color:
                                                  Colors.black87,
                                              fontWeight:
                                                  FontWeight.bold,
                                              fontSize:
                                                  size.height *
                                                      0.016),
                                          overflow: TextOverflow
                                              .ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              //flight info depart
                              Expanded(
                                flex: 2,
                                child: Container(
                                  alignment:
                                      Alignment.centerRight,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    // mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Expanded(
                                        child: Text(
                                          'Flight',
                                          style: TextStyle(
                                              fontSize:
                                                  size.height *
                                                      0.025,
                                              color:
                                                  Colors.black87,
                                              fontWeight:
                                                  FontWeight
                                                      .w600),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 3.0,
                                      ),
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment
                                                  .center,
                                          children: <Widget>[
                                            Text(
                                              'Number: ',
                                              style: TextStyle(
                                                  fontSize:
                                                      size.height *
                                                          0.018,
                                                  color:
                                                      Colors.grey,
                                                  fontWeight:
                                                      FontWeight
                                                          .w600),
                                            ),
                                            Text(
                                              flight.flightInfo
                                                  .flight.number,
                                              style: TextStyle(
                                                  fontSize:
                                                      size.height *
                                                          0.014,
                                                  color: Colors
                                                      .black87,
                                                  fontWeight:
                                                      FontWeight
                                                          .w600),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 3.0,
                                      ),
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment
                                                  .center,
                                          children: <Widget>[
                                            Text(
                                              'Iata: ',
                                              style: TextStyle(
                                                  fontSize:
                                                      size.height *
                                                          0.018,
                                                  color:
                                                      Colors.grey,
                                                  fontWeight:
                                                      FontWeight
                                                          .w600),
                                            ),
                                            Text(
                                              flight.flightInfo
                                                  .flight.iata,
                                              style: TextStyle(
                                                  fontSize:
                                                      size.height *
                                                          0.014,
                                                  color: Colors
                                                      .black87,
                                                  fontWeight:
                                                      FontWeight
                                                          .w600),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(
                  height: 10.0,
                ),
                //Landing
                Flexible(
                  child: Container(
                    padding: EdgeInsets.all(padding * 0.5),
                    height: size.height,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black12,
                              spreadRadius: 1,
                              blurRadius: 1)
                        ]),
                    child: Column(
                      children: <Widget>[
                        //first row arrival
                        Expanded(
                          child: Row(
                            children: <Widget>[
                              //sheduled arrival
                              Expanded(
                                flex: 2,
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Column(
                                    children: <Widget>[
                                      SizedBox(
                                        height: 15.0,
                                      ),
                                      Text(
                                        'SCHEDULED',
                                        style: GoogleFonts
                                            .montserrat(
                                                fontSize:
                                                    size.height *
                                                        0.018,
                                                color:
                                                    Colors.grey,
                                                fontWeight:
                                                    FontWeight
                                                        .w500),
                                      ),
                                      SizedBox(
                                        height: 7.0,
                                      ),
                                      flight.flightInfo.arrival
                                                  .scheduled !=
                                              null
                                          ? Text(
                                              flight
                                                      .flightInfo
                                                      .arrival
                                                      .scheduled
                                                      .hour
                                                      .toString().padLeft(2,'0') +
                                                  ':' +
                                                  flight
                                                      .flightInfo
                                                      .arrival
                                                      .scheduled
                                                      .minute
                                                      .toString().padLeft(2,'0'),
                                              style: GoogleFonts.montserrat(
                                                  fontSize:
                                                      size.height *
                                                          0.03,
                                                  color: Colors
                                                      .black,
                                                  fontWeight:
                                                      FontWeight
                                                          .w400),
                                            )
                                          : Text(
                                              flight
                                                      .flightInfo
                                                      .arrival
                                                      .estimated
                                                      .hour
                                                      .toString().padLeft(2,'0') +
                                                  ':' +
                                                  flight
                                                      .flightInfo
                                                      .arrival
                                                      .estimated
                                                      .minute
                                                      .toString().padLeft(2,'0'),
                                              style: GoogleFonts.montserrat(
                                                  fontSize:
                                                      size.height *
                                                          0.03,
                                                  color: Colors
                                                      .black,
                                                  fontWeight:
                                                      FontWeight
                                                          .w400),
                                            ),
                                    ],
                                  ),
                                ),
                              ),
                              // landing icon/ data
                              Expanded(
                                flex: 2,
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Column(
                                    children: <Widget>[
                                      Expanded(
                                        child: Text(
                                          'LANDING',
                                          style: GoogleFonts.rubik(
                                              fontSize:
                                                  size.height *
                                                      0.018,
                                              color: Colors.grey,
                                              fontWeight:
                                                  FontWeight
                                                      .w400),
                                        ),
                                      ),
                                      Icon(
                                        Icons.flight_land,
                                        size: size.height * 0.034,
                                        color: Colors.black,
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                      Expanded(
                                        child: Text(
                                          '${flight.flightInfo.arrival.estimated.year.toString()}-${flight.flightInfo.arrival.estimated.month.toString().padLeft(2,'0')}-${flight.flightInfo.arrival.estimated.day.toString().padLeft(2,'0')}',
                                          textAlign:
                                              TextAlign.center,
                                          style: GoogleFonts.rubik(
                                              fontSize:
                                                  size.height *
                                                      0.02,
                                              color: Colors.grey,
                                              fontWeight:
                                                  FontWeight
                                                      .w200),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              //estimaed arrival
                              Expanded(
                                flex: 2,
                                child: Container(
                                  alignment:
                                      Alignment.centerRight,
                                  child: Column(
                                    // crossAxisAlignment: CrossAxisAlignment.start,
                                    // mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      SizedBox(
                                        height: 15.0,
                                      ),
                                      Text(
                                        'ESTIMATED',
                                        style: GoogleFonts
                                            .montserrat(
                                                fontSize:
                                                    size.height *
                                                        0.018,
                                                color:
                                                    Colors.grey,
                                                fontWeight:
                                                    FontWeight
                                                        .w500),
                                      ),
                                      SizedBox(
                                        height: 7.0,
                                      ),
                                      Text(
                                        flight.flightInfo.arrival
                                                .estimated.hour
                                                .toString() +
                                            ':' +
                                            flight
                                                .flightInfo
                                                .arrival
                                                .estimated
                                                .minute
                                                .toString(),
                                        style: GoogleFonts
                                            .montserrat(
                                                fontSize:
                                                    size.height *
                                                        0.03,
                                                color:
                                                    Colors.black,
                                                fontWeight:
                                                    FontWeight
                                                        .w400),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        //second row arrival
                        Expanded(
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                flex: 2,
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.center,
                                    children: <Widget>[
                                      //name airport arrival
                                      Row(
                                        children: <Widget>[
                                          Expanded(
                                            child: Text(
                                                flight.arrCity
                                                    .airportName,
                                                textAlign:
                                                    TextAlign
                                                        .center,
                                                style: GoogleFonts.montserrat(
                                                    color: Colors
                                                        .black,
                                                    fontWeight:
                                                        FontWeight
                                                            .w500,
                                                    fontSize: size
                                                            .height *
                                                        0.025),
                                                overflow:
                                                    TextOverflow
                                                        .ellipsis),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      //terminal /gate / delay airport arrival
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceEvenly,
                                          children: <Widget>[
                                            Column(
                                              children: <Widget>[
                                                //terminal arrival
                                                Expanded(
                                                  child: Row(
                                                    children: <
                                                        Widget>[
                                                      Text(
                                                        'TERMINAL: ',
                                                        style: GoogleFonts.rubik(
                                                            fontSize: size.height *
                                                                0.018,
                                                            fontWeight: FontWeight
                                                                .w400,
                                                            color:
                                                                Colors.grey),
                                                      ),
                                                      Text(
                                                        flight.flightInfo.arrival.terminal !=
                                                                null
                                                            ? flight
                                                                .flightInfo
                                                                .arrival
                                                                .terminal
                                                            : '?',
                                                        style: TextStyle(
                                                            fontSize: size.height *
                                                                0.018,
                                                            fontWeight: FontWeight
                                                                .bold,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                            Column(
                                              children: <Widget>[
                                                //gate arrival
                                                Expanded(
                                                  child: Row(
                                                    children: <
                                                        Widget>[
                                                      Text(
                                                        'GATE: ',
                                                        style: GoogleFonts.rubik(
                                                            fontSize: size.height *
                                                                0.018,
                                                            fontWeight: FontWeight
                                                                .w400,
                                                            color:
                                                                Colors.grey),
                                                      ),
                                                      Text(
                                                        flight.flightInfo.arrival.gate !=
                                                                null
                                                            ? flight
                                                                .flightInfo
                                                                .arrival
                                                                .gate
                                                            : '?',
                                                        style: TextStyle(
                                                            fontSize: size.height *
                                                                0.018,
                                                            fontWeight: FontWeight
                                                                .bold,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                            Column(
                                              children: <Widget>[
                                                //delay arrival
                                                Expanded(
                                                  child: Row(
                                                    children: <
                                                        Widget>[
                                                      Text(
                                                        'DELAY: ',
                                                        style: GoogleFonts.rubik(
                                                            fontSize: size.height *
                                                                0.018,
                                                            fontWeight: FontWeight
                                                                .w400,
                                                            color:
                                                                Colors.grey),
                                                      ),
                                                      Text(
                                                        flight.flightInfo.arrival.delay !=
                                                                null
                                                            ? flight
                                                                .flightInfo
                                                                .arrival
                                                                .delay
                                                                .toString()
                                                            : '0',
                                                        style: TextStyle(
                                                            fontSize: size.height *
                                                                0.018,
                                                            fontWeight: FontWeight
                                                                .bold,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                    height: 5)
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),

                                      SizedBox(
                                        height: 4.0,
                                      ),

                                      // divider arrival
                                      Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius
                                                    .circular(
                                                        20)),
                                        child: Divider(
                                          color: _accentColor,
                                          thickness: 4,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        //third row arrival
                        Expanded(
                          child: Row(
                            children: <Widget>[
                              //aircraft info arrival
                              Expanded(
                                flex: 2,
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Column(
                                    children: <Widget>[
                                      Expanded(
                                        child: Text(
                                          'Aircraft',
                                          style: TextStyle(
                                              fontSize:
                                                  size.height *
                                                      0.025,
                                              color:
                                                  Colors.black87,
                                              fontWeight:
                                                  FontWeight
                                                      .w600),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 3.0,
                                      ),
                                      flight.flightInfo
                                                  .aircraft !=
                                              null
                                          ? Expanded(
                                              child: Row(
                                                children: <
                                                    Widget>[
                                                  Text(
                                                    'Regist: ',
                                                    style: TextStyle(
                                                        fontSize:
                                                            size.height *
                                                                0.018,
                                                        color: Colors
                                                            .grey,
                                                        fontWeight:
                                                            FontWeight
                                                                .w600),
                                                  ),
                                                  Text(
                                                    flight
                                                        .flightInfo
                                                        .aircraft
                                                        .registration,
                                                    style: TextStyle(
                                                        fontSize:
                                                            size.height *
                                                                0.014,
                                                        color: Colors
                                                            .black87,
                                                        fontWeight:
                                                            FontWeight
                                                                .w600),
                                                  ),
                                                ],
                                              ),
                                            )
                                          : SizedBox(),
                                      Expanded(
                                        child: Row(
                                          children: <Widget>[
                                            Text(
                                              'Iata: ',
                                              style: TextStyle(
                                                  fontSize:
                                                      size.height *
                                                          0.018,
                                                  color:
                                                      Colors.grey,
                                                  fontWeight:
                                                      FontWeight
                                                          .w600),
                                            ),
                                            Text(
                                              'A320-800',
                                              style: TextStyle(
                                                  fontSize:
                                                      size.height *
                                                          0.014,
                                                  color: Colors
                                                      .black87,
                                                  fontWeight:
                                                      FontWeight
                                                          .w600),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              //airline info arrival
                              Expanded(
                                flex: 2,
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Column(
                                    children: <Widget>[
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      Expanded(
                                        child: Text(
                                            flight.flightInfo
                                                .airline.iata,
                                            style: TextStyle(
                                                fontSize:
                                                    size.height *
                                                        0.018,
                                                color:
                                                    Colors.black,
                                                fontWeight:
                                                    FontWeight
                                                        .bold)),
                                      ),
                                      Expanded(
                                          child: Icon(
                                        Icons.flight,
                                        size: size.height * 0.03,
                                      )),
                                      Expanded(
                                        child: Text(
                                            flight.flightInfo
                                                .airline.name,
                                            style: TextStyle(
                                                color: Colors
                                                    .black87,
                                                fontWeight:
                                                    FontWeight
                                                        .bold,
                                                fontSize:
                                                    size.height *
                                                        0.016),
                                            overflow: TextOverflow
                                                .ellipsis),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              //flight ino arrival
                              Expanded(
                                flex: 2,
                                child: Container(
                                  alignment:
                                      Alignment.centerRight,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Expanded(
                                        child: Text(
                                          'Flight',
                                          style: TextStyle(
                                              fontSize:
                                                  size.height *
                                                      0.025,
                                              color:
                                                  Colors.black87,
                                              fontWeight:
                                                  FontWeight
                                                      .w600),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 3.0,
                                      ),
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment
                                                  .center,
                                          children: <Widget>[
                                            Text(
                                              'Number: ',
                                              style: TextStyle(
                                                  fontSize:
                                                      size.height *
                                                          0.018,
                                                  color:
                                                      Colors.grey,
                                                  fontWeight:
                                                      FontWeight
                                                          .w600),
                                            ),
                                            Text(
                                              flight.flightInfo
                                                  .flight.number,
                                              style: TextStyle(
                                                  fontSize:
                                                      size.height *
                                                          0.014,
                                                  color: Colors
                                                      .black87,
                                                  fontWeight:
                                                      FontWeight
                                                          .w600),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 3.0,
                                      ),
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment
                                                  .center,
                                          children: <Widget>[
                                            Text(
                                              'Iata: ',
                                              style: TextStyle(
                                                  fontSize:
                                                      size.height *
                                                          0.018,
                                                  color:
                                                      Colors.grey,
                                                  fontWeight:
                                                      FontWeight
                                                          .w600),
                                            ),
                                            Text(
                                              flight.flightInfo
                                                  .flight.iata,
                                              style: TextStyle(
                                                  fontSize:
                                                      size.height *
                                                          0.014,
                                                  color: Colors
                                                      .black87,
                                                  fontWeight:
                                                      FontWeight
                                                          .w600),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      );
  }
}

// ARC ROUTE
class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.white
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    var path = Path()
      ..moveTo(0, size.height * 0.5)
      //..lineTo(0, size.height * 0.8)
      ..quadraticBezierTo(size.width * 0.5, 0, size.width, size.height * 0.5);

    canvas.drawPath(
        dashPath(
          path,
          dashArray: CircularIntervalList<double>(<double>[8.0, 8.0]),
        ),
        paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
