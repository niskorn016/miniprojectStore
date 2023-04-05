import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.all(90),
          ),
          const Text(
            "SUEA",
            style: TextStyle(fontSize: 50),
            textAlign: TextAlign.center,
          ),
          const Text(
            "SHOP",
            style: TextStyle(fontSize: 50),
            textAlign: TextAlign.center,
          ),
          Padding(padding: EdgeInsets.only(bottom: 60)),
          gotoStore(context),
          const Padding(
            padding: EdgeInsets.all(50),
          ),
          Padding(
            padding: const EdgeInsets.all(0),
            //child: gotoStore(context),
          ),
          Padding(padding: EdgeInsets.only(bottom: 10)),
          Image.asset("assets/seuashop.png"),
        ],
      ),
    );
  }

  ElevatedButton gotoStore(BuildContext context) {
    return ElevatedButton(
      // ignore: prefer_const_constructors
      style: ButtonStyle(
          backgroundColor: const MaterialStatePropertyAll(Colors.blue),
          minimumSize: const MaterialStatePropertyAll(Size(250, 50))),
      child: const Text(
        'เริ่มใช้งาน',
        style: TextStyle(fontSize: 20, color: Colors.black),
      ),
      onPressed: () {
        Navigator.pushNamed(context, '/menu1');
      },
    );
  }
}
