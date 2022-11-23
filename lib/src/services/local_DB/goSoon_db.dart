import 'package:sqflite/sqflite.dart';

//canviar nom a GOSOON
class GoSoon {
  int id;
  String name;
  String img;
  GoSoon({this.id, this.name, this.img});

  Map<String, dynamic> toMap() {
    return {"name": name, "img": img};
  }

  GoSoon.fromMap(Map<String, dynamic> map) {
    name = map['name'];
    img = map['img'];
    id = map["id"];
  }
}

class GoSoonDb {
  Database _db;
  initDB() async {
    _db = await openDatabase('goSoon.db', version: 1,
        onCreate: (Database db, int version) {
      db.execute(
          "CREATE TABLE goSoon (id INTEGER PRIMARY KEY,  name TEXT NOT NULL, img TEXT NOT NULL);");
    });
    print('DB INITIALIZED' + _db.toString());
  }

  insert(GoSoon goSoon) async {
    print(await _db.insert("goSoon", goSoon.toMap()));
  }

  delete(GoSoon goSoon) async {
    print(goSoon.id);
    await _db.delete("goSoon", where: "id = ?", whereArgs: [goSoon.id]);
    print('SHOULD BE DELETETED');
  }

  Future<List<GoSoon>> getAllCities() async {
    print("trying to get dbGoSoon");
    List<Map<String, dynamic>> results = await _db.query("goSoon");
    print(results);
    print(results.length);
    return results.map((map) => GoSoon.fromMap(map)).toList();
  }
}
