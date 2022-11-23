

import 'dart:async';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flights/src/login_pages/platform_alert_dialog.dart';
import 'package:flights/src/services/database.dart';
import 'package:flutter/cupertino.dart';









class PushNotificationProvider{

 
  final BuildContext context;
  PushNotificationProvider(this.context);


  FirebaseMessaging _fcm = FirebaseMessaging();


  final _mensajesStreamController = StreamController<String>.broadcast();

  
  Stream<String> get mensajes => _mensajesStreamController.stream;
  

  Future initialise() async {

    

      _fcm.requestNotificationPermissions();

      _fcm.getToken().then( (token) {

    print('==== FCM Token ====');
    print(token);

    DataBase(uid: null).sendDeviceToken(token);

  });

  
 

    if(Platform.isIOS) {
      //request permissions if we´re on iOS

      _fcm.requestNotificationPermissions(IosNotificationSettings());
    }

    _fcm.configure(

      

      //called when the app is in the foreground and we receive a push notification
      onMessage: ( info ) async {
        print("onMessage: $info");

       dynamic argumento = 'no-data';
        if(Platform.isAndroid){

          argumento = info['notification']['body'] ?? 'no-data';

        } else {

          argumento = info['aps']['alert']['body'] ?? 'no-data-iOS';
        }

      final didRequestSeeNotification = await PlatformAlertDialog(
        title: 'New Notification',
        cancelActionText: 'Cancel',
        content: argumento,
        defaultActionText: 'See',
       ).show(context);
      if(didRequestSeeNotification  == true) {
      _mensajesStreamController.sink.add(argumento);
      }

        
        

      },

      // Called when the app has been closed completely and it´s opened
      // from the push notification directly
      
      onLaunch: ( info)  async{
        print("onLaunch: $info");
        // _navigateToItemDetail(message);
        _mensajesStreamController.sink.add(info['data']);
      },

      // Called when the app  is in the background and it´s opened
      // from the push notification
      onResume: (info) async{
        print('onResume: $info');
        
         String argumento = 'no-data';
        if(Platform.isAndroid){

          argumento = info['notification']['body']?? 'no-data';

        } else {

          argumento = info['aps']['alert']['body'] ?? 'no-data-iOS';
        }

         _mensajesStreamController.sink.add(argumento);
       

      }
    );

   
  }

  dispose() {
    _mensajesStreamController?.close();
  }


}
















// class PushNotificationProvider {

// FirebaseMessaging _firebaseMessaging = FirebaseMessaging();



// initNotifications() {



//   _firebaseMessaging.requestNotificationPermissions();

//   _firebaseMessaging.getToken().then( (token) {

//     print('==== FCM Token ====');
//     print(token);


//     // ePWPHJ3BZf8:APA91bEA8yDVu2jZA8HHGZ7Fz7S1mfTKtmokLL64O370Tddx5eeTV8dCBrTbPvwtpU-2zxaLgt5VuLYB2bQiT5djWV2ufztLv-kNO5mj8-zGVES7il9VH7jSyPl3konGrhu2ffKqLBXO
//   });


//   _firebaseMessaging.configure(

//     onMessage: (info) async {

//         print('======= On Message =======');
//         print(info);

//         var argumento = 'no-data';

//         if( Platform.isAndroid) {
//           argumento = info['data']['vuelos'] ?? 'no-data';
//         }

       
//     },
//     onLaunch: (info) async {

//         print('======= On Launch =======');
//         print(info);

//       final noti = info['data']['vuelos'];
//       print(noti);
        
//     },

//     onResume: (info) async {

//         print('======= On Resume =======');
//         print(info);

//       final noti = info['data']['vuelos'];
//       print(noti);
//     },




//   );
// }






// }