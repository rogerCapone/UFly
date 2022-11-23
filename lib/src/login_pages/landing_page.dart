import 'package:flights/src/login_pages/login_page.dart';
import 'package:flights/src/pages/home_page.dart';
import 'package:flights/src/pages/notifications/add_notification_page.dart';
import 'package:flights/src/pages/notifications/notifications_page.dart';
import 'package:flights/src/services/auth_service.dart';
import 'package:flights/src/services/database.dart';
import 'package:flights/src/services/firebase_storage_service/firebase_storage.dart';
import 'package:flights/src/services/firebase_storage_service/firestore_service.dart';
import 'package:flights/src/services/push_notifications/push_notifications_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class LandingPage extends StatefulWidget {
 
 
  
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {

  
  @override
  Widget build(BuildContext context) {

    final auth = Provider.of<AuthBase>(context, listen: false);
    

    return StreamBuilder<User>(
      stream: auth.onAuthStateChanged,
      builder: (context, snapshot) {
       
        if (snapshot.connectionState == ConnectionState.active) {
          User user = snapshot.data;
          if(user == null) {
           
            return LoginPage();
          }
        
          
           
          return FutureBuilder(
            future: DataBase(uid: user.uid).getUserInfo(context),
            builder: (BuildContext context, AsyncSnapshot snapshot) {

              
             
              if( snapshot.hasData) {
                final pushProvider = new PushNotificationProvider(context);
               pushProvider.initialise();

               pushProvider.mensajes.listen((data) {

                 

                 Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => NotificationsPage()));
               });
                
                return MultiProvider(
                  providers: [
                    Provider<User>.value(
                      value: user,
                      
                      ),
                      
                     Provider<FirestoreService>(
                       create: (_) => FirestoreService(uid: user.uid),
                      ),
                    Provider<FirebaseStorageService>(
                       create: (_) => FirebaseStorageService(uid: user.uid)
                      ),
                   
                      
                     
                      
                  ],
                  child: HomePage(),
                );
              
              } 
              return LoginPage();
           
            },
          );
        
          
           
           
          
              
           
        } else {
         return Center(child: CircularProgressIndicator());
        }
      }
    );

    
    
  }
}

// void getinfo(BuildContext context, User user) {

//  DataBase(user: user).getUserInfo(context);

 

// }