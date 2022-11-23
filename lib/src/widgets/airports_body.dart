import 'package:flights/src/models/airport_model.dart';
import 'package:flights/src/services/airports_service.dart';
import 'package:flights/src/services/home_services.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AirportsBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: size.height * 0.65,
      child: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              SizedBox(height: 10),
              SearchAirport(),
              SizedBox(height: 10),
              CardAirport()
            ],
          )
        ],
      ),
    );
  }
}

class SearchAirport extends StatefulWidget {
  @override
  _SearchAirportState createState() => _SearchAirportState();
}

class _SearchAirportState extends State<SearchAirport> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      width: 380,
      height: 70,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(50),
          boxShadow: [
            BoxShadow(
                color: Colors.black12, offset: Offset(0, 10), blurRadius: 30),
          ]),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        width: 300,
        height: 50,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                  color: Colors.black12, offset: Offset(0, 10), blurRadius: 30),
            ]),
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 3),
            child: TextField(
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  // border: InputBorder.none,
                  hintText: 'Search an Airport',
                  prefixIcon: Icon(Icons.search)),
              onChanged: (value) {
                final queryService =
                    Provider.of<HomeService>(context, listen: false);
                queryService.query = value;
              },
            ),
          ),
        ),
      ),
    );
  }
}

class CardAirport extends StatelessWidget {
  final airportsProvider = new Airportsprovider();
// String query = 'b';
  @override
  Widget build(BuildContext context) {
    final queryService = Provider.of<HomeService>(context).query;
    return Expanded(
      child: Container(
        child: FutureBuilder(
          future: (queryService != ' ')
              ? airportsProvider.buscarAeropuerto(context, queryService)
              : airportsProvider.getIntialAeropuertos(context),
          builder: (BuildContext context,
              AsyncSnapshot<List<Map<String, OurAirport>>> snapshot) {
            if (snapshot.hasData) {
             
              final aerupuertos = snapshot.data;
              List<String> title = [];
              List<String> place = [];
              String loca;
              List<String> iataCode = [];

              return ListView.builder(
                itemCount: aerupuertos.length,
                itemBuilder: (BuildContext context, int index) {
                  aerupuertos.forEach((airport) {
                    
                    airport.forEach((key, value) {
                      title.add(key);
                      place.add(value.cityName);
                      loca = value.firebase;
                      iataCode.add(value.iata);
                    });
                  });
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, 'detalleairport',
                          arguments: iataCode[index]);
                    },
                    child: Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15)),
                      child: ListTile(
                        leading: Text(
                          iataCode[index] != null ? iataCode[index] : '',
                          style: GoogleFonts.rubik(
                            fontSize: 25,
                            fontWeight: FontWeight.w300,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        title: Text(title[index] != null ? title[index] : '',
                            style: GoogleFonts.rubik(
                              fontWeight: FontWeight.w300,
                            )),
                        subtitle: Text(place[index] != null ? place[index] : '',
                            style: GoogleFonts.rubik(
                                fontWeight: FontWeight.w200,
                                fontStyle: FontStyle.italic)),
                      ),
                    ),
                  );
                },
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
