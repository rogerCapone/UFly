import 'package:flights/src/models/airport_detalle_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong/latlong.dart';

class AirportInfrastructure extends StatelessWidget {
  final Airport airportInfo;
  AirportInfrastructure({@required this.airportInfo});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios),
          ),
          centerTitle: true,
          title: Text(
            airportInfo.airportInfo.name,
            style: GoogleFonts.rubik(
              fontWeight: FontWeight.w200,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: size.height * 0.01),
              Center(
                child: Container(
                  // margin: EdgeInsets.symmetric(
                  //     horizontal: size.width * 0.1,
                  //     vertical: size.height * 0.005),
                  width: size.width * 0.7,
                  height: size.height * 0.16,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.blue,
                            offset: Offset(0, 6),
                            blurRadius: 5),
                      ]),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(airportInfo.airportInfo.iata,
                              style:
                                  TextStyle(fontSize: 20, color: Colors.grey))
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(airportInfo.airportInfo.name,
                              overflow: TextOverflow.ellipsis,
                              style:
                                  TextStyle(fontSize: 16, color: Colors.black))
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(airportInfo.airportInfo.location,
                              overflow: TextOverflow.ellipsis,
                              style:
                                  TextStyle(fontSize: 14, color: Colors.grey))
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text('${airportInfo.airportInfo.countryIso}, ',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold)),
                          SizedBox(width: 5),
                          Text(airportInfo.airportInfo.country,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold))
                        ],
                      ),
                      SizedBox(height: 5),
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 15.0),
                height: size.height * 0.36,
                width: size.width * 0.95,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: size.width * 0.05),
                        child: Text('Information Report',
                            style: GoogleFonts.rubik(
                                fontSize: 20, fontWeight: FontWeight.w500)),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          _columnTitles(),
                          _columnInformation(airportInfo.airportInfo)
                        ],
                      ),
                      SizedBox(height: 15),
                      Container(
                   
                        child: SelectableText(
                          airportInfo.airportInfo.website,
                          style: GoogleFonts.rubik(
                              fontSize: 15, fontWeight: FontWeight.w200),
                          textAlign: TextAlign.center,
                          enableInteractiveSelection: true,
                        ),
                      )
                    ]),
              ),
              SizedBox(height: 10),
              Container(
                height: size.height * 0.7,
                width: size.width,
                child: FlutterMap(
                    options: MapOptions(
                        center: new LatLng(airportInfo.airportInfo.latitude,
                            airportInfo.airportInfo.longitude),
                        zoom: 12),
                    layers: [
                      TileLayerOptions(
                          urlTemplate:
                              'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                          subdomains: ['a', 'b', 'c']),
                      MarkerLayerOptions(
                        markers: [
                          new Marker(
                            width: 25.0,
                            height: 25.0,
                            point: new LatLng(airportInfo.airportInfo.latitude,
                                airportInfo.airportInfo.longitude),
                            builder: (ctx) => new Container(
                                child: new Icon(
                              Icons.location_on,
                              color: Colors.blue,
                              size: 35,
                            )),
                          ),
                        ],
                      ),
                    ]),
              ),
            ],
          ),
        ));
  }

  Widget _columnTitles() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Text(
          'Country',
          style: GoogleFonts.rubik(fontSize: 15.5, fontWeight: FontWeight.w500),
        ),
        Text(
          'Aiport Name',
          style: GoogleFonts.rubik(fontSize: 15.5, fontWeight: FontWeight.w500),
        ),
        Text(
          'Aiport IATA',
          style: GoogleFonts.rubik(fontSize: 15.5, fontWeight: FontWeight.w500),
        ),
        Text(
          'Aiport ICAO',
          style: GoogleFonts.rubik(fontSize: 15.5, fontWeight: FontWeight.w500),
        ),
        Text(
          'Airport Phone Num',
          style: GoogleFonts.rubik(fontSize: 15.5, fontWeight: FontWeight.w500),
        ),
        Text(
          'Postal Code',
          style: GoogleFonts.rubik(fontSize: 15.5, fontWeight: FontWeight.w500),
        ),
        Text(
          'Airport UCT',
          style: GoogleFonts.rubik(fontSize: 15.5, fontWeight: FontWeight.w500),
        )
      ],
    );
  }

  Widget _columnInformation(AirportInfo airportInfo) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            airportInfo.country + ', ' + airportInfo.countryIso,
            style: GoogleFonts.rubik(fontSize: 15.5, fontWeight: FontWeight.w200),
          ),
          Text(
            airportInfo.name,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.rubik(fontSize: 15.5, fontWeight: FontWeight.w200),
          ),
          Text(
            airportInfo.iata,
            style: GoogleFonts.rubik(fontSize: 15.5, fontWeight: FontWeight.w200),
          ),
          Text(
            airportInfo.icao,
            style: GoogleFonts.rubik(fontSize: 15.5, fontWeight: FontWeight.w200),
          ),
          Text(
            airportInfo.phone,
            style: GoogleFonts.rubik(fontSize: 15.5, fontWeight: FontWeight.w200),
          ),
          Text(
            airportInfo.postalCode,
            style: GoogleFonts.rubik(fontSize: 15.5, fontWeight: FontWeight.w200),
          ),
          Text(
            airportInfo.uct.toString(),
            style: GoogleFonts.rubik(fontSize: 15.5, fontWeight: FontWeight.w200),
          )
        ],
      ),
    );
  }
}
