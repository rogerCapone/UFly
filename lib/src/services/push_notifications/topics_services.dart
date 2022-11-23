import 'package:flutter/material.dart';

class TopicServices with ChangeNotifier{

  //decalaration variables


  String _notiSelected = 'Topics';
  String _fixSelected = 'Topics';

  double _priceNot;
  String _query = 'air';

  // get de las variables

  double get priceNot => this._priceNot;
  String get query =>this._query;
  String get notiSelected =>this._notiSelected;
  String get fixSelected =>this._fixSelected;


  // set de los datos


   set priceNot(double valor) {
    this._priceNot = valor;
    notifyListeners();
  }

  set query(String valor){
    this._query= valor;
    notifyListeners();
  }

  set notiSelected(String valor){
    this._notiSelected = valor;
    notifyListeners();
  }
  set fixSelected(String valor){
    this._fixSelected = valor;
    notifyListeners();
  }

 



String _codeOrg  = 'BCN';
String _cityOrg  = 'Barcelona';
String _airportOrg = 'El Prat de Llobregat';

bool _origen = true;
DateTime _dateDep = DateTime.now();
DateTime _dateArr = DateTime.now().add(Duration(days: 7));

String get codeOrg  => this._codeOrg ;
String get cityOrg => this._cityOrg;
String get airportOrg => this._airportOrg;

bool get origen => this._origen;
DateTime get dateDep => this._dateDep;
DateTime get dateArr => this._dateArr;

set origen(bool valor) {
  this._origen = valor;
  notifyListeners();
}

set dateDep(DateTime valor) {
  this._dateDep = valor;
  notifyListeners();
}

set dateArr(DateTime valor) {
  this._dateArr= valor;
  notifyListeners();
}


set codeOrg  (String valor){
  this._codeOrg = valor;
  notifyListeners();
}

set cityOrg(String valor){
  this._cityOrg = valor;
  notifyListeners();
}

set airportOrg(String valor){
  this._airportOrg = valor;
  notifyListeners();
}


//Paramatres de destino

String _codeDes  = 'MAD';
String _cityDes  = 'Madrid';
String _airportDes = 'Barajas Airport';

String get codeDes => this._codeDes;
String get cityDes => this._cityDes;
String get airportDes => this._airportDes;


set codeDes (String valor){
  this._codeDes = valor;
  notifyListeners();
}

set cityDes(String valor){
  this._cityDes = valor;
  notifyListeners();
}

set airportDes(String valor){
  this._airportDes = valor;
  notifyListeners();
}


}