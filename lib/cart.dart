import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:store_1/getFood.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final store = FirebaseFirestore.instance;
  final user = FirebaseAuth.instance.currentUser!;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final _recipientController = TextEditingController();
  final _subjectController = TextEditingController();
  final _bodyController = TextEditingController();

  int money = 0;

  void showAlertDialog(BuildContext context) {
    AlertDialog alert = const AlertDialog(
        title: Text("สั่งออเดอร์ของคุณเรียบร้อยแล้ว"),
        content: Center(
          child: Text("กรุณาชำระเงิน"),
          heightFactor: 1,
        ));

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void _buildList() async {
    int sum = 0;

    final productsCollection =
        FirebaseFirestore.instance.collection(user.email!);

    await productsCollection.get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((doc) {
        int price = doc.get('price');

        sum += price;
      });

      //print('Total price: $sum');
    });

    setState(() {
      money = sum;
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: store.collection(user.email!).snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          return Scaffold(
              backgroundColor: Colors.blue.shade100,
              appBar: AppBar(
                title: const Text(
                  "รายการ",
                  style: TextStyle(color: Colors.black),
                ),
                actions: <Widget>[
                  IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/menu1');
                      },
                      icon: const Icon(Icons.menu_open),
                      color: Colors.black),
                  IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/home');
                      },
                      icon: const Icon(Icons.home_filled),
                      color: Colors.black),
                ],
              ),
              body: snapshot.hasData
                  ? buildFoodList(snapshot.data!)
                  : const Center(
                      child: CircularProgressIndicator(),
                    ),
              bottomNavigationBar: BottomAppBar(
                  shape: const CircularNotchedRectangle(),
                  child: Container(
                      height: 50.0,
                      child: ListTile(
                        title: Text('ราคาทั้งหมด: ' + money.toString()),
                        trailing: ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/paypal');
                            },
                            child: Text('จ่ายเงิน')),
                      ))));
        });
  }

  ListView buildFoodList(QuerySnapshot data) {
    return ListView.builder(
      itemCount: data.size,
      itemBuilder: (BuildContext context, int index) {
        var model = data.docs.elementAt(index);
        _buildList();
        return ListTile(
          leading: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(model['image']!),
                fit: BoxFit.cover,
              ),
            ),
            width: 60,
            height: 200,
          ),
          title: Text(model['t itle']),
          subtitle: Text('\฿ ' + model['price'].toString()),
          onTap: () {},
          trailing: IconButton(
            onPressed: () {
              print(model['title']);

              deleteValue(model.id);
            },
            icon: Icon(Icons.delete_outlined),
          ),
        );
      },
    );
  }

  Future<void> deleteValue(String titleName) async {
    await _firestore
        .collection(user.email!)
        .doc(titleName)
        .delete()
        .catchError((e) {
      print(e);
    });
  }
}
