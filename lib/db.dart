import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class MyDb {
  late Database db;

  Future open() async {
    // Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'demo.db');
    //join is from path package
    print(
        path); //output /data/user/0/com.testapp.flutter.testapp/databases/demo.db

    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute('''

                    CREATE TABLE IF NOT EXISTS products( 
                          id primary key,
                          name varchar(255) not null,
                          category varchar(255) not null
                          
                      );

                      //create more table here
                  
                  ''');
      //table students will be created if there is no table 'students'
      print("Table Created");
    });
  }

  Future<Map<dynamic, dynamic>?> getProduct(String category) async {
    List<Map> maps = await db
        .query('products', where: 'category = ?', whereArgs: [category]);
    //getting student data with roll no.
    if (maps.length > 0) {
      return maps.first;
    }
    return null;
  }
}
