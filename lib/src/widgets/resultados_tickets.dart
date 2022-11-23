import 'package:flights/src/services/home_services.dart';
import 'package:flights/src/services/search_provider.dart';
import 'package:flights/src/services/ticket_provider.dart';
import 'package:flights/src/widgets/CardsTickets_Ida.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class ResultadosTickets extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            ParamaterosBuscados(),

            RoundTripResultados()
          ],
        ),
      ),
    );
  }
}

class RoundTripResultados extends StatefulWidget {
 

  @override
  _RoundTripResultadosState createState() => _RoundTripResultadosState();
}

class _RoundTripResultadosState extends State<RoundTripResultados> {
  @override
  Widget build(BuildContext context) {

    final type = Provider.of<HomeService>(context);
    
    return Expanded(
      child: Container(
        width: double.infinity,
        
        child: Column(
          children: <Widget>[
            BotonesSeleccionTrip(),
            
            (type.subTypeSelected == type.subFixType)
            ? ListResultadosIda()
            : ListResultadosVuelta()
          ],
        ),
      ),
      
    );
  }
}

class ListResultadosIda extends StatelessWidget {



final tiketsProvider  = new Ticketsprovider();



  @override
  Widget build(BuildContext context) {

    final type = Provider.of<SearchProvider>(context);

  final day = type.dateTimeDep.day.toString().padLeft(2,'0');
  final month = type.dateTimeDep.month.toString().padLeft(2,'0');
  final year = type.dateTimeDep.year;
  
    
    return Expanded(
      child: Container(

        child: FutureBuilder(
          future: tiketsProvider.getTicketsIda(type.codeIataOrg, type.codeIataDes, day, month, year),
          builder: (BuildContext context, AsyncSnapshot<List>  snapshot) {
            
            if(snapshot.hasData){
              final depTickets = snapshot.data;
              
              return CardsTicketsIda(tickets: depTickets);


            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
              
            
           
          }
        ),
      ),
    );
  }
}


class ListResultadosVuelta extends StatelessWidget {

final tiketsProvider  = new Ticketsprovider();

  @override
  Widget build(BuildContext context) {
    
     final type = Provider.of<SearchProvider>(context);

    final day = type.dateTimeDep.day.toString().padLeft(2,'0');
    final month = type.dateTimeDep.month.toString().padLeft(2,'0');
    final year = type.dateTimeDep.year;
    
    return Expanded(
      child: Container(

        child: FutureBuilder(
          future: tiketsProvider.getTicketsIda(type.codeIataDes, type.codeIataOrg, day, month, year),
          builder: (BuildContext context, AsyncSnapshot<List>  snapshot) {
            
            if(snapshot.hasData){
              final depTickets = snapshot.data;
              
              return CardsTicketsIda(tickets: depTickets);


            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
              
            
           
          }
        ),
      ),
    );
  }
}











class BotonesSeleccionTrip extends StatefulWidget {


  @override
  _BotonesSeleccionTripState createState() => _BotonesSeleccionTripState();
}

enum TripType { departure, vuelta}

Map<TripType, String> _tripTypes = {

  
  TripType.departure: 'Departure',
  TripType.vuelta: 'Return',
  
 
};

class _BotonesSeleccionTripState extends State<BotonesSeleccionTrip> {

  TripType _selectedTrip = TripType.departure;

  

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
     final type = Provider.of<HomeService>(context);
    
   
    return Container(
      width: double.infinity,
      height: size.height * 0.09,

      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  offset: Offset(0, 6),
                  blurRadius: 6),
              ]),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: (type.typeSearchSelected == type.fixType) ? List.generate(_tripTypes.length, (index) {
                    return buildTripTypeSelector(
                        _tripTypes.keys.elementAt(index));
                  })
                  : List.generate(1, (index) {
                    return buildTripTypeSelector(
                        _tripTypes.keys.elementAt(0));
                  })
                  
              ),
              
          )
        ],
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
          type.subTypeSelected = _selectedTrip.toString();
          type.subFixType = TripType.departure.toString();
          
          
        });
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      color: isSelected ? Colors.blue : Colors.transparent,
      child: Row(
        children: <Widget>[
          if(isSelected)
            (_selectedTrip == TripType.departure) ?
            Icon(
              Icons.flight_takeoff,
              color: Colors.white,
            )
            :
            Icon(
              Icons.flight_land,
              color: Colors.white,
            ),
          SizedBox(width: 2),
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


















class ParamaterosBuscados extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: size.height * 0.08,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        itemBuilder: (BuildContext context, int index) {
        return _cardParameters(context, index);
       },
      ),

  
      
    );
  }
}

Widget _cardParameters(BuildContext context, int i) {

  final type = Provider.of<SearchProvider>(context);
  final typeIdoVuelta = Provider.of<HomeService>(context);
  final size = MediaQuery.of(context).size;

  return Container(
    width: (i == 2) ? size.width * 0.30 : size.width * 0.25,
    height: 20,
    margin: EdgeInsets.symmetric(horizontal: 5),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(24),
      boxShadow: [
        BoxShadow(
          color: Colors.black,
          offset: Offset(0, 6),
          blurRadius: 6),
      ]),
    child: Column(
      children: <Widget>[
        SizedBox(height: 5),
        Icon((i == 0) ? Icons.flight_takeoff : (i == 1) ? Icons.flight_land : Icons.calendar_today),
        SizedBox(height: 5),
        (typeIdoVuelta.subTypeSelected == typeIdoVuelta.subFixType) ?
        Text((i == 0) ? type.codeIataOrg : (i == 1) ? type.codeIataDes : '${type.dateTimeDep.year.toString()}/${type.dateTimeDep.month.toString().padLeft(2,'0')}/${type.dateTimeDep.day.toString().padLeft(2,'0')}', 
        style: TextStyle(color: Colors.black54, fontSize: 16))
        :  Text((i == 0) ? type.codeIataDes : (i == 1) ? type.codeIataOrg : '${type.dateTimeDep.year.toString()}/${type.dateTimeDep.month.toString().padLeft(2,'0')}/${type.dateTimeDep.day.toString().padLeft(2,'0')}', 
           style: TextStyle(color: Colors.black54, fontSize: 16))
      ],
    ),
  );
}

