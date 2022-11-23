import 'package:flights/src/models/airport_model.dart';
import 'package:flights/src/services/airports_service.dart';
import 'package:flights/src/services/home_services.dart';
import 'package:flights/src/services/search_provider.dart';
import 'package:flights/src/widgets/flip_card_widget.dart';
import 'package:flights/src/widgets/resultados_tickets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';



class SearchTickets extends StatefulWidget {
  
  
  @override
  _SearchTicketsState createState() => _SearchTicketsState();
}


class _SearchTicketsState extends State<SearchTickets> {




  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              CapceleraSearch(),
              FlipCardBack()
            ],
          ),
          SearchBody(),
          
          
          
          
        ],
      )
    );
  }
















   
}

class FlipCardBack extends StatefulWidget {
 


  @override
  _FlipCardBackState createState() => _FlipCardBackState();
}

class _FlipCardBackState extends State<FlipCardBack> {

  

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 46,
      right: 20,
      child: Column(
        children: <Widget>[
          GestureDetector(
            child: Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
                child: Icon(Icons.flip_to_front),
            ),
            onTap: () {
              setState(() {
                cardKey.currentState.toggleCard();
              });
              
            },
          ),
          SizedBox(height: 30),
          GestureDetector(
            child: Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
                child: Icon(Icons.edit),
            ),
            onTap: () {
              setState(() {
                final pantalla = Provider.of<HomeService>(context, listen: false);
                pantalla.pantallaSearch = true;
              });
              
            },
          ),
        ],
      ),
    );
  }
}



class SearchBody extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final pantalla = Provider.of<HomeService>(context);

    return Flexible(
      child: Container(
        child: Column(
          children: <Widget>[
            
            (pantalla.pantallaSearch == true) 
            ? InputParmSearch()
            : ResultadosTickets()
  
            
            
          ],
        ),
      )
    );
  }
}

class InputParmSearch extends StatefulWidget {


  @override
  _InputParmSearchState createState() => _InputParmSearchState();
}

class _InputParmSearchState extends State<InputParmSearch> {

  double _valorSliderTravellers = 1;


  @override
  Widget build(BuildContext context) {
    
     

    final type = Provider.of<HomeService>(context);
    final fecha = Provider.of<SearchProvider>(context);
   
    return Expanded(
      child: Container(
        width: double.infinity,
        // height: 335,
        color: Colors.red,
        child: Column(
          children: <Widget>[
            FlatButton(
              color: Colors.white,
              padding: EdgeInsets.all(15),
              onPressed: () {
                  final changeOrigen = Provider.of<SearchProvider>(context, listen: false);
                  changeOrigen.isOrigen = true;
                  
                   _changeAirportBottomSheet(context);
              },
              child: buildAirportSelector(context,
                   
                    Icons.flight_takeoff),
            ),
            Container(height: 1, color: Colors.black26),
            
            FlatButton(
              color: Colors.white,
              padding: EdgeInsets.all(15),
              onPressed: () {
                final changeOrigen = Provider.of<SearchProvider>(context, listen: false);
                changeOrigen.isOrigen = false;
                
                _changeAirportBottomSheet(context);
                 
              },
              child: buildAirportSelector(context,
                    Icons.flight_land),
            ),
            
            Container(height: 1, color: Colors.black26),
           
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: FlatButton(
                      color: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      onPressed: () {
                         showDatePicker(
                          context: context, 
                          initialDate: fecha.dateTimeDep, 
                          firstDate: fecha.dateTimeActual,
                          lastDate: DateTime(2025),
                        ).then((date){
                          setState(() {
                            if(date != null) {
                               fecha.dateTimeDep = date;
                               if(fecha.dateTimeArr.day < fecha.dateTimeDep.day  || fecha.dateTimeArr.month < fecha.dateTimeDep.month){
                                 fecha.dateTimeArr = date;
                               }
                               
                              
                            }
                           
                            
                          });
                        });
                      },
                      child: buildDateSelector('DEPARTURE', fecha.dateTimeDep),
                    ),
                  ),
                   (type.typeSearchSelected == type.fixType) ?
                  Expanded(
                    child: FlatButton(
                      color: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      onPressed: () {
                                                
                        showDatePicker(
                          context: context, 
                          initialDate: fecha.dateTimeDep, 
                          firstDate: fecha.dateTimeDep, 
                          lastDate: DateTime(2025),

                        ).then((date){
                          setState(() {
                            if(date != null) 
                            fecha.dateTimeArr = date;
                          });
                        });
                      },
                      child: buildDateSelector(
                          'RETURN', fecha.dateTimeArr),
                    ),
                  ) : SizedBox()
                  
                ]
              ), 
              Container(height: 1, color: Colors.black26),
              Row(
               children: <Widget>[
                 
                 Expanded(
                   child: FlatButton(
                     color: Colors.white,
                     
                     padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    onPressed: null,
                    child: _crearSlider(),
                   )
                 )
               ],
             ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: FlatButton(
                      color: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      onPressed: () {},
                      child: buildTravellersView('TRAVELLERS', _valorSliderTravellers),
                    ),
                  ),
                  Expanded(
                    child: FlatButton(
                      color: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      onPressed: () {},
                      child: Row(
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'CABIN CLASS',
                                style: GoogleFonts.overpass(
                                    fontSize: 16, color: Colors.grey),
                              ),
                              Text(
                                'ECONOMY\nCLASS',
                                style: GoogleFonts.overpass(fontSize: 20),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            Stack(
                children: <Widget>[
                  Container(
                    height: 20,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          offset: Offset(0, 12),
                          blurRadius: 12,
                        ),
                      ],
                      borderRadius: BorderRadius.vertical(
                          bottom: Radius.elliptical(
                              MediaQuery.of(context).size.width * 2, 100)),
                    ),
                  ),
                  Center(
                    child: Material(
                      color: Colors.blue,
                      shape: CircleBorder(),
                      clipBehavior: Clip.antiAlias,
                      elevation: 16,
                      child: GestureDetector(
                        onTap: () {
                         
                         final pantalla = Provider.of<HomeService>(context, listen: false);
                         pantalla.pantallaSearch = false;
                        },
                        child: Container(
                          width: 100,
                          height: 100,
                          alignment: Alignment.center,
                          color: Colors.blueAccent,
                          child: Text(
                            'SEARCH',
                            style: GoogleFonts.overpass(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Container(
                  
                  
                ),
              )
          ],
        ),
      ),
    );
  }

  Widget _crearSlider(){

    

    return Slider(
      activeColor: Colors.indigoAccent,
      label: 'Price',
      value: _valorSliderTravellers ,
      min: 1.0,
      max: 15,
      onChanged: (valor) {
        setState(() {
           _valorSliderTravellers  = valor;
        });
       

      },
     


    );
  }
  void _changeAirportBottomSheet(context) {


      

    showBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 350,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(60), bottomRight: Radius.circular(60)),
            color: Colors.transparent,
          ),
          
          //  setState(() {
          //           Navigator.pop(context);
          //         });
          
          
          child: Wrap(
            children: <Widget>[
              Container(
                height: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40)),
                  color: Colors.grey.withOpacity(0.7)
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    ChangeAirportSearch(),
                    AirportsListSugesstion()
                  ],
                )
              )
            ],
          ),
        );
        
      },
      backgroundColor: Colors.transparent
    );
  }








  Widget buildDateSelector(String title, DateTime datTime) {

  

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: GoogleFonts.overpass(fontSize: 18, color: Colors.grey),
        ),
        Row(
          children: <Widget>[
            Text(
              datTime.day.toString().padLeft(2, '0'),
              style: GoogleFonts.overpass(fontSize: 38),
            ),
            SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  DateFormat('MMM, yyyy').format(datTime),
                  style: GoogleFonts.overpass(fontSize: 16),
                ),
                Text(
                  DateFormat('EEEE').format(datTime),
                  style: GoogleFonts.overpass(fontSize: 16, color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

Widget buildTravellersView(String title, double numero) {
    return Row(
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: GoogleFonts.overpass(fontSize: 18, color: Colors.grey),
            ),
            Text(
              numero.truncate().toString(),
              style: GoogleFonts.overpass(fontSize: 38.5),
            )
          ],
        ),
      ],
    );
  }


}

class AirportsListSugesstion extends StatefulWidget {

  @override
  _AirportsListSugesstionState createState() => _AirportsListSugesstionState();
}

class _AirportsListSugesstionState extends State<AirportsListSugesstion> {
final airportsProvider = new Airportsprovider();

  @override
  Widget build(BuildContext context) {
    
    final queryService = Provider.of<HomeService>(context).query;

    return Expanded(
      child: Container(
         child: FutureBuilder(
          future: (queryService != '') 
                  ? airportsProvider.buscarAeropuerto(context, queryService)
                  : airportsProvider.getIntialAeropuertos(context),
          builder: (BuildContext context, AsyncSnapshot<List<Map<String, OurAirport>>> snapshot) {
            
            if(snapshot.hasData){

        final  aerupuertos = snapshot.data;
        String title;
        String place;
        String loca;
        String iataCode;

        return ListView.builder(
          itemCount: aerupuertos.length,
          itemBuilder: (BuildContext context, int index) {
            aerupuertos.forEach((airport){
              airport.forEach((key, value){
                title = key.toString();
                place = value.cityName;
                loca = value.firebase;
                iataCode = value.iata;
              });
            });
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15)
            ),
            child: GestureDetector(
              onTap: () {
                final changeOrigen = Provider.of<SearchProvider>(context, listen: false);
              
                if (changeOrigen.isOrigen == true) {
                     changeOrigen.cityNameOrg = place;
                     changeOrigen.airportNameOrg = title;
                     changeOrigen.codeIataOrg = iataCode;
                } else {
                  changeOrigen.cityNameDes = place;
                  changeOrigen.airportNameDes = title;
                  changeOrigen.codeIataDes = iataCode;
                }

               Navigator.pop(context);
                
                
                
                
              },
              child: ListTile(
                leading: Text(iataCode != null ? iataCode : ''),
                title: Text(title != null ? title : ''),
                subtitle: Text(place != null ? place : ''),
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

class ChangeAirportSearch extends StatelessWidget {
  const ChangeAirportSearch({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        height: 50,
        width: 300, 
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(color: Colors.black12,
            offset: Offset(0, 10),
            blurRadius: 30),
          ]
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Search Airport',
                suffixIcon: Icon(Icons.search)
              ),
              onChanged: (value) {
                final queryService = Provider.of<HomeService>(context, listen: false);
                queryService.query = value;
              },
            ),
          ),
          
        ),
      ),
    );
  }
}

// class AirportSelector extends StatelessWidget {


//   @override
//   Widget build(BuildContext context) {
//     return Floating
//   }
// }





























class CapceleraSearch extends StatefulWidget {
 
  @override
  _CapceleraSearchState createState() => _CapceleraSearchState();
}
enum TripType { roundtrip, oneway}

Map<TripType, String> _tripTypes = {
  TripType.roundtrip: 'RoundTrip',
  TripType.oneway: 'Oneway',
  
  // TripType.multicity: 'Multicity'
};


class _CapceleraSearchState extends State<CapceleraSearch> {

  TripType _selectedTrip = TripType.roundtrip;

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: size.height * 0.21,
      // color: Colors.red,
      child: SafeArea(
        child: Column(
          
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
           SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                
                RichText(
                  text: TextSpan(
                    style: TextStyle(color: Colors.white, fontSize: 32),
                  
                  children: [
                    TextSpan(
                      text: 'Flight',
                      style: GoogleFonts.overpass(fontWeight: FontWeight.w200)),
                    TextSpan(
                      text: 'Search',
                      style: GoogleFonts.overpass(fontWeight: FontWeight.bold)),
                    
                  ]),
                  
                ),
               
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                padding: EdgeInsets.symmetric(horizontal: 8),
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
                  children: List.generate(_tripTypes.length, (index) {
                    return buildTripTypeSelector(
                        _tripTypes.keys.elementAt(index));
                  }),
                  
                ),
              
              ),
              ],
            ),
             
            
          ],
        ),
      ),
    );
  }



   Widget buildTripTypeSelector(TripType tripType) {
    var isSelected = _selectedTrip == tripType;
    return FlatButton(
      padding: EdgeInsets.only(left: 4, right: 16),
      onPressed: () {
        
        setState(() {
          _selectedTrip = tripType;

          final type = Provider.of<HomeService>(context, listen: false);
          type.typeSearchSelected = _selectedTrip.toString();
           type.fixType = TripType.roundtrip.toString();
          
        });
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      color: isSelected ? Colors.blue : Colors.transparent,
      child: Row(
        children: <Widget>[
          if (isSelected)
            Icon(
              Icons.check_circle,
              color: Colors.white,
            ),
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


   Widget buildAirportSelector(BuildContext context, IconData icon) {

     final inputSearch = Provider.of<SearchProvider>(context);
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 70,
              child: Text(
                (icon == Icons.flight_takeoff) 
                ? inputSearch.codeIataOrg
                : inputSearch.codeIataDes,
                style: GoogleFonts.overpass(
                    fontWeight: FontWeight.w600,
                    fontSize: 24,
                    color: Colors.black54),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  (icon == Icons.flight_takeoff)
                  ? inputSearch.cityNameOrg
                  : inputSearch.cityNameDes,
                  style:
                      GoogleFonts.overpass(fontSize: 24, color: Colors.black87),
                ),
                Text(
                  (icon == Icons.flight_takeoff)
                  ? inputSearch.airportNameOrg
                  : inputSearch.airportNameDes,
                  style:
                      GoogleFonts.overpass(fontSize: 12, color: Colors.black87),
                ),
              ],
            ),
          ],
        ),
        Icon(icon),
      ],
    );
  }