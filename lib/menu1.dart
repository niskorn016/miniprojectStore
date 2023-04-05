import 'package:flutter/material.dart';
import 'package:store_1/main.dart';
import 'package:store_1/freshfood.dart';
import 'package:store_1/frozenfood.dart';

class FMenu extends StatefulWidget {
  const FMenu({Key? key}) : super(key: key);
  State<FMenu> createState() => _FMenu();
}

// This widget is the root of your application.
@override
class _FMenu extends State<FMenu> {
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 154, 204, 244),
      appBar: AppBar(
        title: Text(
          'เมนู',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Color.fromARGB(255, 74, 153, 217),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 0),
            ),
            Image.asset(
              "assets/freshfoodmenu.png",
              height: 150,
              width: 250,
            ),
            gotoFreshfood(context),
            Padding(
              padding: EdgeInsets.only(bottom: 70),
            ),
            Image.asset(
              "assets/frozenfoodmenu.png",
              height: 150,
              width: 250,
            ),
            gotoFrozenfood(context),
          ],
        ),
      ),

      //  Padding(padding: EdgeInsets.only(bottom: 250)),
      //       Image.asset("assets/seuashop.png")
    );
  }
}

ElevatedButton gotoFreshfood(BuildContext context) {
  return ElevatedButton(
    // ignore: prefer_const_constructors
    style: ButtonStyle(
        backgroundColor:
            const MaterialStatePropertyAll(Color.fromARGB(255, 230, 221, 124)),
        minimumSize: const MaterialStatePropertyAll(Size(250, 50))),
    child: const Text(
      'อาหารสด',
      style: TextStyle(fontSize: 20, color: Colors.black),
    ),

    onPressed: () {
      Navigator.pushNamed(context, '/freshfood');
    },
  );
}

ElevatedButton gotoFrozenfood(BuildContext context) {
  return ElevatedButton(
    // ignore: prefer_const_constructors
    style: ButtonStyle(
        backgroundColor:
            const MaterialStatePropertyAll(Color.fromARGB(255, 230, 221, 124)),
        minimumSize: const MaterialStatePropertyAll(Size(250, 50))),
    child: const Text(
      'อาหารแช่แข็ง',
      style: TextStyle(
        fontSize: 20,
        color: Colors.black,
      ),
    ),
    onPressed: () {
      Navigator.pushNamed(context, '/frozenfood');
    },
  );
}
