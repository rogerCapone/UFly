import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InformationPage extends StatelessWidget {
  const InformationPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Image(
            image: AssetImage('assets/viajar1.jpg'),
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.info_outline,
                      size: 35,
                    ),
                    SizedBox(width: 15),
                    Text(
                      'App Info',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.w600),
                    )
                  ],
                )),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
                height: MediaQuery.of(context).size.height,
                width: double.infinity,
                decoration: BoxDecoration(
                  // Box decoration takes a gradient
                  gradient: LinearGradient(
                    // Where the linear gradient begins and ends
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    // Add one stop for each color. Stops should increase from 0 to 1
                    colors: [
                      // Colors are easy thanks to Flutter's Colors class.
                      Colors.black.withOpacity(0.8),
                      Colors.black.withOpacity(0.5),
                      Colors.black.withOpacity(0.3),
                      Colors.black.withOpacity(0.1),
                      Colors.black.withOpacity(0.035),
                      Colors.black.withOpacity(0.025),
                    ],
                  ),
                ),
                child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Container())),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Text(
                  "Flight Search",
                  textScaleFactor: 1,
                  style: GoogleFonts.montserrat(
                      fontSize: 36,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      backgroundColor: Colors.black.withOpacity(0.02)),
                ),
              ),
              SizedBox(
                height: 55,
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Text(
                    "Con esta App podrás relajarte y planificar viajes a tu medida haciendo que sean estos los que  se ajusten a tu bolsillo. Prueba ahora nuestro sistema de notificaciones  personalizadas de forma totalmente gratuita",
                    style: GoogleFonts.rubik(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        backgroundColor: Colors.black.withOpacity(0.02)),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Text(
                    "Empieza hoy a disfrutar. Flight Search dispone de  acceso a más de 6.000 aeropuertos, i alrededor de 5.000 aerolíneas. Hagamos entre todos que viajar sea de nuevo fácil, barato y accesible para todo el mundo",
                    style: GoogleFonts.rubik(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        backgroundColor: Colors.black.withOpacity(0.02)),
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Center(
                child: Text(
                  " 🛫📍🗺️ ",
                  style: GoogleFonts.rubik(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                      backgroundColor: Colors.black.withOpacity(0.02)),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Text(
                    "No esperes más, aprovecha y disfruta :)",
                    style: GoogleFonts.rubik(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.w200,
                        backgroundColor: Colors.black.withOpacity(0.02)),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(height: 15),
              Center(
                  child: FlatButton(
                      onPressed: () => Navigator.pop(context),
                      color: Colors.lightBlue.withOpacity(0.5),
                      child: Text(
                        'Understood !',
                        style: GoogleFonts.rubik(fontSize: 20),
                      )))
            ],
          ),
        ],
      ),
    );
  }
}

// import 'package:ui_testing/utils/uidata.dart';
// import 'package:ui_testing/widgets/common_scaffold.dart';
// import 'package:ui_testing/widgets/common_switch.dart';

// class InformationPage extends StatelessWidget {
//   Widget bodyData() => SingleChildScrollView(
//         child: Theme(
//           data: ThemeData(fontFamily: UIData.ralewayFont),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: <Widget>[
//               //1
//               Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Text(
//                   "General Setting",
//                   style: TextStyle(color: Colors.grey.shade700),
//                 ),
//               ),
//               Card(
//                 color: Colors.white,
//                 elevation: 2.0,
//                 child: Column(
//                   children: <Widget>[
//                     ListTile(
//                       leading: Icon(
//                         Icons.person,
//                         color: Colors.grey,
//                       ),
//                       title: Text("Account"),
//                       trailing: Icon(Icons.arrow_right),
//                     ),
//                     ListTile(
//                       leading: Icon(
//                         Icons.mail,
//                         color: Colors.red,
//                       ),
//                       title: Text("Gmail"),
//                       trailing: Icon(Icons.arrow_right),
//                     ),
//                     ListTile(
//                       leading: Icon(
//                         Icons.sync,
//                         color: Colors.blue,
//                       ),
//                       title: Text("Sync Data"),
//                       trailing: Icon(Icons.arrow_right),
//                     )
//                   ],
//                 ),
//               ),

//               //2
//               Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Text(
//                   "Network",
//                   style: TextStyle(color: Colors.grey.shade700),
//                 ),
//               ),
//               Card(
//                 color: Colors.white,
//                 elevation: 2.0,
//                 child: Column(
//                   children: <Widget>[
//                     ListTile(
//                       leading: Icon(
//                         Icons.sim_card,
//                         color: Colors.grey,
//                       ),
//                       title: Text("Simcard & Network"),
//                       trailing: Icon(Icons.arrow_right),
//                     ),
//                     ListTile(
//                         leading: Icon(
//                           Icons.wifi,
//                           color: Colors.amber,
//                         ),
//                         title: Text("Wifi"),
//                         trailing: CommonSwitch(
//                           defValue: true,
//                         )),
//                     ListTile(
//                       leading: Icon(
//                         Icons.bluetooth,
//                         color: Colors.blue,
//                       ),
//                       title: Text("Bluetooth"),
//                       trailing: CommonSwitch(
//                         defValue: false,
//                       ),
//                     ),
//                     ListTile(
//                       leading: Icon(
//                         Icons.more_horiz,
//                         color: Colors.grey,
//                       ),
//                       title: Text("More"),
//                       trailing: Icon(Icons.arrow_right),
//                     ),
//                   ],
//                 ),
//               ),

//               //3
//               Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Text(
//                   "Sound",
//                   style: TextStyle(color: Colors.grey.shade700),
//                 ),
//               ),
//               Card(
//                 color: Colors.white,
//                 elevation: 2.0,
//                 child: Column(
//                   children: <Widget>[
//                     ListTile(
//                       leading: Icon(
//                         Icons.do_not_disturb_off,
//                         color: Colors.orange,
//                       ),
//                       title: Text("Silent Mode"),
//                       trailing: CommonSwitch(
//                         defValue: false,
//                       ),
//                     ),
//                     ListTile(
//                       leading: Icon(
//                         Icons.vibration,
//                         color: Colors.purple,
//                       ),
//                       title: Text("Vibrate Mode"),
//                       trailing: CommonSwitch(
//                         defValue: true,
//                       ),
//                     ),
//                     ListTile(
//                       leading: Icon(
//                         Icons.volume_up,
//                         color: Colors.green,
//                       ),
//                       title: Text("Sound Volume"),
//                       trailing: Icon(Icons.arrow_right),
//                     ),
//                     ListTile(
//                       leading: Icon(
//                         Icons.phonelink_ring,
//                         color: Colors.grey,
//                       ),
//                       title: Text("Ringtone"),
//                       trailing: Icon(Icons.arrow_right),
//                     )
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       );

//   @override
//   Widget build(BuildContext context) {
//     return CommonScaffold(
//       appTitle: "Device Settings",
//       showDrawer: false,
//       showFAB: false,
//       backGroundColor: Colors.grey.shade300,
//       bodyData: bodyData(),
//     );
//   }
// }
