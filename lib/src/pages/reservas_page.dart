
import 'package:flutter/material.dart';

class ReservasPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
              FondoApp(),
              CapceleraReservas(),
              BotonSearch()
              // AirplaneAnimated()
        ],
      )
    );
  }
}

class BotonSearch extends StatefulWidget {
 

  @override
  _BotonSearchState createState() => _BotonSearchState();
}

class _BotonSearchState extends State<BotonSearch> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 60,
      right: 20,
      child: GestureDetector(
        onTap: () {
          setState(() {
            Stack(
              children: <Widget>[
            Center(
                child: Container(
                  width: 300,
                  height: 300,
                  color: Colors.red,
                ),
            ),
          ],
            );
            
          });
          
        },
        child: Icon(
          Icons.filter_list, size: 35, color: Colors.white),
      )
    );
  }
}

class FondoApp extends StatelessWidget {
 

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
         gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blueAccent,
              Colors.black12
            ]
          )
        ),
      );
  }
}





class CapceleraReservas extends StatelessWidget {
 

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        height: 80,
        child: ListView.builder(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: 100,
          itemBuilder: (BuildContext context, int index) {
            
            // final cName = categories[index].name;
          
          return Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              children: <Widget>[
                // _CategoryBoton(categories[index]),
                SizedBox(height: 5),
                // Text('${cName[0].toUpperCase()}${cName.substring(1)}'),

                Text('Flight')
              ],
            ),
          );
         },
        ),
      ),
    );
  }
}
