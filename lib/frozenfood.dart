import 'package:flutter/material.dart';
import 'package:store_1/freshfoodall.dart';

class Frozenfood extends StatelessWidget {
  const Frozenfood({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade100,
      ),
      backgroundColor: Colors.blue.shade100,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.all(40),
            ),
            const Text(
              "อาหาร",
              style: TextStyle(fontSize: 50),
              textAlign: TextAlign.center,
            ),
            const Text(
              "แช่แข็ง",
              style: TextStyle(fontSize: 50),
              textAlign: TextAlign.center,
            ),
            const Padding(
              padding: EdgeInsets.all(50),
            ),
            Padding(
              padding: const EdgeInsets.all(0),
              child: gotoFreshFoodAll(context),
            ),
            Padding(padding: EdgeInsets.only(bottom: 70)),
            Image.asset("assets/frozenfoodmenu.png")
          ],
        ),
      ),
    );
  }

  ElevatedButton gotoFreshFoodAll(BuildContext context) {
    return ElevatedButton(
      // ignore: prefer_const_constructors
      style: ButtonStyle(
          backgroundColor: const MaterialStatePropertyAll(Colors.blue),
          minimumSize: const MaterialStatePropertyAll(Size(250, 50))),
      child: const Text(
        'ซื้อสินค้า',
        style: TextStyle(fontSize: 20),
      ),
      onPressed: () {
        Navigator.pushNamed(context, '/frozenfoodall');
      },
    );
  }
}
