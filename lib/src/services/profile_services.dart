import 'package:flights/src/models/dbuser_model.dart';
import 'package:flights/src/services/auth_service.dart';
import 'package:flutter/material.dart';


class ProfileServices with ChangeNotifier {

  int _bodySelected = 0;
  DbUser _dbUser;
  User _userUid;

  String _userName;
  String _nickName;
  String _frase;
  String _userWeb;
  String _phoneNumber;




  

  int _menuSelected = 0;
  


  int get bodySelected => this._bodySelected;

  set bodySelected(int valor) {
    this._bodySelected = valor;
    notifyListeners();

  }

 DbUser get dbUser => this._dbUser;

 set dbUser(DbUser valor) {
   this._dbUser = valor;
   notifyListeners();
 }

 int get menuSelected => this._menuSelected;

  set menuSelected(int valor) {
    this._menuSelected = valor;
    notifyListeners();

  }

  User get userUid => this._userUid;

  set userUid(User valor) {
    this._userUid = valor;
    notifyListeners();

  }
  
  String get userName => this._userName;

  set userName(String valor) {
    this._userName = valor;
  
    notifyListeners();
  }


  String get nickName => this._nickName;

  set nickName(String valor) {
    this._nickName = valor;
   
    notifyListeners();
  }

  String get frase => this._frase;

  set frase(String valor) {
    this._frase = valor;
    notifyListeners();
  }


  String get userWeb => this._userWeb;

  set userWeb(String valor) {
    this._userWeb = valor;
    notifyListeners();
  }


  String get phoneNumber => this._phoneNumber;

  set phoneNumber(String valor) {
    this._phoneNumber = valor;
    notifyListeners();
  }
 



 
  

}