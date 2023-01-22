import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lab13/db.dart';

class Addproduct extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Addproduct();
  }
}

class _Addproduct extends State<Addproduct> {
  TextEditingController name = TextEditingController();
  TextEditingController category = TextEditingController();

  MyDb mydb = new MyDb();

  @override
  void initState() {
    mydb.open();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Add Product"),
          backgroundColor: Colors.green,
        ),
        body: Container(
          padding: EdgeInsets.all(30),
          child: Column(
            children: [
              TextField(
                controller: name,
                decoration: InputDecoration(
                  hintText: "Product Name",
                ),
              ),
              TextField(
                controller: category,
                decoration: InputDecoration(
                  hintText: "Product Category.",
                ),
              ),
              ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  onPressed: () async {
                    await mydb.db.rawInsert(
                        "INSERT INTO products (name, category) VALUES (?, ?)",
                        [name.text, category.text]);

                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("New product Added")));

                    name.text = "";
                    category.text = "";
                  },
                  child: Text("Add")),
            ],
          ),
        ));
  }
}
