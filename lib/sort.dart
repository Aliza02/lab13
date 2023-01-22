import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lab13/db.dart';
import 'package:lab13/edit_product.dart';

class sortProduct extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _sortProduct();
  }
}

class _sortProduct extends State<sortProduct> {
  List<Map> slist = [];
  MyDb mydb = new MyDb();

  List<Map> haircare = [];
  List<Map> beverages = [];
  List<Map> bakery = [];
  List<Map> cleaning = [];

  @override
  void initState() {
    mydb.open();
    getdata();
    super.initState();
  }

  getdata() {
    Future.delayed(Duration(milliseconds: 500), () async {
      slist = await mydb.db.rawQuery('SELECT * FROM products');
      haircare = await mydb.db
          .rawQuery('SELECT * from products WHERE category=?', ['Haircare']);

      beverages = await mydb.db
          .rawQuery('SELECT * from products WHERE category=?', ['Beverages']);
      bakery = await mydb.db
          .rawQuery('SELECT * from products WHERE category=?', ['Bakery']);

      cleaning = await mydb.db
          .rawQuery('SELECT * from products WHERE category=?', ['Cleaning']);

      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Products"),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: slist.length == 0
              ? Text("No any students to show.")
              : Center(
                  child: Column(
                    children: [
                      Text(
                        'HairCare',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20.0),
                      ),
                      Container(
                        child: haircare.length == 0
                            ? Text("No prod to show")
                            : Column(
                                children: haircare.map((stuone) {
                                  return Card(
                                    child: ListTile(
                                      leading: Icon(
                                          Icons.production_quantity_limits),
                                      title: Text(stuone["name"]),
                                      subtitle:
                                          Text(stuone["category"].toString()),
                                      trailing: Icon(Icons.shopping_cart),
                                    ),
                                  );
                                }).toList(),
                              ),
                      ),
                      Text(
                        'Beverages',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20.0),
                      ),
                      Container(
                        child: beverages.length == 0
                            ? Text("No prod to show")
                            : Column(
                                children: beverages.map((stuone) {
                                  return Card(
                                    child: ListTile(
                                      leading: Icon(
                                          Icons.production_quantity_limits),
                                      title: Text(stuone["name"]),
                                      subtitle:
                                          Text(stuone["category"].toString()),
                                      trailing: Icon(Icons.shopping_cart),
                                    ),
                                  );
                                }).toList(),
                              ),
                      ),
                      Text(
                        'Bakery',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20.0),
                      ),
                      Container(
                        child: bakery.length == 0
                            ? Text("No prod to show")
                            : Column(
                                children: bakery.map((stuone) {
                                  return Card(
                                    child: ListTile(
                                      leading: Icon(
                                          Icons.production_quantity_limits),
                                      title: Text(stuone["name"]),
                                      subtitle:
                                          Text(stuone["category"].toString()),
                                      trailing: Icon(Icons.shopping_cart),
                                    ),
                                  );
                                }).toList(),
                              ),
                      ),
                      Text(
                        'Cleaning',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20.0),
                      ),
                      Container(
                        child: cleaning.length == 0
                            ? Text("No prod to show")
                            : Column(
                                children: cleaning.map((stuone) {
                                  return Card(
                                    child: ListTile(
                                      leading: Icon(
                                          Icons.production_quantity_limits),
                                      title: Text(stuone["name"]),
                                      subtitle:
                                          Text(stuone["category"].toString()),
                                      trailing: Icon(Icons.shopping_cart),
                                    ),
                                  );
                                }).toList(),
                              ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
