import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lab13/db.dart';
import 'package:lab13/edit_product.dart';

class ListProducts extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ListProducts();
  }
}

class _ListProducts extends State<ListProducts> {
  List<Map> slist = [];
  MyDb mydb = new MyDb();

  @override
  void initState() {
    mydb.open();
    getdata();
    super.initState();
  }

  getdata() {
    Future.delayed(Duration(milliseconds: 500), () async {
      slist = await mydb.db.rawQuery('SELECT * FROM products');
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
              : Column(
                  children: slist.map((stuone) {
                    return Card(
                      child: ListTile(
                        leading: Icon(Icons.production_quantity_limits),
                        title: Text(stuone["name"]),
                        subtitle: Text(stuone["category"].toString()),
                        trailing: Wrap(
                          children: [
                            IconButton(
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (BuildContext context) {
                                    return EditProduct(
                                        category: stuone["category"]);
                                  }));
                                },
                                icon: Icon(Icons.edit)),
                            IconButton(
                                onPressed: () async {
                                  await mydb.db.rawDelete(
                                      "DELETE FROM products WHERE name = ?",
                                      [stuone["name"]]);
                                  print("Data Deleted");
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content:
                                              Text("product Data Deleted")));
                                  getdata();
                                },
                                icon: Icon(Icons.delete, color: Colors.red))
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
        ),
      ),
    );
  }
}
