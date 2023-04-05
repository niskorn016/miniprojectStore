import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

class getName extends StatelessWidget {
  final String documentID;

  getName({required this.documentID});

  CollectionReference foods = FirebaseFirestore.instance.collection('foods');
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
        future: foods.doc(documentID).get(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            print('data -> ');
            print(data);
            return Text('${data['name']}');
          }
          return Text('Loading...');
        }));
  }
}

class getPrice extends StatelessWidget {
  final String documentID;

  getPrice({required this.documentID});

  CollectionReference foods = FirebaseFirestore.instance.collection('foods');
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
        future: foods.doc(documentID).get(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            return Text('${data['price']}');
          }
          return Text('Loading...');
        }));
  }
}

class getType extends StatelessWidget {
  final String documentID;

  getType({required this.documentID});

  CollectionReference foods = FirebaseFirestore.instance.collection('foods');
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
        future: foods.doc(documentID).get(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            return Text('${data['type']}');
          }
          return Text('Loading...');
        }));
  }
}

class getPicture extends StatelessWidget {
  final String documentID;

  getPicture({required this.documentID});

  CollectionReference foods = FirebaseFirestore.instance.collection('foods');
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
        future: foods.doc(documentID).get(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            return Image.network(
              data['image'],
              fit: BoxFit.fill,
              width: 100,
              height: 200,
            );
          }
          return Text('Loading...');
        }));
  }
}
