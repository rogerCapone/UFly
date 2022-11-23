import 'package:flights/src/models/airport_model.dart';
import 'package:flights/src/services/airports_service.dart';
import 'package:flights/src/services/database.dart';
import 'package:flights/src/services/profile_services.dart';
import 'package:flights/src/services/push_notifications/create_topic_service.dart';
import 'package:flights/src/services/push_notifications/topics_services.dart';
import 'package:flights/src/services/search_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddNotification extends StatefulWidget {
  
  @override
  _AddNotificationState createState() => _AddNotificationState();
}

class _AddNotificationState extends State<AddNotification> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Alert'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        children: <Widget>[
          InputParmSearch(),
        ],
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
  double _valorSliderPrice = 100;

  @override
  Widget build(BuildContext context) {
    
  final changeNoti = Provider.of<TopicServices>(context);
    final fecha = Provider.of<SearchProvider>(context);

    return Expanded(
      child: Container(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            FlatButton(
              color: Colors.white,
              padding: EdgeInsets.all(15),
              onPressed: () {
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

                final changeOrigen = Provider.of<TopicServices>(context, listen: false);
                changeOrigen.origen = false;
                
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
                          initialDate: changeNoti.dateDep, 
                          firstDate: fecha.dateTimeActual, 
                          lastDate: DateTime(2025),
                          
                          
                        ).then((date){
                          setState(() {
                            if(date != null) {
                              changeNoti.dateDep = date;
                              if(changeNoti.dateArr.day < changeNoti.dateDep.day || changeNoti.dateArr.month < changeNoti.dateDep.month ) {
                                changeNoti.dateArr = date;
                              }
                              
                            }
                            
                          });
                        });
                      },
                      child: buildDateSelector('DEPARTURE', changeNoti.dateDep),
                    ),
                  ),
                  
                  Expanded(
                    child: FlatButton(
                      color: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      onPressed: () {
                        showDatePicker(
                          context: context, 
                          initialDate: changeNoti.dateDep, 
                          firstDate: changeNoti.dateDep, 
                          lastDate: DateTime(2025),
                          
                          
                        ).then((date){
                          setState(() {
                            if(date != null) {
                              changeNoti.dateArr = date;
                            }
                            
                          });
                        });
                      },
                      child: buildDateSelector(
                          'RETURN', changeNoti.dateArr ),
                    ),
                  )
                  
                ],
              ),
              Container(height: 1, color: Colors.black26),
             Row(
               children: <Widget>[
                 
                 Expanded(
                   child: _crearSliderPrice(),
                 )
               ],
             ),
              Row(
                children: <Widget>[
                 
                  
                  Expanded(
                    child: FlatButton(
                      color: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      onPressed: () {
                       
                      },
                      child: buildTravellersView('PRICE', _valorSliderPrice),
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
                        onTap: () async {
                        changeNoti.priceNot = _valorSliderPrice;

                        final topicProvider = new Topicsprovider();
                        final dbuser =
                            Provider.of<ProfileServices>(context, listen: false)
                                .dbUser;
                        final topic =
                            Provider.of<TopicServices>(context, listen: false);

                        final day1 = topic.dateDep.day;
                        final month1 = topic.dateDep.month;
                        final year1 = topic.dateDep.year;

                        final day2 = topic.dateArr.day;
                        final month2 = topic.dateArr.month;
                        final year2 = topic.dateArr.year;
                        await topicProvider.createTopicFirebase(
                            dbuser.uid,
                            topic.codeOrg,
                            topic.codeDes,
                            topic.priceNot.truncate(),
                            day1,
                            month1,
                            year1,
                            day2,
                            month2,
                            year2);
                        await DataBase(uid: dbuser.uid).getUserInfo(context);
                        await Future.delayed(Duration(milliseconds: 500),
                            () => Navigator.pop(context));
                      },
                        child: Container(
                          width: 100,
                          height: 100,
                          alignment: Alignment.center,
                          color: Colors.blueAccent,
                          child: Text(
                            'SAVE',
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


  

  Widget _crearSliderPrice(){

    

    return Slider(
      activeColor: Colors.indigoAccent,
      label: 'Price',
      value: _valorSliderPrice,
      min: 30.0,
      max: 500,
      onChanged: (valor) {
        setState(() {
           _valorSliderPrice  = valor;
        });
       

      },
    


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
    
    final queryService = Provider.of<TopicServices>(context).query;

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
                final changeValue = Provider.of<TopicServices>(context, listen: false);
              
                if (changeValue.origen == true) {
                     changeValue.cityOrg = place;
                     changeValue.airportOrg = title;
                     changeValue.codeOrg = iataCode;
                } else {
                  changeValue.cityDes = place;
                  changeValue.airportDes = title;
                  changeValue.codeDes = iataCode;
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
                final queryService = Provider.of<TopicServices>(context, listen: false);
                queryService.query = value;
              },
            ),
          ),
          
        ),
      ),
    );
  }
}


   Widget buildAirportSelector(BuildContext context, IconData icon) {

     final inputSearch = Provider.of<TopicServices>(context);
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 70,
              child: Text(
                (icon == Icons.flight_takeoff) 
                ? inputSearch.codeOrg
                : inputSearch.codeDes,
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
                  ? inputSearch.cityOrg
                  : inputSearch.cityDes,
                  style:
                      GoogleFonts.overpass(fontSize: 24, color: Colors.black87),
                ),
                Text(
                  (icon == Icons.flight_takeoff)
                  ? inputSearch.airportOrg
                  : inputSearch.airportDes,
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