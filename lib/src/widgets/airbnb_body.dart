import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';



class AirbnbBody extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    
    return Container(
        width: double.infinity,
        height: size.height * 0.65,
        color: Colors.transparent,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
                top: 25,
                child: Text('This Area is under Development',
                    style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontSize: 23,
                        fontWeight: FontWeight.w200))),
            Center(
              child: FlareActor("assets/animations/walking.flr",
                  animation: "walking", fit: BoxFit.contain),
            ),
          ],
        ));
  }
}