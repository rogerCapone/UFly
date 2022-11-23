import 'package:flights/src/models/category_home.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeService with ChangeNotifier{

String _selectedCategory = 'Flights';
String _query =' ';
String _queryCity;
String _typeSearchSelected = 'RoundTrip';
String _fixType= 'RoundTrip';
String _subTypeSelected = 'Departure';
String _subFixType = 'Departure';

String _selectDepArr = 'Departures';

List<String> cities = [

  'Barcelona',
  'Madrid',
  'Roma'
];

bool   _pantallaSearch = true;




  List<Category> categories = [
    Category(Icons.flight, 'Flights'),
    Category(FontAwesomeIcons.mapMarked, 'Cities'),
    Category(FontAwesomeIcons.city, 'Airports'),
    // Category(FontAwesomeIcons.user, 'Users'),
    Category(FontAwesomeIcons.hSquare, 'Hotels'),
    // Category(FontAwesomeIcons.planeDeparture, 'Airlines'),
    // Category(FontAwesomeIcons.hSquare, 'Hotels'),
    Category(FontAwesomeIcons.taxi, 'Taxis'),
   
  ];

  String get selectedCategory => this._selectedCategory;

  set selectedCategory(String valor){
    this._selectedCategory = valor;
    notifyListeners();
  }

String get query => this._query;

set query (String valor) {
  this._query = valor;
  notifyListeners();
}

String get queryCity => this._queryCity;

set queryCity (String valor){
  this._queryCity = valor;
  notifyListeners();
}

String get typeSearchSelected => this._typeSearchSelected;

set typeSearchSelected(String valor) {
  this._typeSearchSelected = valor;
  notifyListeners();
}

bool get pantallaSearch => this._pantallaSearch;

set pantallaSearch( bool valor) {
  this._pantallaSearch = valor;
  notifyListeners();
}

String get fixType => this._fixType;

set fixType( String valor) {
  this._fixType = valor;
  notifyListeners();
}


String get subTypeSelected => this._subTypeSelected;

set subTypeSelected( String valor) {
  this._subTypeSelected = valor;
  notifyListeners();
}


String get subFixType => this._subFixType;

set subFixType( String valor) {
  this._subFixType = valor;
  notifyListeners();
}

String get selectDepArr=> this._selectDepArr;

set selectDepArr(String valor ){
  this._selectDepArr = valor;
  notifyListeners();
}

  

}

