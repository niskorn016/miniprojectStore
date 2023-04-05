import 'package:flutter/material.dart';
import 'package:store_1/freshfood.dart';
import 'package:store_1/freshfoodall.dart';
import 'package:store_1/menu1.dart';
import 'package:store_1/frozenfood.dart';
import 'package:store_1/frozenfoodall.dart';
import 'package:store_1/cart.dart';
import 'package:store_1/paypal.dart';
// import 'package:store_1/search.dart';
import 'package:store_1/home.dart';
import 'package:store_1/profile.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:store_1/login.dart';
import 'package:store_1/register.dart';
import 'package:store_1/setting.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)
            .copyWith(background: Colors.blue),
      ),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginPage(),
        '/menu1': (context) => const FMenu(),
        '/freshfood': (context) => const Freshfood(),
        '/freshfoodall': (context) => const Freshfoodall(),
        '/frozenfood': (context) => const Frozenfood(),
        '/frozenfoodall': (context) => const Frozenfoodall(),
        '/cart': (context) => const CartPage(),
        '/home': (context) => const MyHomePage(),
        '/profile': (context) => const MyShowProfilePage(
              title: 'Profile',
            ),
        '/register': (context) => const RegisterPage(),
        '/paypal': (context) => PaypalPage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  int _counter = 0;
  int currentIndex = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _children = [
    const Home(),
    // Search(),
    const CartPage(),
    MyShowProfilePage(
      title: 'โปรไฟล์',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      body: _children[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: _onItemTapped,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "หน้าหลัก",
            backgroundColor: Colors.blue,
          ),
          // const BottomNavigationBarItem(
          //   icon: Icon(Icons.search),
          //   label: "search",
          //   backgroundColor: Colors.blue,
          // ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            label: "ตะกร้า",
            backgroundColor: Colors.blue,
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: "โปรไฟล์",
            backgroundColor: Colors.blue,
          ),
        ],
      ),
    );
  }
}
