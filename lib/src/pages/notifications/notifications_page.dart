import 'package:flights/src/models/dbuser_model.dart';
import 'package:flights/src/pages/notifications/add_notification_page.dart';
import 'package:flights/src/services/database.dart';
import 'package:flights/src/services/profile_services.dart';
import 'package:flights/src/services/push_notifications/create_topic_service.dart';
import 'package:flights/src/services/push_notifications/topics_services.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class NotificationsPage extends StatefulWidget {
  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  @override
  Widget build(BuildContext context) {
    final type = Provider.of<TopicServices>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        children: <Widget>[
          _capceleraNotifications(),
          (type.notiSelected == type.fixSelected)
              ? _ListTileTopics()
              : _ListTilePush()
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_alert),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddNotification(),
                  fullscreenDialog: true));
        },
      ),
    );
  }
}

class _ListTilePush extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final dbUser = Provider.of<ProfileServices>(context).dbUser;
    final size = MediaQuery.of(context).size;

    return Expanded(
        child: ListView.builder(
      itemCount: dbUser.notificationsRegister.length,
      itemBuilder: (BuildContext context, int index) {
        String dispOrg;
        String dispDest;
        if (dbUser.notificationsRegister.length > 0) {
          for (var i = 0; i < dbUser.subscriptionsRegister.length; i++) {
            print(dbUser.notificationsRegister[index].msg);
            print(dbUser.subscriptionsRegister[i].orig);
            print(dbUser.subscriptionsRegister[i].dest);
            if (dbUser.notificationsRegister[index].msg
                    .contains(dbUser.subscriptionsRegister[i].orig) &&
                dbUser.notificationsRegister[index].msg
                    .contains(dbUser.subscriptionsRegister[i].dest)) {
              dispOrg = dbUser.subscriptionsRegister[i].orig;
              dispDest = dbUser.subscriptionsRegister[i].dest;
            }
          }

          return ListTile(
            leading: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Icon(
                  Icons.notifications_active,
                  size: 35,
                  color: Colors.green[300].withOpacity(0.9),
                ),
                Text((index + 1).toString()),
              ],
            ),
            title: Container(
              padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
              width: size.width * 0.85,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text('For you:  ',
                          style: GoogleFonts.rubik(
                              fontSize: 15, fontWeight: FontWeight.w200)),
                      Text(
                        dispOrg + ' - ' + dispDest,
                        style: GoogleFonts.rubik(fontSize: 18),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  dbUser.notificationsRegister[index].msg
                          .replaceAll(new RegExp(r'[a-zA-Z : €📍🔔🖤]'), "")
                          .replaceAll('-', '') +
                      ' €',
                  style: GoogleFonts.montserrat(
                      fontSize: 25, fontWeight: FontWeight.w200),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            onTap: () async {
              print(dbUser.notificationsRegister[index].deep_link);

              var url = dbUser.notificationsRegister[index].deep_link
                  .replaceAll(' ', '');
              print(url);
              if (await canLaunch(url)) {
                await launch(url);
              } else {
                await launch(url).catchError((e) => print(e.toString()));
              }
            },
          );
        } else {
          return Center(child: Text('You don´t have push notifications yet'));
        }
      },
    ));
  }
}

class _ListTileTopics extends StatefulWidget {
  @override
  __ListTileTopicsState createState() => __ListTileTopicsState();
}

class __ListTileTopicsState extends State<_ListTileTopics> {
  @override
  Widget build(BuildContext context) {
    final dbUser = Provider.of<ProfileServices>(context).dbUser;

    return Expanded(
        child: ListView.builder(
      itemCount: dbUser.subscriptionsRegister.length,
      itemBuilder: (BuildContext context, int index) {
        if (dbUser.subscriptionsRegister.length > 0) {
          return Column(
            children: <Widget>[
              SizedBox(height: 10),
              _listTileNoti(context, dbUser, index),
            ],
          );
        } else {
          return Center(child: Text('You don´t create a topic yet'));
        }
      },
    ));
  }

  Widget _listTileNoti(BuildContext context, DbUser dbUser, int index) {
    final size = MediaQuery.of(context).size;
    return Dismissible(
      child: ListTile(
        dense: false,
        leading: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Icon(
              Icons.notifications_active,
              size: 35,
              color: Colors.yellow[600].withOpacity(0.9),
            ),
            // Text((index + 1).toString()),
          ],
        ),
        title: Container(
          padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
          width: size.width * 0.85,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                dbUser.subscriptionsRegister[index].orig +
                    ' - ' +
                    dbUser.subscriptionsRegister[index].dest,
                style: GoogleFonts.rubik(fontSize: 25),
              ),
              SizedBox(height: 5),
              Row(
                children: <Widget>[
                  Text(
                    'From' + ': ',
                    style: GoogleFonts.rubik(
                        fontSize: 15, fontWeight: FontWeight.w400),
                  ),
                  Text(
                    dbUser.subscriptionsRegister[index].dayInici.toString() +
                        '/' +
                        dbUser.subscriptionsRegister[index].monthInici
                            .toString() +
                        '/' +
                        dbUser.subscriptionsRegister[index].yearInici
                            .toString()
                            .substring(2),
                    style: GoogleFonts.rubik(
                        fontSize: 15, fontWeight: FontWeight.w300),
                  ),
                ],
              ),
              SizedBox(height: 2.5),
              Row(
                children: <Widget>[
                  Text(
                    'To' + ': ',
                    style: GoogleFonts.rubik(
                        fontSize: 15, fontWeight: FontWeight.w400),
                  ),
                  Text(
                    dbUser.subscriptionsRegister[index].dayFinal.toString() +
                        '/' +
                        dbUser.subscriptionsRegister[index].monthFinal
                            .toString() +
                        '/' +
                        dbUser.subscriptionsRegister[index].yearFinal
                            .toString()
                            .substring(2),
                    style: GoogleFonts.rubik(
                        fontSize: 15, fontWeight: FontWeight.w300),
                  ),
                ],
              ),
            ],
          ),
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              dbUser.subscriptionsRegister[index].price.toString() + ' €',
              style: GoogleFonts.montserrat(
                  fontSize: 25, fontWeight: FontWeight.w200),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      key: UniqueKey(),
      background: Container(color: Colors.red, child: Icon(Icons.delete)),
      onDismissed: (valor) async {
        final topicProvider = new Topicsprovider();
        final dbuser =
            Provider.of<ProfileServices>(context, listen: false).dbUser;
        await topicProvider.deleteTopicFirebase(
            dbuser.uid,
            dbUser.subscriptionsRegister[index].orig,
            dbUser.subscriptionsRegister[index].dest,
            dbUser.subscriptionsRegister[index].price,
            dbUser.subscriptionsRegister[index].dayInici,
            dbUser.subscriptionsRegister[index].monthInici,
            dbUser.subscriptionsRegister[index].yearInici,
            dbUser.subscriptionsRegister[index].dayFinal,
            dbUser.subscriptionsRegister[index].monthFinal,
            dbUser.subscriptionsRegister[index].yearFinal);
        await DataBase(uid: dbUser.uid).getUserInfo(context);
        setState(() {});
      },
    );
  }
}

class _capceleraNotifications extends StatefulWidget {
  @override
  __capceleraNotificationsState createState() =>
      __capceleraNotificationsState();
}

enum NotiType { topics, push }

Map<NotiType, String> _notiType = {
  NotiType.topics: 'Topics',
  NotiType.push: 'Push',

  // TripType.multicity: 'Multicity'
};

class __capceleraNotificationsState extends State<_capceleraNotifications> {
  NotiType _selectedTrip = NotiType.topics;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: size.height * 0.1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, 6),
                      blurRadius: 6),
                ]),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(_notiType.length, (index) {
                return buildTripTypeSelector(_notiType.keys.elementAt(index));
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTripTypeSelector(NotiType notiType) {
    var isSelected = _selectedTrip == notiType;
    return FlatButton(
      padding: EdgeInsets.only(left: 4, right: 16),
      onPressed: () {
        setState(() {
          _selectedTrip = notiType;

          final type = Provider.of<TopicServices>(context, listen: false);
          type.notiSelected = _selectedTrip.toString();
          //  type.fixType = TripType.roundtrip.toString();
          type.fixSelected = NotiType.topics.toString();
        });
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      color: isSelected ? Colors.blue : Colors.transparent,
      child: Row(
        children: <Widget>[
          if (isSelected)
            Icon(
              Icons.check_circle,
              color: Colors.white,
            ),
          Text(
            _notiType[notiType],
            style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
