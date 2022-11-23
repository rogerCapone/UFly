
import 'package:http/http.dart' as http;

class Topicsprovider {

Future createTopicFirebase(String uid, String origen, String destino, int price, int day1, int month1, int year1, int day2, int month2, int year2) async {

   

   final resp = await http.get('https://us-central1-never-lost-1e5c9.cloudfunctions.net/setNotification?uid=$uid&orig=$origen&dest=$destino&price=$price&dayInici=$day1&monthInici=$month1&yearInici=$year1&dayFinal=$day2&monthFinal=$month2&yearFinal=$year2');


    return resp;
  

}

Future deleteTopicFirebase(String uid, String origen, String destino, int price, int day1, int month1, int year1, int day2, int month2, int year2) async {

   

   final resp = await http.get('https://us-central1-never-lost-1e5c9.cloudfunctions.net/deleteNotification?uid=$uid&org=$origen&dest=$destino&price=$price&dayInici=$day1&monthInici=$month1&yearInici=$year1&dayFinal=$day2&monthFinal=$month2&yearFinal=$year2');

      print(resp.statusCode);
    return resp.statusCode;


  

}


  

  



}