import 'package:flights/src/login_pages/landing_page.dart';
import 'package:flights/src/pages/airport_detalle.dart';
import 'package:flights/src/pages/cities_detalle.dart';
import 'package:flights/src/pages/people_profile.dart';
import 'package:flights/src/pages/settings/credit_card.dart';
import 'package:flights/src/pages/settings/information_page.dart';
import 'package:flights/src/services/auth_service.dart';
import 'package:flights/src/services/firebase_storage_service/image_picker_service.dart';
import 'package:flights/src/services/home_services.dart';
import 'package:flights/src/services/profile_services.dart';
import 'package:flights/src/services/push_notifications/topics_services.dart';
import 'package:flights/src/services/search_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeService()),
        ChangeNotifierProvider(create: (_) => SearchProvider()),
        ChangeNotifierProvider(create: (_) => ProfileServices()),
        ChangeNotifierProvider(create: (_) => TopicServices()),
        Provider<ImagePickerService>(
                        create: (_) => ImagePickerService(),
                      ),
        
        
        // Provider(create: (_) => FirebaseStorageService(uid: ),)

      ],
      child: Provider<AuthBase>(
        create: (context) => Auth(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Material App',
          initialRoute: 'landing',
          routes: {
            
            'detallecity' : (BuildContext context) => CitiesDetalle(),
            'detalleairport' : (BuildContext context) => AirportPage(),
            'landing'  : (BuildContext context) => LandingPage(),
            'peopleProfile' :(BuildContext context) => PeopleProfile(),
            'information' : (BuildContext context) => InformationPage(),
            'credit_card' : (BuildContext context) => CreditCard(),
          },
          
        ),
      ),
    );
  }
}