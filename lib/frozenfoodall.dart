import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:store_1/freshfood.dart';
import 'package:flutter/material.dart';
import 'package:store_1/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:store_1/getFood.dart';

class Frozenfoodall extends StatefulWidget {
  const Frozenfoodall({Key? key}) : super(key: key);
  @override
  _Frozenfoodall createState() => _Frozenfoodall();
}

class _Frozenfoodall extends State<Frozenfoodall> {
  final List<String> menuCategories = [
    'frozenfood',
  ];
  final Map<String, List<Map<String, dynamic>>> menuItems = {
    'frozenfood': [
      {
        'name': 'ซาลาเปาหมูสับ',
        'price': 129,
        'imageURL':
            'https://cdn.discordapp.com/attachments/879605680561090570/1092120732349255710/2.1.png',
      },
      {
        'name': 'ซาลาเปาหมูสับไข่เค็ม',
        'price': 169,
        'imageURL':
            'https://cdn.discordapp.com/attachments/879605680561090570/1092120732877733938/1.1.png',
      },
      {
        'name': 'ไก่หมักซอส',
        'price': 139,
        'imageURL':
            'https://cdn.discordapp.com/attachments/879605680561090570/1092121043281379418/3.1.png',
      },
      {
        'name': 'แซลมอนแช่แข็ง',
        'price': 269,
        'imageURL':
            'https://cdn.discordapp.com/attachments/879605680561090570/1092122585254346762/4.1.jpg',
      },
      {
        'name': 'เนื้อปลาแช่แข็ง',
        'price': 139,
        'imageURL':
            'https://cdn.discordapp.com/attachments/879605680561090570/1092121043973439508/5.1.png',
      },
      {
        'name': 'กุ้งขาวแช่แข็ง',
        'price': 279,
        'imageURL':
            'https://cdn.discordapp.com/attachments/879605680561090570/1092121044434833478/6.1.png?width=300&height=300',
      },
    ],
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'เมนู',
      home: Scaffold(
        backgroundColor: Colors.blue.shade100,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            'อาหารแช่แข็ง',
            style: TextStyle(color: Colors.black),
          ),
          actions: <Widget>[
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/cart');
                },
                icon: const Icon(Icons.shopping_cart_outlined),
                color: Colors.black),
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/home');
                },
                icon: const Icon(Icons.home_filled),
                color: Colors.black),
          ],
        ),
        body: ListView.builder(
          itemCount: menuCategories.length,
          itemBuilder: (BuildContext context, int categoryIndex) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: menuItems[menuCategories[categoryIndex]]!
                      .map((menuItem) => Container(
                            child: ListTile(
                              leading: SizedBox(
                                  height: 100,
                                  width: 50,
                                  child: Image.network(menuItem['imageURL'])),
                              title: Text(menuItem['name']),
                              subtitle: Text('\฿ ${menuItem['price']}'),
                              onTap: () {},
                              trailing: IconButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => FrozenfoodallPage(
                                        menuItem: menuItem['name'],
                                        menuPrice: menuItem['price'],
                                        // ingredients: menuItem['ingredients'],
                                        imageURL: menuItem['imageURL'],
                                      ),
                                    ),
                                  );
                                },
                                icon: Icon(Icons.shopping_basket),
                                color: Color.fromARGB(255, 42, 38, 38),
                              ),
                            ),
                          ))
                      .toList(),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class FrozenfoodallPage extends StatelessWidget {
  final String menuItem;
  final int menuPrice;
  // final List<String> ingredients;
  final String imageURL;

  FrozenfoodallPage({
    required this.menuItem,
    required this.menuPrice,
    // required this.ingredients,
    required this.imageURL,
  });

  final GlobalKey<FormState> key = GlobalKey();
  final _form = GlobalKey<FormState>();
  final user = FirebaseAuth.instance.currentUser!;
  final store = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style =
        ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));

    return Scaffold(
        appBar: AppBar(
          title: Text(
            'รายละเอียดอาหาร',
            style: TextStyle(color: Colors.black),
          ),
        ),
        backgroundColor: Colors.blue.shade100,
        body: Form(
            key: _form,
            child: ListView(children: <Widget>[
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 15),
                ),
                Image.network(
                  imageURL,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    menuItem,
                    style: TextStyle(fontSize: 24),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    'Price: \฿ $menuPrice',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 50),
                ),
                Center(
                    child: ElevatedButton(
                  style: style,
                  child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.shopping_cart),
                        SizedBox(width: 12.0),
                        Text('เพิ่มลงตะกร้า'),
                      ]),
                  onPressed: () async {
                    if (_form.currentState!.validate()) {
                      print('save button press');

                      Map<String, dynamic> data = {
                        'title': menuItem,
                        'price': menuPrice,
                        'image': imageURL,
                      };

                      try {
                        DocumentReference ref =
                            await store.collection(user.email!).add(data);

                        print('save id = ${ref.id}');

                        Navigator.pop(context);
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Error $e'),
                          ),
                        );
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please validate value'),
                        ),
                      );
                    }
/*
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CartPage(),
                      ),
                    );*/
                  },
                ))
              ]),
            ])));
  }

  void setState(Null Function() param0) {}
}
