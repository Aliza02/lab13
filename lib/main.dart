import 'package:flutter/material.dart';
import 'package:lab13/add_product.dart';
import 'package:lab13/list_products.dart';
import 'package:lab13/sort.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Grocery App"),
          backgroundColor: Colors.green,
        ),
        body: Container(
          alignment: Alignment.topCenter,
          padding: EdgeInsets.all(20),
          child: Column(children: [
            Image.asset('assets/images/logo.PNG'),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return Addproduct();
                }));
              },
              child: Text("Add Product"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return ListProducts();
                }));
              },
              child: Text("List Products"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return sortProduct();
                }));
              },
              child: Text("Sort Product "),
            ),
          ]),
        ),
      ),
    );
  }
}
