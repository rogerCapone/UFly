
import 'package:animate_do/animate_do.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flights/src/bloc/pendent_bloc.dart';
import 'package:flights/src/models/search_user_model.dart';
import 'package:flights/src/services/database.dart';
import 'package:flights/src/services/profile_services.dart';
import 'package:flights/src/widgets/avatar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PendentFollowers extends StatefulWidget {
  final uid;
  PendentFollowers({this.uid});
  @override
  _PendentFollowersState createState() => _PendentFollowersState();
}

class _PendentFollowersState extends State<PendentFollowers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Friend Requests'),
          backgroundColor: Colors.blueAccent,
        ),
        // body: _pendentToAcceptProva(context),
        body: BlocProvider(
            create: (context) => PendentBloc(), child: MyPendentListView()));
  }
}

class MyPendentListView extends StatelessWidget {
  const MyPendentListView({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pendentBloc = BlocProvider.of<PendentBloc>(context);
    final res = Provider.of<ProfileServices>(context);
    final size = MediaQuery.of(context).size;

    return BlocBuilder<PendentBloc, PendentState>(builder: (context, state) {
      if (state is PendentListIsLoading) {
        Future.delayed(Duration(seconds: 3),
            () => pendentBloc.add(FetchPendent(res.dbUser.uid)));
        return Center(
            child: Container(
                height: size.height * 0.7,
                width: size.width * 0.7,
                child: FlareActor(
                  "assets/animations/orb.flr",
                  animation: "Aura2",
                )));
        //     CircularProgressIndicator(
        //   backgroundColor: Colors.lightBlueAccent,
        //   strokeWidth: 0.6,
        // ));
      } else if (state is PendentListLoaded) {
        return Stack(
          children: <Widget>[
            ListView.builder(
              itemCount: state.getPdtList.length,
              itemBuilder: (BuildContext context, int index) {
                return _pendentToAccept(context, state.getPdtList[index]);
              },
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.all(30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      '👈🏼 Swipe Left To Decline',
                      style:
                          GoogleFonts.rubik(backgroundColor: Colors.red[100]),
                    ),
                    Text('Swipe Right To Accept 👉🏼',
                        style: GoogleFonts.rubik(
                            backgroundColor: Colors.blue[100]))
                  ],
                ),
              ),
            )
          ],
        );
      } else {
        return Text('Error happened :(');
      }
    });
  }
}

Widget _pendentToAccept(BuildContext context, UsersData userInfo) {
  final res = Provider.of<ProfileServices>(context, listen: false);
  final pendentBloc = BlocProvider.of<PendentBloc>(context);

  return Slidable(
    child: ListTile(
        leading: Avatar(photoUrl: userInfo.img, radius: 25),
        title: Text(userInfo.nickName),
        subtitle: Text(userInfo.frase),
        trailing: ElasticInLeft(
            child: Icon(
          FontAwesomeIcons.handPointUp,
        ))),
    actionPane: SlidableDrawerActionPane(),
    actions: <Widget>[
      IconSlideAction(
        caption: 'Accept',
        color: Colors.blueAccent,
        icon: Icons.thumb_up,
        onTap: () async {
          await DataBase(uid: res.dbUser.uid).acceptFriend(userInfo.uid);
          pendentBloc.add(ReFetchPendent(res.dbUser.uid));
        },
      ),
    ],
    secondaryActions: <Widget>[
      IconSlideAction(
        caption: 'Decline',
        color: Colors.red,
        icon: Icons.thumb_down,
        onTap: () async {
          await DataBase(uid: res.dbUser.uid).declineFriend(userInfo.uid);
          pendentBloc.add(FetchPendent(res.dbUser.uid));
        },
      ),
    ],
  );
}