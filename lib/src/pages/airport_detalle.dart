import 'package:flights/src/models/airport_detalle_model.dart';
import 'package:flights/src/pages/airport/airport_infrastructure.dart';
import 'package:flights/src/pages/flight/flight_detalle.dart';
import 'package:flights/src/services/airports_service.dart';
import 'package:flights/src/services/home_services.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();

class AirportPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String code = ModalRoute.of(context).settings.arguments;

    final airportsProvider = new Airportsprovider();

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.blueAccent, Colors.black12])),
        child: FutureBuilder(
            future: airportsProvider.getDetalleAirport(code),
            builder: (BuildContext context, AsyncSnapshot<Airport> snapshot) {
              if (snapshot.hasData) {
                final airports = snapshot.data;

                return _airportDetalleComponentes(airportDetalle: airports);
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      ),
    );
  }
}

class _airportDetalleComponentes extends StatelessWidget {
  final Airport airportDetalle;

  _airportDetalleComponentes({@required this.airportDetalle});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          _appbarAirport(),
          _capceleraAirport(airportDetalle: airportDetalle),
          _airportBody(airportDetalle: airportDetalle),
        ],
      ),
    );
  }
}

class _appbarAirport extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(width: 15),
            Icon(Icons.arrow_back, color: Colors.white, size: 30)
          ],
        ),
      ),
    );
  }
}

class _capceleraAirport extends StatelessWidget {
  final Airport airportDetalle;

  _capceleraAirport({@required this.airportDetalle});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: size.width * 0.1, vertical: size.height * 0.005),
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      width: size.width * 0.8,
      height: size.height * 0.2,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(color: Colors.black, offset: Offset(0, 6), blurRadius: 6),
          ]),
      child: Column(
        children: <Widget>[
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(airportDetalle.airportInfo.iata,
                  style: TextStyle(fontSize: 20, color: Colors.grey))
            ],
          ),
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Text(airportDetalle.airportInfo.name,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.black)),
              )
            ],
          ),
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(airportDetalle.airportInfo.location,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14, color: Colors.grey))
            ],
          ),
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('${airportDetalle.airportInfo.countryIso}, ',
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold)),
              SizedBox(width: 5),
              Text(airportDetalle.airportInfo.country,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.bold))
            ],
          ),
          SizedBox(height: 5),
          Divider(
            height: 5,
            color: Colors.blue,
          ),
          SizedBox(height: 5),
          SizedBox(height: 5),
          airportDetalle.airportInfo.latitude != null &&
                  airportDetalle.airportInfo.latitude != null
              ? Container(
                  child: GestureDetector(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'More Info',
                          style: GoogleFonts.rubik(fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          width: size.width * 0.02,
                        ),
                        Icon(Icons.more,
                            size: 15, color: Colors.lightBlueAccent),
                      ],
                    ),
                    onTap: () {
                      print('Tapped');
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  AirportInfrastructure(
                                      airportInfo: airportDetalle)));
                    },
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}

class _airportBody extends StatefulWidget {
  final Airport airportDetalle;

  _airportBody({@required this.airportDetalle});

  @override
  __airportBodyState createState() => __airportBodyState(airportDetalle);
}

enum TripType { departs, arrivals }

Map<TripType, String> _tripTypes = {
  TripType.departs: 'DEPARTURES',
  TripType.arrivals: 'ARRIVALS',
};

class __airportBodyState extends State<_airportBody> {
  final airportDetalle;

  TripType _selectedTrip = TripType.departs;

  __airportBodyState(this.airportDetalle);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: Column(
          children: <Widget>[
            SizedBox(height: 10),
            Container(
              height: 40,
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0, 6),
                        blurRadius: 6),
                  ]),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: List.generate(_tripTypes.length, (index) {
                  return buildTripTypeSelector(
                      _tripTypes.keys.elementAt(index));
                }),
              ),
            ),
            SizedBox(height: 5),
            Expanded(
              child: FlipCard(
                flipOnTouch: false,
                key: cardKey,
                direction: FlipDirection.HORIZONTAL,
                speed: 1000,
                onFlipDone: (status) {
                  status = false;
                },
                front: Container(
                  child: PageView(
                    scrollDirection: Axis.vertical,
                    children: <Widget>[
                      _crearCardDepart(context, airportDetalle)
                    ],
                  ),
                ),
                back: Container(
                  child: PageView(
                    scrollDirection: Axis.vertical,
                    children: <Widget>[
                      _crearCardDepart(context, airportDetalle)
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _crearCardDepart(BuildContext context, Airport airports) {
    final typeSelect = Provider.of<HomeService>(context);

    final airport = (typeSelect.selectDepArr == TripType.departs.toString())
        ? airports.airportDepartures
        : airports.airportArrivals;

    return ListView.builder(
      itemCount: airport.length,
      itemBuilder: (BuildContext context, int index) {
        return Slidable(
          actionPane: SlidableDrawerActionPane(),
          actionExtentRatio: 0.25,
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          FlightDetalle(flightId: airport[index].flight.iata)));
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0, 6),
                        blurRadius: 6),
                  ]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(width: 5, height: 5),
                  Column(
                    children: <Widget>[
                      SizedBox(width: 5, height: 7),
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: NetworkImage(
                                  'https://images.kiwi.com/airlines/64/${airport[index].airline.iata}.png'),
                              fit: BoxFit.fill,
                            )),
                      ),
                      SizedBox(width: 5, height: 7),
                    ],
                  ),
                  SizedBox(width: 5),
                  Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(airport[index].flight.iata.substring(0, 2) + ' ',
                              style: GoogleFonts.rubik(
                                  fontWeight: FontWeight.w500)),
                          Text(airport[index].flight.iata.substring(2),
                              style: GoogleFonts.rubik(
                                  fontWeight: FontWeight.w500)),
                        ],
                      ),
                      SizedBox(height: 3),
                      Text(
                        airport[index].departure.iata +
                          
                              ' - ' +
                             airport[index].arrival.iata,
                          style:
                              GoogleFonts.rubik(fontWeight: FontWeight.w300)),
                    ],
                  ),
                  SizedBox(width: 5),
                  Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text('Estimated: ',
                              style: GoogleFonts.rubik(
                                  fontWeight: FontWeight.w300)),
                          SizedBox(width: 5.0),
                          Text(
                              airport[index]
                                      .departure
                                      .estimated
                                      .hour
                                      .toString()
                                      .padLeft(2, '0') +
                                  ':' +
                                  airport[index]
                                      .departure
                                      .estimated
                                      .minute
                                      .toString()
                                      .padLeft(2, '0'),
                              style: GoogleFonts.rubik(
                                  fontWeight: FontWeight.w500)),
                          SizedBox(height: 5.0),
                          // Text('Actual: '),
                          // Text(airport[index].departure.actual.hour.toString().padLeft(2,'0')+':'+airport[index].departure.actual.minute.toString().padLeft(2,'0') != null
                          //     ? airport[index].departure.actual.hour.toString().padLeft(2,'0')+':'+airport[index].departure.actual.minute.toString().padLeft(2,'0')
                          //     : 'N/A'
                          // )
                        ],
                      )
                    ],
                  ),
                  SizedBox(width: 10.0),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            IconSlideAction(
                caption: 'Share',
                color: Colors.indigo,
                icon: Icons.share,
                onTap: () {}
                // => _showSnackBar('Share'),
                ),
          ],
          secondaryActions: <Widget>[
            IconSlideAction(
                caption: 'Archive',
                color: Colors.blue,
                icon: Icons.archive,
                onTap: () {}
                // => _showSnackBar('Archive'),
                ),
            // IconSlideAction(
            //   caption: 'Delete',
            //   color: Colors.red,
            //   icon: Icons.delete,
            //   onTap: () {}
            //   // => _showSnackBar('Delete'),
            // ),
          ],
        );
      },
    );
  }

  Widget buildTripTypeSelector(TripType tripType) {
    var isSelected = _selectedTrip == tripType;
    return FlatButton(
      padding: EdgeInsets.only(left: 4, right: 16),
      onPressed: () {
        setState(() {
          _selectedTrip = tripType;
          final typeSelect = Provider.of<HomeService>(context, listen: false);
          typeSelect.selectDepArr = _selectedTrip.toString();
        });

        if (_selectedTrip == TripType.arrivals) {
          cardKey.currentState.toggleCard();
        }
        if (_selectedTrip == TripType.departs) {
          cardKey.currentState.toggleCard();
        }
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      color: isSelected ? Colors.blue : Colors.transparent,
      child: Row(
        children: <Widget>[
          Icon(
            Icons.check_circle,
            color: Colors.white,
          ),
          SizedBox(width: 5.0),
          Text(
            _tripTypes[tripType],
            style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
