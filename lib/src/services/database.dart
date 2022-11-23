

import 'dart:convert';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:flights/src/models/dbuser_model.dart';
import 'package:flights/src/models/flight_model.dart';
import 'package:flights/src/models/people_profile.dart';
import 'package:flights/src/models/search_user_model.dart';
import 'package:flights/src/services/profile_services.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';




class DataBase {

final String uid;


DataBase({@required this.uid});

final HttpsCallable callable1 = CloudFunctions.instance.getHttpsCallable(functionName: 'getUserInfo');

  

Future<bool> getUserInfo(BuildContext context) async {

  
 
    try {
       
      final response = await callable1.call(<String, dynamic> {
        'uid' : uid
      });
      // print(response.data);  
      //  final db =  dbUserFromJson(response.data);
      final db = jsonEncode(response.data);
      print(response.data);
      final dbUser = dbUserFromJson(db);
     
      
      final dbprov = Provider.of<ProfileServices>(context, listen: false);
      dbprov.dbUser = dbUser;

      
      return true;
    
    } catch(e) {
      print(e.toString());

      return false;
    }
}

final HttpsCallable callable2 = CloudFunctions.instance.getHttpsCallable(functionName: 'updateUserInfo');


 bool result;

 updateUserInfo(String userName, String nickName, String frase, String phoneNumer, String userWeb) async {

   print(userName);
    print(nickName);
    print(frase);
    print(phoneNumer);
    print(userWeb);
    try {

      final response = await callable2.call(<String, dynamic> {
        'uid' : uid,
        'userName' : userName,
        'nickName' : nickName,
        'frase' : frase,
        'phoneNumber' : phoneNumer,
        'userWeb' : userWeb
      });

   
   result = response.data;
   
   return result;
    
    
    
    // return res;

    } catch(e) {
      print(e.toString());
      
    }

    
}


final HttpsCallable callable3 = CloudFunctions.instance.getHttpsCallable(functionName: 'searchUser');




 Future<List<UsersData>> searchUser(String query) async {

   
    try {

      final response = await callable3.call(<String, String> {
        'uid' : uid,
        'userToFind' : query,
       
      });
      final users = jsonEncode(response.data);
      final foundedUsers = usersDataFromJson(users);
      
      return foundedUsers;

    } catch(e) {
      print(e.toString());
      
    }

    
}


final HttpsCallable callable4 = CloudFunctions.instance.getHttpsCallable(functionName: 'getUserProfileData');




Future<OtherProfile> getUserProfileData(String uidUser) async {

   
    try {

      final response = await callable4.call(<String, String> {
        'uid' : uid,
        'getUid' : uidUser
       
      });
      final users = jsonEncode(response.data);
      final chooseUser = otherProfileFromJson(users);
      
      return chooseUser;

    } catch(e) {
      print(e.toString());
      
    }

    
}



final HttpsCallable callable5 = CloudFunctions.instance.getHttpsCallable(functionName: 'askForFriendship');

  

Future<bool> askForFriendship(String uiduser) async {

  
 
    try {
       
      final response = await callable5.call(<String, String> {
        'uid' : uid,
        'futureFriendUid' : uiduser
      });
     
      print(response.data);
     
      
    
      
    
    } catch(e) {
      print(e.toString());

     
    }
}


final HttpsCallable callable6 = CloudFunctions.instance.getHttpsCallable(functionName: 'acceptFriend');

  

Future<bool> acceptFriend(String uiduser) async {

  
 
    try {
       
      final response = await callable6.call(<String, dynamic> {
        'uid' : uid,
        'newFriend' : uiduser
      });
     
      print(response.data);
     
      
    
      
    
    } catch(e) {
      print(e.toString());

     
    }
}

final HttpsCallable callable7 = CloudFunctions.instance.getHttpsCallable(functionName: 'deleteFriend');

  

Future<bool> deleteFriend(String uiduser) async {

  
 
    try {
       
      final response = await callable7.call(<String, dynamic> {
        'uid' : uid,
        'noMoreFriend' : uiduser
      });
     
      print(response.data);
     
      
    
      
    
    } catch(e) {
      print(e.toString());

     
    }
}


final HttpsCallable callable8 = CloudFunctions.instance.getHttpsCallable(functionName: 'getUsersPendingToAccept');

  

Future<List<UsersData>> getUsersPendingToAccept() async {

  
 
    try {
       
      final response = await callable8.call(<String, String> {
        'uid' : uid,
      });
     
      final users = jsonEncode(response.data);
      final foundedUsers = usersDataFromJson(users);
      
      return foundedUsers;
      
    
      
    
    } catch(e) {
      print(e.toString());

     
    }
    
}

final HttpsCallable callable9 = CloudFunctions.instance.getHttpsCallable(functionName: 'declineFriend');

  

Future<bool> declineFriend(String uidUser) async {

  
 
    try {
       
      final response = await callable9.call(<String, String> {
        'uid' : uid,
        'noFriend' : uidUser
      });
     
      
      
    
      
    
    } catch(e) {
      print(e.toString());

     
    }
    
}

final HttpsCallable callable10 = CloudFunctions.instance.getHttpsCallable(functionName: 'sendDeviceToken');

  

Future<bool> sendDeviceToken(String token) async {

  
 
    try {
       
      final response = await callable10.call(<String, String> {
        'tokenId' : token
      });
     
      
      return response.data;
    
      
    
    } catch(e) {
      print(e.toString());

     
    }
    
}

final HttpsCallable callable11 = CloudFunctions.instance
      .getHttpsCallable(functionName: 'cancelAskForFriendShip');

  Future<bool> cancelAskForFriendship(String uidUser) async {
    try {
      final response = await callable11
          .call(<String, String>{'uid': uid, 'cancelFriend': uidUser});
    } catch (e) {
      print(e.toString());
    }
  }


Future<FlightData> getFlightInfo(String flightId) async {
    try {
      print(flightId);
      final response = await http.get(
          'https://us-central1-never-lost-1e5c9.cloudfunctions.net/getFlightInfo?flightId=$flightId');
      print(response.body);
      final flightData = flightDataFromJson(response.body);
      return flightData;
    } catch (e) {
      print(e.toString());
    }
  }






}




