import 'package:sqflite/sqflite.dart';

class MyTrip {
  int id;
  String org;
  String orgName;
  String dest;
  String destName;
  String dateDep;
  String dateArr;
  String depTime;
  String arrTime;
  String airline;
  String airlineImg;
  String idVuelo;
  MyTrip(
      {this.id,
      this.org,
      this.orgName,
      this.dest,
      this.destName,
      this.dateDep,
      this.dateArr,
      this.depTime,
      this.arrTime,
      this.airline,
      this.airlineImg,
      this.idVuelo});

  Map<String, dynamic> toMap() {
    return {
      "org": org,
      "orgName": orgName,
      "dest": dest,
      "destName": destName,
      "dateDep": dateDep.toString(),
      "dateArr": dateArr.toString(),
      "depTime": depTime.toString(),
      "arrTime": arrTime.toString(),
      "airline": airline,
      "airlineImg": airlineImg,
      "idVuelo": idVuelo
    };
  }

  MyTrip.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    org = map['org'];
    orgName = map['orgName'];
    dest = map['dest'];
    destName = map['destName'];
    dateDep = map['dateDep'];
    dateArr = map['dateArr'];
    depTime = map['depTime'];
    arrTime = map['arrTme'];
    airline = map['airline'];
    airlineImg = map['airlineImg'];
    idVuelo = map['idVuelo'];
  }
}

class TripDb {
  Database _db;
  initDB() async {
    _db = await openDatabase('trips.db', version: 1,
        onCreate: (Database db, int version) {
      db.execute(
          "CREATE TABLE myTrip (id INTEGER PRIMARY KEY,  org TEXT NOT NULL, orgName TEXT NOT NULL, dest TEXT NOT NULL, destName TEXT NOT NULL, dateDep TEXT NOT NULL, dateArr TEXT NOT NULL, depTime TEXT NOT NULL, arrTime TEXT NOT NULL, airline TEXT NOT NULL, airlineImg TEXT NOT NULL, idVuelo TEXT NOT NULL);");
    });
  }

  insert(MyTrip myTrip) async {
    print(myTrip.airline);
    print(await _db.insert("myTrip", myTrip.toMap()));
  }

  delete(MyTrip myTrip) async {
    print(await _db.delete("myTrip", where: "id = ?", whereArgs: [myTrip.id]));
  }

  Future<List<MyTrip>> getMyTrips() async {
    List<Map<String, dynamic>> results = await _db.query("myTrip");
    print(results);
    print(results.length);
    print('Yo SQLite le passat al BLOC');
    return results.map((map) => MyTrip.fromMap(map)).toList();
  }
}
