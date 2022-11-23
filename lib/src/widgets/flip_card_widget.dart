import 'package:flights/src/models/category_home.dart';
import 'package:flights/src/pages/home_page.dart';
import 'package:flights/src/pages/search_page.dart';
import 'package:flights/src/services/home_services.dart';
import 'package:flights/src/services/profile_services.dart';
import 'package:flights/src/widgets/airbnb_body.dart';
import 'package:flights/src/widgets/airports_body.dart';
import 'package:flights/src/widgets/avatar_widget.dart';
import 'package:flights/src/widgets/cities_body.dart';
import 'package:flights/src/widgets/flights_body.dart';
import 'package:flights/src/widgets/search_tickets_widget.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();

class PaginaReservas extends StatelessWidget {
  
  
  @override
  Widget build(BuildContext context) {
    
    final catSelect = Provider.of<HomeService>(context).selectedCategory;
    
    return Center(
      child: FlipCard(
        flipOnTouch: false,
        key: cardKey,
        onFlipDone: (status) {
          status = false;
          
        },
          
          direction: FlipDirection.HORIZONTAL, // default
          
          front: Stack(
            children: <Widget>[

              FondoHomePage(),

              

              Column(
                children: <Widget>[
                  CapceleraReservas(),
                  SizedBox(height: 10),

                    (catSelect == 'Flights')  ?  FlightsBody() 
                  : (catSelect == 'Cities')   ?  CitiesBody()
                  : (catSelect == 'Airports') ?  AirportsBody()
                  : (catSelect == 'Hotels')   ?  AirbnbBody()
                  : (catSelect == 'Taxis')    ?  AirbnbBody()                         
                  : Container()
                  
                ],
              ),
             
              
            ],
            
            
          ),
           
           
            back: Stack(
            children: <Widget>[
              FondoHomePage(),

              
              LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  return SearchTickets();
                },
              ),
              
              
            ],   
          ),
        ),
    );
  }
}











class FondoHomePage extends StatelessWidget {

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
        height: 140,
        // color: Colors.red,
        child: Column(
          children: <Widget>[
            SearchBar(),
            Spacer(),
            TiposCapcelera(),
            
          ],
        ),
        
      ),
    );
  }
}


class TiposCapcelera extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    final categories = Provider.of<HomeService>(context).categories;
   
   return Container(
      height: 80,
      child: ListView.builder(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemBuilder: (BuildContext context, int index) {
  
            // final cName = categories[index].name;
          return Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              children: <Widget>[
                
                _CategoryButton(categories[index]),
                
                SizedBox(height: 5),
                

                Text(categories[index].name, style: TextStyle(fontSize: 15, color: Colors.white))
              ],
            ),
          );
         },
        ),
    );
  }
}

class _CategoryButton extends StatelessWidget {
  
  final Category categoria;

  const _CategoryButton(this.categoria);

  @override
  Widget build(BuildContext context) {

     final catSelect = Provider.of<HomeService>(context).selectedCategory;

    return GestureDetector(
      onTap: () {
        final homeService = Provider.of<HomeService>(context, listen: false);
        homeService.selectedCategory = categoria.name;
        
      },
      child: Container(
        width: 40,
        height: 40,
        margin: EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: Icon(
          categoria.icon,
          color: (catSelect == categoria.name) ? Colors.blue : Colors.black54,
        ),
      ),
    );
  }
}

class SearchBar extends StatefulWidget {



  @override
  _SearchBarState createState() => _SearchBarState();
 
}

class _SearchBarState extends State<SearchBar> {
  
  
  @override
  Widget build(BuildContext context) {

    
     final dbuser = Provider.of<ProfileServices>(context).dbUser;
    final catSelect = Provider.of<HomeService>(context).selectedCategory;
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,

      children: <Widget>[
       
        GestureDetector(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            width: 250,
            height: 48,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Avatar(
                  photoUrl: dbuser.imgUrl ,
                  radius: 25,
                  borderWidth: 2,
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 6),
                      Expanded(
                        child: Text((dbuser.nickName != null) ? dbuser.nickName : dbuser.userName,
                        overflow: TextOverflow.ellipsis, 
                        style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold ))),
                      SizedBox(height: 2),
                      Expanded(
                        child: Text((dbuser.userName != null) ? dbuser.userName : dbuser.userEmail ,
                        overflow: TextOverflow.ellipsis, 
                        style: TextStyle(color: Colors.white))),
                    ],
                  ),
                )
              ],
            ),
          ),
          onTap: () {
            final navegacionModel = Provider.of<NavegacionModel>(context, listen:false );
            navegacionModel.paginaActual = 3;
          },
        ),
        SizedBox(height: 10),
        (catSelect == 'Flights') ?
        GestureDetector(
          onTap: () {
            final catSelect = Provider.of<HomeService>(context, listen: false).selectedCategory;
            if (catSelect == 'Flights') 
            cardKey.currentState.toggleCard();
          },  
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            width: 35,
            height: 35,
             child: Icon(
                FontAwesomeIcons.paperPlane, size: 30, color: Colors.white),
          ),
        ) : SizedBox()
      ],
    );
  }
}


