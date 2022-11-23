

import 'package:flights/src/models/ticket_model.dart';
import 'package:http/http.dart' as http;


class Ticketsprovider {

Future<List<KiwiTickets>> getTicketsIda(String origen, String destino, String day, String month, int year) async {

   

   final resp = await http.get('https://us-central1-never-lost-1e5c9.cloudfunctions.net/getKiwiFlightTickets?orig=$origen&dest=$destino&day=$day&month=$month&year=$year');
  //  final encodefirst = json.encode(resp.body);
  //  final decodedData = json.decode(resp.body);

    
  
  final tickets =  kiwiTicketsFromJson(resp.body);
  

    return tickets;
  
  
  

}

  

  



}