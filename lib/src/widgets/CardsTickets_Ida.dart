import 'package:flights/src/models/ticket_model.dart';
import 'package:flutter/material.dart';

class CardsTicketsIda extends StatelessWidget {

  final List<KiwiTickets> tickets;

  CardsTicketsIda({@required this.tickets});

  @override
  Widget build(BuildContext context) {


    final size = MediaQuery.of(context).size;
   
    return ListView.builder(
      itemCount: tickets.length,
      itemBuilder: (BuildContext context, int index) {
      
      return Container(
        width: size.width * 0.85,
        height: size.height * 0.30, 
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),

        child: Column(
          children: <Widget>[
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30)
              ),
              child: CircleAvatar(
                    child: Image(
                      image: NetworkImage('https://images.kiwi.com/airlines/64x64/${tickets[index].airline}.png'),
                      fit: BoxFit.cover,
                    ),
            ),
          ),
            Expanded(
              child: Container(
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  
                  children: <Widget>[
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Text('From: ', style: TextStyle(fontSize: 16, color: Colors.black54)),
                            Text(tickets[index].from,style: TextStyle(fontSize: 18, color: Colors.black54, fontWeight: FontWeight.bold))
                          ],
                        ),
                        Column(
                          children: <Widget>[
                             Text(tickets[index].airline, style: TextStyle(fontSize: 16, color: Colors.black54)),
                             Text(tickets[index].flightId,style: TextStyle(fontSize: 18, color: Colors.black54))
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Text('To: ', style: TextStyle(fontSize: 16, color: Colors.black54)),
                            Text(tickets[index].to,style: TextStyle(fontSize: 16, color: Colors.black54, fontWeight: FontWeight.bold))
                          ],
                        ),
                       
                      ],
                    ),
                    SizedBox(height: 10),
                     Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Icon(Icons.flight_takeoff),
                                SizedBox(width: 5),
                                 Text('Time: ', style: TextStyle(fontSize: 14, color: Colors.black54)),
                              ],
                            ),
                            SizedBox(height: 10),
                            Text('${tickets[index].depTime.hour.toString().padLeft(2,'0')}:${tickets[index].depTime.minute.toString().padLeft(2,'0')}',
                            style: TextStyle(fontSize: 16, color: Colors.black54, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Text('Date', style: TextStyle(fontSize: 14, color: Colors.black54)),
                            SizedBox(height: 5),
                            Text('${tickets[index].depTime.day.toString().padLeft(2,'0')}/${tickets[index].depTime.month.toString().padLeft(2,'0')}/${tickets[index].depTime.year.toString()}',
                             style: TextStyle(fontSize: 16, color: Colors.black54, fontWeight: FontWeight.bold))
                          ],
                        ),
                       Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Icon(Icons.flight_land),
                                SizedBox(width: 5),
                                 Text('Time: ', style: TextStyle(fontSize: 14, color: Colors.black54)),
                              ],
                            ),
                            SizedBox(height: 10),
                            Text('${tickets[index].arrTime.hour.toString().padLeft(2,'0')}:${tickets[index].arrTime.minute.toString().padLeft(2,'0')}',
                            style: TextStyle(fontSize: 16, color: Colors.black54, fontWeight: FontWeight.bold)),
                             
                          ],
                        ),
                       
                      ],
                    ),
                    Expanded(
                      child: Container(
                        // margin: EdgeInsets.symmetric(vertical: 5),

                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
            
                                  margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                                  width: 70,
                                  height: 34,
                                  decoration: BoxDecoration(
                                    color: Colors.yellow,
                                    borderRadius: BorderRadius.circular(20)
                                
                                  ),
                                  child: Center(
                                    child: Text('${tickets[index].price}€', 
                                    style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),)
                                  ),
                                )
                          ],
                        ),

                        
                      ),
                    )

                  ],
                ),
              ),
            ),
            
          ],
        ),
      );

     },
    );
           
  }
}