import 'package:flare_flutter/flare_actor.dart';
import 'package:flights/src/bloc/profile_bloc.dart';
import 'package:flights/src/pages/PendentTo_Accept.dart';
import 'package:flights/src/pages/ProfileEditMenu_page.dart';
import 'package:flights/src/services/firebase_storage_service/build_user_img.dart';
import 'package:flights/src/services/local_DB/goSoon_db.dart';
import 'package:flights/src/services/local_DB/trip_db.dart';
import 'package:flights/src/services/profile_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'flight/myFlights.dart';

class ProfilePage extends StatelessWidget {
  final Function signOut;

  ProfilePage({@required this.signOut});

  GoSoonDb db = GoSoonDb();
  TripDb tdb = TripDb();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        body: BlocProvider(
      create: (context) => ProfileBloc(),
      child: Center(
        child: Column(
          children: <Widget>[_crearAppbar(context, size), CrearPageProfile()],
        ),
      ),
    ));
  }

  Widget _crearAppbar(BuildContext context, Size size) {
    final dbuser = Provider.of<ProfileServices>(context).dbUser;

    return Stack(
      children: <Widget>[
        Container(
          height: size.height * 0.24,
          width: double.infinity,
          child: CustomPaint(
            painter: _HeaderWavePainter(Colors.blue, size),
          ),
        ),
        SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: size.width * 0.35, vertical: 20),
                  width: size.width * 0.4,
                  height: size.height * 0.14,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    
                  ),
                  child: Center(
                    child: BuildUserImg(),
                  ))
            ],
          ),
        ),
        Positioned(
          top: 50,
          right: 15,
          child: GestureDetector(
              onTap: () => signOut(context),
              child: Icon(
                FontAwesomeIcons.signOutAlt,
                color: Colors.white,
              )),
        ),
        Positioned(
            top: 50,
            left: 15,
            child: Row(
              children: <Widget>[
                GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MenuProfile(),
                              fullscreenDialog: true));
                    },
                    child: Icon(
                      Icons.settings,
                      color: Colors.white,
                    )),
                SizedBox(width: 15),
                GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  PendentFollowers(uid: dbuser.uid),
                              fullscreenDialog: true));
                    },
                    child: Icon(Icons.group_add,
                        color: (dbuser.pendingToAccept.length == 0)
                            ? Colors.white
                            : Colors.orange,
                        size: 25)),
              ],
            )),
      ],
    );
  }
}

class CrearPageProfile extends StatelessWidget {
  const CrearPageProfile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final profileBloc = BlocProvider.of<ProfileBloc>(context);
    final size = MediaQuery.of(context).size;
    return Expanded(
        child: Container(
            height: size.height * 0.75,
            width: size.width * 0.95,
            child: Column(
              children: <Widget>[
                _crearInfoUser(context, size),
                _crearSubPagesUser(context, size),
                _crearUserBody(context)
              ],
            )));
  }
}

class _MyAlbumsBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: Colors.white,
      ),
    );
  }
}

class _GoSoonBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: Colors.white,
      ),
    );
  }
}

class _HeaderWavePainter extends CustomPainter {
  final Color color;
  final Size sizescreen;

  _HeaderWavePainter(this.color, this.sizescreen);

  @override
  void paint(Canvas canvas, Size size) {
    final lapiz = Paint();

    // Propiedades
    lapiz.color = color; //Color(0xff615AAB);
    lapiz.style = PaintingStyle.fill;
    lapiz.strokeWidth = 10;

    final path = new Path();

    //dibujar con el path y el lapiz

    path.lineTo(0, sizescreen.height * 0.15);
    path.quadraticBezierTo(sizescreen.width * 0.20, sizescreen.height * 0.24,
        sizescreen.width * 0.45, sizescreen.height * 0.20);
    path.quadraticBezierTo(sizescreen.width * 0.70, sizescreen.height * 0.14,
        sizescreen.width, sizescreen.height * 0.20);
    path.lineTo(size.width, 0);

    // path.moveTo(size.width, size.height * 0.25);

    canvas.drawPath(path, lapiz);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

Widget _crearUserBody(BuildContext context) {
  final profileBloc = BlocProvider.of<ProfileBloc>(context);
  final size = MediaQuery.of(context).size;

  return BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
    if (state is ProfileLoading) {
      return Expanded(
        child: Center(
          child: FlareActor(
            "assets/animations/planet.flr",
            animation: "go",
            fit: BoxFit.contain,
          ),
        ),
      );
    } else if (state is GoSoonLoaded) {
      return Expanded(
        flex: 3,
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            for (GoSoon item in state.goSoonList)
              Slidable(
                actionPane: SlidableDrawerActionPane(),
                actionExtentRatio: 0.75,
                actions: <Widget>[
                  IconSlideAction(
                      caption: 'Remove',
                      color: Colors.red,
                      icon: Icons.delete_forever,
                      onTap: () async {
                        print(item.name);
                        profileBloc.add(DeleteGoSoon(goSoon: item));
                      }
                      // => _showSnackBar('Share'),
                      ),
                ],
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.all(10),
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          height: size.height * 0.105,
                          width: size.width * 0.205,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: NetworkImage(item.img),
                                fit: BoxFit.cover),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 35),
                    Text(
                      item.name,
                      style: GoogleFonts.rubik(
                          fontSize: 25, fontWeight: FontWeight.w300),
                    )
                  ],
                ),
              )
          ],
        ),
      );
    } else if (state is MyTripsLoaded) {
      
      return Expanded(
        flex: 3,
        child: state.getMyTrips.length == 0
            ? Center(
                child: FlareActor(
                  "assets/animations/planet.flr",
                  animation: "go",
                  fit: BoxFit.contain,
                ),
              )
        : ListView(
          shrinkWrap: true,
          children: <Widget>[
            for (MyTrip item in state.getMyTrips)
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              MyFlights(myFlight: item)));
                },
                child: Slidable(
                  actionPane: SlidableDrawerActionPane(),
                  actionExtentRatio: 0.75,
                  actions: <Widget>[
                    IconSlideAction(
                        caption: 'Remove',
                        color: Colors.red,
                        icon: Icons.delete_forever,
                        onTap: () async {
                          print(item.org);
                          print(item.dest);
                          profileBloc.add(DeleteMyTrip(myTrip: item));
                        }
                        // => _showSnackBar('Share'),
                        ),
                  ],
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.all(10),
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            height: size.height * 0.09,
                            width: size.width * 0.15,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: NetworkImage(item.airlineImg),
                                  fit: BoxFit.cover),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            item.org + ' - ' + item.dest,
                            style: GoogleFonts.rubik(
                                fontSize: 20, fontWeight: FontWeight.w400),
                          ),
                          Text(
                            DateTime.parse(item.dateDep).day.toString() +
                                '-' +
                                DateTime.parse(item.dateDep).month.toString() +
                                '-' +
                                DateTime.parse(item.dateDep).year.toString(),
                            textAlign: TextAlign.left,
                            style: GoogleFonts.rubik(
                                fontSize: 15, fontWeight: FontWeight.w200),
                          ),
                        ],
                      ),
                      SizedBox(width: 15),
                      Center(
                          child: Row(
                        children: <Widget>[
                          Text(item.idVuelo.substring(0, 2),
                              style: GoogleFonts.montserrat(
                                  fontSize: 25, fontWeight: FontWeight.w300)),
                          Text(' ' + item.idVuelo.substring(2),
                              style: GoogleFonts.montserrat(
                                  fontSize: 23, fontWeight: FontWeight.w200)),
                          SizedBox(width: 5),
                        ],
                      ))
                    ],
                  ),
                ),
              )
          ],
        ),
      );
    } else {
      return CircularProgressIndicator();
    }
  });
}

_getMyCities(dynamic goSoon) {
  return ListTile(
    contentPadding: EdgeInsets.symmetric(vertical: 20),
    leading: Container(
      height: 60,
      width: 60,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image:
            DecorationImage(image: NetworkImage(goSoon.img), fit: BoxFit.cover),
      ),
    ),
    title: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        SizedBox(width: 15),
        Text(goSoon.name.toString()),
      ],
    ),
  );
}

Widget _crearSubPagesUser(BuildContext context, Size size) {
 
  final profileBloc = BlocProvider.of<ProfileBloc>(context);
  GoSoonDb db = GoSoonDb();
  TripDb tdb = TripDb();

  return Container(
    height: size.height * 0.08,
    child: Column(
      children: <Widget>[
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              FlatButton(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(FontAwesomeIcons.globeAfrica,
                        color:
                            // (type.bodySelected == 0)
                            //     ? Colors.blue
                            //     :
                            Colors.grey),
                    SizedBox(height: 5),
                    Text('My Trips'),
                  ],
                ),
                onPressed: () async {
                  print('GETmYTRIPS');
                  await tdb.initDB();

                  profileBloc.add(GetMyTrips());
                  // final type =
                  //     Provider.of<ProfileServices>(context, listen: false);
                  // type.bodySelected = 0;
                },
              ),
              FlatButton(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(FontAwesomeIcons.planeDeparture,
                        color:
                            // (type.bodySelected == 2)
                            //     ? Colors.blue
                            //     :
                            Colors.grey),
                    SizedBox(height: 5),
                    Text('Go Soon')
                  ],
                ),
                onPressed: () async {
                  print('gosoon!!');
                  await db.initDB();

                  profileBloc.add(GetGoSoon());
                },
              ),
            ],
          ),
        )
      ],
    ),
  );
}

Widget _crearInfoUser(BuildContext context, Size size) {
  final dbuser = Provider.of<ProfileServices>(context).dbUser;
  

  return Container(
    height: size.height * 0.16,
    child: Column(
      children: <Widget>[
        SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text((dbuser.nickName != null) ? dbuser.nickName : 'Guest',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.grey))
          ],
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text((dbuser.frase != null)
                ? dbuser.frase
                : 'Life is just a travel so enjoy it!')
          ],
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            // Column(
            //   children: <Widget>[
            //     Text('0',
            //         style: TextStyle(
            //             fontSize: 18,
            //             color: Colors.grey[800],
            //             fontWeight: FontWeight.bold)),
            //     Text('Flights',
            //         style: TextStyle(
            //             fontSize: 12,
            //             color: Colors.black,
            //             fontWeight: FontWeight.bold)),
            //   ],
            // ),
            Column(
              children: <Widget>[
                Text(dbuser.followers.length.toString(),
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[800],
                        fontWeight: FontWeight.bold)),
                Text('Followers',
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                        fontWeight: FontWeight.bold)),
              ],
            ),
            Column(
              children: <Widget>[
                Text(dbuser.following.length.toString(),
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[800],
                        fontWeight: FontWeight.bold)),
                Text('Following',
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                        fontWeight: FontWeight.bold)),
              ],
            )
          ],
        )
      ],
    ),
  );
}
