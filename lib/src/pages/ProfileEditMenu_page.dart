import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flights/src/login_pages/platform_alert_dialog.dart';
import 'package:flights/src/services/database.dart';
import 'package:flights/src/services/firebase_storage_service/build_user_img.dart';
import 'package:flights/src/services/profile_services.dart';
import 'package:flights/src/widgets/avatar_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MenuProfile extends StatelessWidget {
  final GlobalKey<FabCircularMenuState> fabKey = GlobalKey();

  

  @override
  Widget build(BuildContext context) {
    final res = Provider.of<ProfileServices>(context);
    bool resp;

    
    

    _getResp() async {
      res.userName == null ? res.dbUser.userName : res.userName;
      res.nickName == null ? res.dbUser.nickName : res.nickName;
      res.frase == null ? res.dbUser.frase : res.frase;
      res.phoneNumber == null ? res.dbUser.phoneNumber : res.phoneNumber;
      res.userWeb == null ? res.dbUser.userWeb : res.userWeb;
      
      resp = await DataBase(uid: res.dbUser.uid).updateUserInfo(
          res.userName, res.nickName, res.frase, res.phoneNumber, res.userWeb);

      if (resp == true) {
        print('Los Cambios se han guardado');
        PlatformAlertDialog(
          title: 'Correcto',
          content: 'Los cambios se han guardado con exito',
          defaultActionText: 'Ok',
        ).show(context);
         Navigator.pop(context);
      } else {
        PlatformAlertDialog(
          title: 'Error',
          content: 'Este nickName ya existe, prueba otro',
          defaultActionText: 'Ok',
        ).show(context);
      }
    }

    final menSel = Provider.of<ProfileServices>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text((menSel.menuSelected == 3)
            ? 'Edit Profile'
            : (menSel.menuSelected == 2) ? 'Your Activity' : 'Settings'),
        actions: <Widget>[
          FlatButton(
              child: menSel.menuSelected != 1
                  ? Row(
                      children: <Widget>[
                        Text('Save',
                            style:
                                TextStyle(color: Colors.white, fontSize: 16)),
                        Icon(
                          Icons.assignment_turned_in,
                          color: Colors.white,
                        )
                      ],
                    )
                  : SizedBox(),
              onPressed: () {
                _getResp();
              })
        ],
      ),
      body: (menSel.menuSelected == 1)
          ? _SettingsPage()
          : (menSel.menuSelected == 2)
              ? _Activity()
              : (menSel.menuSelected == 3) ? _EditProfile() : _EditProfile(),
      floatingActionButton: _MenuProfileWidget(),
    );
  }
}

class _Activity extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white.withOpacity(0.4),
    );
  }
}

class _SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white.withOpacity(0.4),
      child: Column(
        children: <Widget>[
          SizedBox(height: 20),
          _settingsListTiles(
              context, Icon(Icons.person_add), 'Invite friends', 'information'),
          _settingsListTiles(context, Icon(Icons.notifications),
              'Notifications', 'information'),
          _settingsListTiles(
              context, Icon(Icons.lock), 'Privacity', 'information'),
          _settingsListTiles(
              context, Icon(Icons.verified_user), 'Security', 'information'),
          _settingsListTiles(
              context, Icon(Icons.credit_card), 'Payments', 'credit_card'),
          _settingsListTiles(
              context, Icon(Icons.person_pin), 'Acount', 'information'),
          _settingsListTiles(
              context, Icon(Icons.help_outline), 'Help', 'information'),
          _settingsListTiles(
              context, Icon(Icons.info_outline), 'Information', 'information'),
        ],
      ),
    );
  }

  Widget _settingsListTiles(
      BuildContext context, Icon icon, String title, String route) {
    return ListTile(
      leading: icon,
      title: Text(title),
      trailing: Icon(Icons.arrow_forward),
      onTap: () => Navigator.pushNamed(context, route),
    );
  }
}

class _EditProfile extends StatefulWidget {
  @override
  __EditProfileState createState() => __EditProfileState();
}

class __EditProfileState extends State<_EditProfile> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final dbuser = Provider.of<ProfileServices>(context).dbUser;

    return Container(
      color: Colors.white.withOpacity(0.4),
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: size.height * 0.17,
            // color: Colors.grey.withOpacity(0.1),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Avatar(
                    photoUrl: dbuser.imgUrl,
                    radius: 50,
                    onPressed: () => chooseAvatar(context),
                  ),
                  SizedBox(height: 10),
                  SizedBox(height: 10),
                  Divider(
                    height: 5,
                    color: Colors.lightBlue,
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    _textFieledUpdate(
                        context, Icon(Icons.person), dbuser.userName, 1),
                    SizedBox(height: 20),
                    _textFieledUpdate(
                        context, Icon(Icons.person_pin), dbuser.nickName, 2),
                    SizedBox(height: 20),
                    _textFieledUpdate(context, Icon(Icons.lightbulb_outline),
                        dbuser.frase, 3),
                    SizedBox(height: 20),
                    _textFieledUpdate(
                        context,
                        Icon(Icons.web_asset),
                        dbuser.userWeb == ''
                            ? 'www.myContactWeb.com'
                            : dbuser.userWeb,
                        4),
                    SizedBox(height: 20),
                    SizedBox(height: 20),
                    _textFieledUpdate(
                        context, Icon(Icons.email), dbuser.userEmail, 5),
                    SizedBox(height: 20),
                    _textFieledUpdate(
                        context,
                        Icon(Icons.phone),
                        dbuser.phoneNumber == ''
                            ? '+34 634234091'
                            : dbuser.phoneNumber,
                        6),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _textFieledUpdate(
      BuildContext context, Icon icon, String title, int pos) {
    final res = Provider.of<ProfileServices>(context);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          icon: icon,
          hintText: title,

          // counterText: snapshot.data,
        ),
        onChanged: (value) {
          (pos == 1)
              ? res.userName = value
              : (pos == 2)
                  ? res.nickName = value
                  : (pos == 3)
                      ? res.frase = value
                      : (pos == 4)
                          ? res.userWeb = value
                          : (pos == 6)
                              ? res.phoneNumber = value
                              : res.phoneNumber = value;
        },
      ),
    );
  }
}

class _MenuProfileWidget extends StatelessWidget {
  final GlobalKey<FabCircularMenuState> fabKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) => FabCircularMenu(
        key: fabKey,
        alignment: Alignment.bottomRight,
        ringColor: Color(0xFF192A56).withOpacity(0.3),
        ringDiameter: 500.0,
        ringWidth: 150.0,
        fabSize: 64.0,
        fabElevation: 8.0,
        fabColor: Colors.blue,
        fabOpenIcon: Icon(Icons.menu, color: Colors.white),
        fabCloseIcon: Icon(Icons.close, color: Colors.white),
        fabMargin: const EdgeInsets.all(26.0),
        animationDuration: const Duration(milliseconds: 800),
        animationCurve: Curves.easeInOutCirc,
        onDisplayChange: (isOpen) {
          _showSnackBar(context, "The menu is ${isOpen ? "open" : "closed"}");
        },
        children: <Widget>[
          RawMaterialButton(
              onPressed: () {},
              shape: CircleBorder(),
              padding: EdgeInsets.all(24.0),
              child: FlatButton.icon(
                icon: Icon(Icons.settings, color: Colors.white, size: 35),
                label: Text(
                  'Settings',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed: () {
                  final menSel =
                      Provider.of<ProfileServices>(context, listen: false);
                  menSel.menuSelected = 1;
                },
              )),
          RawMaterialButton(
              onPressed: () {},
              shape: CircleBorder(),
              padding: EdgeInsets.all(24.0),
              child: FlatButton.icon(
                icon: Icon(Icons.insert_chart, color: Colors.white, size: 35),
                label: Text(
                  'Activity',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed: () {
                  final menSel =
                      Provider.of<ProfileServices>(context, listen: false);
                  menSel.menuSelected = 2;
                },
              )),
          RawMaterialButton(
              onPressed: () {},
              shape: CircleBorder(),
              padding: EdgeInsets.all(24.0),
              child: FlatButton.icon(
                icon: Icon(Icons.edit, color: Colors.white, size: 35),
                label: Text('Profile',
                    style: TextStyle(color: Colors.white, fontSize: 20)),
                onPressed: () {
                  final menSel =
                      Provider.of<ProfileServices>(context, listen: false);
                  menSel.menuSelected = 3;
                },
              )),
        ],
      ),
    );
  }
}

void _showSnackBar(BuildContext context, String message) {
  Scaffold.of(context).showSnackBar(SnackBar(
    content: Text(message),
    duration: const Duration(milliseconds: 1000),
  ));
}