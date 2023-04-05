import 'package:flutter/material.dart';
import 'package:store_1/freshfoodall.dart';

class Freshfood extends StatelessWidget {
  const Freshfood({Key? key}) : super(key: key);

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
              "สด",
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
            Image.asset("assets/seuashop.png")
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
        Navigator.popAndPushNamed(context, '/freshfoodall');
      },
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});

//   // This widget is the home page of your application. It is stateful, meaning
//   // that it has a State object (defined below) that contains fields that affect
//   // how it looks.

//   // This class is the configuration for the state. It holds the values (in this
//   // case the title) provided by the parent (in this case the App widget) and
//   // used by the build method of the State. Fields in a Widget subclass are
//   // always marked "final".

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;

//   void _incrementCounter() {
//     setState(() {
//       _counter++;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.blue.shade100,
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               "SUEA",
//               style: TextStyle(fontSize: 50),
//               textAlign: TextAlign.center,
//             ),
//             const Text(
//               "SHOP",
//               style: TextStyle(fontSize: 50),
//               textAlign: TextAlign.center,
//             ),
//             const Padding(
//               padding: EdgeInsets.all(50),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(0),
//               child: gotoStore(context),
//             ),
//             Padding(padding: EdgeInsets.only(bottom: 250)),
//             Image.asset("assets/seuashop.png")
//           ],
//         ),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }

 
