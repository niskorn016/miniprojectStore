import 'package:flutter/material.dart';
import 'package:store_1/cart.dart';
import 'package:store_1/home.dart';

class PaypalPage extends StatefulWidget {
  const PaypalPage({Key? key}) : super(key: key);

  @override
  _PaypalPage createState() => _PaypalPage();
}

class _PaypalPage extends State<PaypalPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/paypal.png",
              height: 250,
              width: 300,
            ),
            Text(
              'ชำระเงินสำเร็จ',
              style: TextStyle(
                  fontSize: 30,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: gotoMenu(context),
            ),
          ],
        ),
      ),
    );
  }

  ElevatedButton gotoMenu(BuildContext context) {
    return ElevatedButton(
      // ignore: prefer_const_constructors
      style: ButtonStyle(
          backgroundColor: const MaterialStatePropertyAll(Colors.green),
          minimumSize: const MaterialStatePropertyAll(Size(250, 50))),
      child: const Text(
        'เสร็จสิ้น',
        style: TextStyle(
            fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
      ),
      onPressed: () {
        Navigator.popAndPushNamed(context, '/home');
      },
    );
  }
}
