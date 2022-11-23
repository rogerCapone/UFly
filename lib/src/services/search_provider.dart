
import 'package:flutter/material.dart';

class SearchProvider with ChangeNotifier{


  //Parametres de Origen

String _codeIataOrg  = 'BCN';
String _cityNameOrg  = 'Barcelona';
String _airportNameOrg = 'El Prat de Llobregat';

bool _isOrigen = true;
DateTime _dateTimeDep = DateTime.now();
DateTime _dateTimeArr = DateTime.now().add(Duration(days: 7));
DateTime _dateTimeActual = DateTime.now();

String get codeIataOrg => this._codeIataOrg;
String get cityNameOrg => this._cityNameOrg;
String get airportNameOrg => this._airportNameOrg;

bool get isOrigen => this._isOrigen;
DateTime get dateTimeDep => this._dateTimeDep;
DateTime get dateTimeArr => this._dateTimeArr;
DateTime get dateTimeActual => this._dateTimeActual;

set isOrigen(bool valor) {
  this._isOrigen = valor;
  notifyListeners();
}

set dateTimeDep(DateTime valor) {
  this._dateTimeDep = valor;
  notifyListeners();
}

set dateTimeArr(DateTime valor) {
  this._dateTimeArr = valor;
  notifyListeners();
}



set codeIataOrg (String valor){
  this._codeIataOrg = valor;
  notifyListeners();
}

set cityNameOrg(String valor){
  this._cityNameOrg = valor;
  notifyListeners();
}

set airportNameOrg(String valor){
  this._airportNameOrg = valor;
  notifyListeners();
}


//Paramatres de destino

String _codeIataDes  = 'BIO';
String _cityNameDes  = 'Bilbao';
String _airportNameDes = 'Bilbao';

String get codeIataDes => this._codeIataDes;
String get cityNameDes => this._cityNameDes;
String get airportNameDes => this._airportNameDes;


set codeIataDes (String valor){
  this._codeIataDes = valor;
  notifyListeners();
}

set cityNameDes(String valor){
  this._cityNameDes = valor;
  notifyListeners();
}

set airportNameDes(String valor){
  this._airportNameDes = valor;
  notifyListeners();
}



}