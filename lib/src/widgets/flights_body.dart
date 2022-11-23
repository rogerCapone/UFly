import 'package:animate_do/animate_do.dart';
import 'package:flights/src/models/ticket_model.dart';
import 'package:flights/src/services/search_provider.dart';
import 'package:flights/src/services/ticket_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class FlightsBody extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    
    return Container(
      width: double.infinity,
      height: size.height * 0.65,
      child: Stack(
        children: <Widget>[
          
          Plane(),
          Line(),
          CardFlight()

          
        ],
      ),
    );
  }
}

class CardFlight extends StatelessWidget {
  
  final tiketsProvider  = new Ticketsprovider();

  @override
  Widget build(BuildContext context) {

     final type = Provider.of<SearchProvider>(context);

    final day = type.dateTimeDep.day.toString().padLeft(2,'0');
    final month = type.dateTimeDep.month.toString().padLeft(2,'0');
    final year = type.dateTimeDep.year;


    final size = MediaQuery.of(context).size;

    return Positioned(
      top: 66,
      left: 27,
      child: Container(
       width: size.width * 0.9,
        height: size.height,
        // color: Colors.red,
        child: ElasticInDown(
          duration: Duration(seconds: 2),
          delay: Duration(seconds: 1),
         
          child: FutureBuilder(
          future: tiketsProvider.getTicketsIda(type.codeIataOrg, type.codeIataDes, day, month, year),
          builder: (BuildContext context, AsyncSnapshot<List>  snapshot) {
     
            if(snapshot.hasData){
              final depTickets = snapshot.data;
             
              return TopFlights(tickets: depTickets);

            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
           
          }
        ),

        ),  
      ),
    );
  }
}

class TopFlights extends StatelessWidget {
  
  final List<KiwiTickets> tickets;

  TopFlights({@required this.tickets});

  @override
  Widget build(BuildContext context) {
    print(tickets[0].deepLink);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ListView.builder(
        itemCount: tickets.length,
        itemBuilder: (BuildContext context, int index) {
        return Container(
        height: 100,
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                    Column(
                    children: <Widget>[
                    SizedBox(height: 30),
                    Icon(Icons.flight, color: Colors.white)
                    ],
                  ),
                  Column(
                    children: <Widget>[
                    Text(tickets[index].from, style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black54)),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                    Icon(Icons.flight_takeoff, color: Colors.white),
                    SizedBox(height: 5.0),
                    
                    Text('${tickets[index].date.toString()}', 
                    style: TextStyle(color: Colors.black45, fontSize: 14))
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                    Text(tickets[index].to, style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black54)),
                    ],
                  ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(width: 40),
                Text('${tickets[index].depTime.hour.toString().padLeft(2,'0')}:${tickets[index].depTime.minute.toString().padLeft(2,'0')}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
                SizedBox(width: 25),
                Text('${tickets[index].price}€',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.yellow)),
                SizedBox(width: 25),
                Text('${tickets[index].arrTime.hour.toString().padLeft(2,'0')}:${tickets[index].arrTime.minute.toString().padLeft(2,'0')}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white))

              ],
            )
          ],
        ) ,
      );
       },
      ),
      
      
      
      
    );
    
  }
}













class Plane extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    final size = MediaQuery.of(context).size;

    return Positioned(
      left: 25,
      top: 10,
      child: Row(
        
        children: <Widget>[
          RotatedBox(
            quarterTurns: 2,
            child: Icon(
              Icons.airplanemode_active,
              size: 64,
              color: Colors.white,
            ),
          ),
          SizedBox(width: size.width * 0.17),
          ElasticIn(child: Text('Top Flights', style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),))
        ],
      ),
    );
  }
}

class Line extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 40.0 +18,
      top: 60,
      bottom: 0,
      width: 1,
      child: Container(
        color: Colors.white.withOpacity(0.5),
      ),
    );
  }
}

