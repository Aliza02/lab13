import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'db.dart';

class EditProduct extends StatefulWidget {
  String category = '';
  EditProduct({required this.category});

  @override
  State<StatefulWidget> createState() {
    return _EditProduct();
  }
}

class _EditProduct extends State<EditProduct> {
  TextEditingController name = TextEditingController();
  TextEditingController categoryctrl = TextEditingController();

  MyDb mydb = new MyDb();

  @override
  void initState() {
    mydb.open();

    Future.delayed(Duration(milliseconds: 500), () async {
      var data = await mydb.getProduct(widget.category);
      if (data != null) {
        name.text = data["name"];
        categoryctrl.text = data["category"].toString();

        setState(() {});
      } else {
        print("No any data with this category: " + widget.category.toString());
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Edit Product"),
        ),
        body: Container(
          padding: EdgeInsets.all(30),
          child: Column(
            children: [
              TextField(
                controller: name,
                decoration: InputDecoration(
                  hintText: "product Name",
                ),
              ),
              TextField(
                controller: categoryctrl,
                decoration: InputDecoration(
                  hintText: "Product category.",
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    mydb.db.rawInsert(
                        "UPDATE products SET name = ?, category = ? WHERE category = ?",
                        [name.text, categoryctrl.text, widget.category]);

                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Product Data Updated")));
                  },
                  child: Text("Update Product  Data")),
            ],
          ),
        ));
  }
}
