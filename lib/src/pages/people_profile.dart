import 'package:flare_flutter/flare_actor.dart';
import 'package:flights/src/bloc/people_bloc.dart';
import 'package:flights/src/models/people_profile.dart';
import 'package:flights/src/models/search_user_model.dart';
import 'package:flights/src/services/database.dart';
import 'package:flights/src/services/profile_services.dart';
import 'package:flights/src/widgets/avatar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class PeopleProfile extends StatefulWidget {
  @override
  _PeopleProfileState createState() => _PeopleProfileState();
}

class _PeopleProfileState extends State<PeopleProfile> {
  @override
  Widget build(BuildContext context) {
    final UsersData user = ModalRoute.of(context).settings.arguments;

    final res = Provider.of<ProfileServices>(context, listen: false);

    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.8),
      body: Center(
        child: FutureBuilder(
          future: DataBase(uid: res.dbUser.uid).getUserProfileData(user.uid),
          builder:
              (BuildContext context, AsyncSnapshot<OtherProfile> snapshot) {
            if (snapshot.hasData) {
              final userfound = snapshot.data;
              return Column(
                children: <Widget>[
                  BlocProvider(
                      create: (context) => PeopleBloc(
                          tag: userfound.friendOrNot), //cal fer chequeos
                      child: CrearAppBar(
                        context: context,
                        size: size,
                        user: userfound,
                        userProf: user,
                      )),
                  _crearPageProfile(context, size, userfound)
                ],
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }

//   Widget _crearAppbar(
//       BuildContext context, Size size, OtherProfile user, UsersData userProf) {
// // final dbuser = Provider.of<ProfileServices>(context).dbUser;

//     final res = Provider.of<ProfileServices>(context, listen: false);
//     final peopleBloc = BlocProvider.of<PeopleBloc>(context);

//     // String titlefinal = (user.friendOrNot == 'true')
//     //     ? 'Unfollow'
//     //     : (user.friendOrNot == 'false') ? 'Follow' : 'Pendent';

//     // askFriendship() async {
//     //   await DataBase(uid: res.dbUser.uid).askForFriendship(userProf.uid);
//     // }

//     // unFollow() async {
//     //   await DataBase(uid: res.dbUser.uid).deleteFriend(userProf.uid);
//     // }

//     // cancelAskForFriendship() async {
//     //   await DataBase(uid: res.dbUser.uid).cancelAskForFriendship(userProf.uid);
//     // }

//     return BlocBuilder<PeopleBloc, PeopleProfileState>(
//       builder: (context, state) {
//         if (state is PeopleUnknown) {
//           return Stack(
//             children: <Widget>[
//               Container(
//                 height: size.height * 0.24,
//                 width: double.infinity,
//                 child: CustomPaint(
//                   painter: _HeaderWavePainter(Colors.blue, size),
//                 ),
//               ),
//               SafeArea(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: <Widget>[
//                     Container(
//                         margin: EdgeInsets.symmetric(
//                             horizontal: size.width * 0.35, vertical: 20),
//                         width: size.width * 0.4,
//                         height: size.height * 0.14,
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                         ),
//                         child: Avatar(
//                           photoUrl: user.imgUrl,
//                           radius: 50,
//                         )),
//                   ],
//                 ),
//               ),
//               _ButtonFriend(
//                   title: 'Follow',
//                   onPressed: () => peopleBloc.add(AskForFriendship(
//                       myUid: res.dbUser.uid, newFriendUid: userProf.uid))),
//               Positioned(
//                 top: 50,
//                 left: 15,
//                 child: GestureDetector(
//                     onTap: () {
//                       Navigator.pop(context);
//                     },
//                     child: Icon(
//                       Icons.arrow_back,
//                       color: Colors.white,
//                     )),
//               ),
//             ],
//           );
//         } else if (state is PeopleWaitingForFriendResponse) {
//           return Stack(
//             children: <Widget>[
//               Container(
//                 height: size.height * 0.24,
//                 width: double.infinity,
//                 child: CustomPaint(
//                   painter: _HeaderWavePainter(Colors.blue, size),
//                 ),
//               ),
//               SafeArea(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: <Widget>[
//                     Container(
//                         margin: EdgeInsets.symmetric(
//                             horizontal: size.width * 0.35, vertical: 20),
//                         width: size.width * 0.4,
//                         height: size.height * 0.14,
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                         ),
//                         child: Avatar(
//                           photoUrl: user.imgUrl,
//                           radius: 50,
//                         )),
//                   ],
//                 ),
//               ),
//               _ButtonFriend(
//                   title: 'Pendent',
//                   onPressed: () => peopleBloc.add(CancelAskForFriendship(
//                       myUid: res.dbUser.uid, newFriendUid: userProf.uid))),
//               Positioned(
//                 top: 50,
//                 left: 15,
//                 child: GestureDetector(
//                     onTap: () {
//                       Navigator.pop(context);
//                     },
//                     child: Icon(
//                       Icons.arrow_back,
//                       color: Colors.white,
//                     )),
//               ),
//             ],
//           );
//         } else if (state is PeopleIsFriend) {
//           return Stack(
//             children: <Widget>[
//               Container(
//                 height: size.height * 0.24,
//                 width: double.infinity,
//                 child: CustomPaint(
//                   painter: _HeaderWavePainter(Colors.blue, size),
//                 ),
//               ),
//               SafeArea(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: <Widget>[
//                     Container(
//                         margin: EdgeInsets.symmetric(
//                             horizontal: size.width * 0.35, vertical: 20),
//                         width: size.width * 0.4,
//                         height: size.height * 0.14,
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                         ),
//                         child: Avatar(
//                           photoUrl: user.imgUrl,
//                           radius: 50,
//                         )),
//                   ],
//                 ),
//               ),
//               _ButtonFriend(
//                   title: 'Unfollow',
//                   onPressed: () => peopleBloc.add(DeleteFriendship(
//                       myUid: res.dbUser.uid, newFriendUid: userProf.uid))),
//               Positioned(
//                 top: 50,
//                 left: 15,
//                 child: GestureDetector(
//                     onTap: () {
//                       Navigator.pop(context);
//                     },
//                     child: Icon(
//                       Icons.arrow_back,
//                       color: Colors.white,
//                     )),
//               ),
//             ],
//           );
//         }
//       },
//     );
//   }

  Widget _crearPageProfile(BuildContext context, Size size, OtherProfile user) {
    return Expanded(
      child: Container(
          child: Column(
        children: <Widget>[
          _crearInfoUser(context, size, user),
          _crearSubPagesUser(context, size),
          _crearPagesBody(context, size, user),
        ],
      )),
    );
  }

  Widget _crearInfoUser(BuildContext context, Size size, OtherProfile user) {
    return Container(
      height: size.height * 0.15,
      child: Column(
        children: <Widget>[
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text((user.nickName != null) ? user.nickName : '',
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
            children: <Widget>[Text((user.frase != null) ? user.frase : '')],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text('220',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey[800],
                          fontWeight: FontWeight.bold)),
                  Text('Posts',
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                          fontWeight: FontWeight.bold)),
                ],
              ),
              Column(
                children: <Widget>[
                  // dbuser.followers.length.toString()
                  Text(user.followers.length.toString(),
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
                  Text(user.following.length.toString(),
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

  Widget _crearSubPagesUser(BuildContext context, Size size) {
    final type = Provider.of<ProfileServices>(context);

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
                          color: (type.bodySelected == 0)
                              ? Colors.blue
                              : Colors.grey),
                      SizedBox(height: 5),
                      Text('My Trips'),
                    ],
                  ),
                  onPressed: () {
                    final type =
                        Provider.of<ProfileServices>(context, listen: false);
                    type.bodySelected = 0;
                  },
                ),
                // FlatButton(
                //   child: Column(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: <Widget>[
                //       Icon(FontAwesomeIcons.images,
                //           color: (type.bodySelected == 1)
                //               ? Colors.blue
                //               : Colors.grey),
                //       SizedBox(height: 5),
                //       Text('My Albums')
                //     ],
                //   ),
                //   onPressed: () {
                //     final type =
                //         Provider.of<ProfileServices>(context, listen: false);
                //     type.bodySelected = 1;
                //   },
                // ),
                FlatButton(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(FontAwesomeIcons.planeDeparture,
                          color: (type.bodySelected == 1)
                              ? Colors.blue
                              : Colors.grey),
                      SizedBox(height: 5),
                      Text('Go Soon')
                    ],
                  ),
                  onPressed: () {
                    final type =
                        Provider.of<ProfileServices>(context, listen: false);
                    type.bodySelected = 1;
                  },
                ),
                // FlatButton(
                //   child: Column(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: <Widget>[
                //       Icon(FontAwesomeIcons.planeDeparture, color:(type.bodySelected == 2) ? Colors.blue : Colors.grey),
                //       SizedBox(height: 5),
                //       Text('Go Soon')
                //     ],
                //   ),
                //   onPressed: () async => DataBase(user: user).updateNickName('hami1234')
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _crearPagesBody(BuildContext context, Size size, OtherProfile user) {
    final type = Provider.of<ProfileServices>(context);

    return Expanded(
      child: Center(
          child: user.friendOrNot != 'true' ? _showLocker(size) : SizedBox()),
    );
  }

  Widget _showLocker(Size size) {
    return Center(
      child: Container(
          child: FlareActor(
            "assets/animations/planet.flr",
            fit: BoxFit.contain,
            animation: "go",
          ),
          height: 500,
          width: 500),
    );
  }
}

class CrearAppBar extends StatelessWidget {
  final BuildContext context;
  Size size;
  OtherProfile user;
  UsersData userProf;

  CrearAppBar({this.context, this.size, this.user, this.userProf});

  @override
  Widget build(BuildContext context) {
    final res = Provider.of<ProfileServices>(context, listen: false);
    final peopleBloc = BlocProvider.of<PeopleBloc>(context);

    // String titlefinal = (user.friendOrNot == 'true')
    //     ? 'Unfollow'
    //     : (user.friendOrNot == 'false') ? 'Follow' : 'Pendent';

    // askFriendship() async {
    //   await DataBase(uid: res.dbUser.uid).askForFriendship(userProf.uid);
    // }

    // unFollow() async {
    //   await DataBase(uid: res.dbUser.uid).deleteFriend(userProf.uid);
    // }

    // cancelAskForFriendship() async {
    //   await DataBase(uid: res.dbUser.uid).cancelAskForFriendship(userProf.uid);
    // }

    return BlocBuilder<PeopleBloc, PeopleProfileState>(
      builder: (context, state) {
        if (state is PeopleUnknown) {
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
                        child: Avatar(
                          photoUrl: user.imgUrl,
                          radius: 40,
                        )),
                  ],
                ),
              ),
              _ButtonFriend(
                  color: Colors.green,
                  title: 'Follow',
                  onPressed: () => peopleBloc.add(AskForFriendship(
                      myUid: res.dbUser.uid, newFriendUid: userProf.uid))),
              Positioned(
                top: 50,
                left: 15,
                child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    )),
              ),
            ],
          );
        } else if (state is PeopleWaitingForFriendResponse) {
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
                        child: Avatar(
                          photoUrl: user.imgUrl,
                          radius: 50,
                        )),
                  ],
                ),
              ),
              _ButtonFriend(
                  color: Colors.grey,
                  title: 'Pendent',
                  onPressed: () => peopleBloc.add(CancelAskForFriendship(
                      myUid: res.dbUser.uid, newFriendUid: userProf.uid))),
              Positioned(
                top: 50,
                left: 15,
                child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    )),
              ),
            ],
          );
        } else if (state is PeopleIsFriend) {
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
                        child: Avatar(
                          photoUrl: user.imgUrl,
                          radius: 50,
                        )),
                  ],
                ),
              ),
              _ButtonFriend(
                  color: Colors.red,
                  title: 'Unfollow',
                  onPressed: () => peopleBloc.add(DeleteFriendship(
                      myUid: res.dbUser.uid, newFriendUid: userProf.uid))),
              Positioned(
                top: 50,
                left: 15,
                child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    )),
              ),
            ],
          );
        }
      },
    );
  }
}

class _ButtonFriend extends StatefulWidget {
  final String title;
  final VoidCallback onPressed;
  final MaterialColor color;
  _ButtonFriend(
      {@required this.onPressed, @required this.title, @required this.color});

  @override
  __ButtonFriendState createState() => __ButtonFriendState();
}

class __ButtonFriendState extends State<_ButtonFriend> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 60,
        right: 5,
        child: FlatButton(
          child: Container(
            width: 90,
            height: 45,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: widget.color,
            ),
            child: Center(
              child: Text(widget.title,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
            ),
          ),
          onPressed: widget.onPressed,
        ));
  }
}

class _MyTripsBody extends StatelessWidget {
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
