

import 'package:flights/src/models/city_model.dart';
import 'package:http/http.dart' as http;


class Citiesprovider {

Future<CityInfo> buscarCity(String queryCity) async {

    //final url = 'api.aviationstack.com/v1/flights?access_key=eefb6d17037bc3a6edf57a42eb55e303';
      
      

      final resp = await http.get('https://us-central1-never-lost-1e5c9.cloudfunctions.net/getCityData?city=$queryCity');
      final decodedData = cityInfoFromJson(resp.body);
     

      // final flights = new Flights.fromJson(decodedData[]);

      
    if(decodedData!= null){
      return decodedData;
    } 
    
      
      

  }

}
