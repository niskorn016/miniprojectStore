// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:store_1/main.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class Search extends StatefulWidget {
//   @override
//   State<Search> createState() => _SearchState();
// }

// class _SearchState extends State<Search> {
//   String name = "";
//   List<Map<String, dynamic>> data = [];
//   List<String> shopDocListID = [];

//   addData() async {
//     for (var element in data) {
//       FirebaseFirestore.instance.collection('foods').add(element);
//     }
//     print('all data added');
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     addData();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//             leading: IconButton(
//                 onPressed: () {
//                   Navigator.pushNamed(context, '/home');
//                 },
//                 icon: Icon(Icons.arrow_back)),
//             title: Card(
//               child: TextField(
//                 decoration: InputDecoration(
//                     prefixIcon: Icon(Icons.search), hintText: 'ค้นหา...'),
//                 onChanged: (val) {
//                   setState(() {
//                     name = val;
//                   });
//                 },
                
//               ),
//             )),
            
//         body: StreamBuilder<QuerySnapshot>(
//           stream: FirebaseFirestore.instance.collection('foods').snapshots(),
//           builder: (context, snapshots) {
//             return (snapshots.connectionState == ConnectionState.waiting)
//                 ? Center(
//                     child: CircularProgressIndicator(),
//                   )
                  
//                 : ListView.builder(
//                     itemCount: snapshots.data!.docs.length,
//                     itemBuilder: (context, index) {
//                       var data = snapshots.data!.docs[index].data()
//                           as Map<String, dynamic>;
//                       var data2 = snapshots.data?.docs.forEach((element) {
//                         shopDocListID.add(element.reference.id);
//                       });
//                       if (name.isEmpty) {
//                         return ListTile(
//                           title: Text(
//                             data['name'],
//                             maxLines: 1,
//                             overflow: TextOverflow.ellipsis,
//                             style: TextStyle(
//                                 color: Colors.black54,
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                           leading: CircleAvatar(
//                             backgroundImage: NetworkImage(data['image']),
//                           ),
//                         );
//                       }
//                       if (data['name']
//                           .toString()
//                           .toLowerCase()
//                           .startsWith(name.toLowerCase())) {
//                         return Card(
//                           child: ListTile(
//                             onTap: () {
//                               // Navigator.pushNamed(context, '/foodlist');
//                               print(index);
//                               print(data);
//                               print('data name : ${data['name']}');
//                               print(shopDocListID);
//                               // Navigator.push(
//                               //   context,
//                               //   MaterialPageRoute(
//                               //     builder: (context) => ShopOwnDetailPage(
//                               //       todo: index,
//                               //       listID: shopDocListID,
//                               //     ),
//                               //   ),
//                               // );
//                             },
//                             title: Text(
//                               data['name'],
//                               maxLines: 1,
//                               overflow: TextOverflow.ellipsis,
//                               style: TextStyle(
//                                   color: Colors.black54,
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.bold),
//                             ),
//                             leading: CircleAvatar(
//                               backgroundImage: NetworkImage(data['image']),
//                             ),
//                           ),
//                         );
//                       }
//                       return Container();
//                     }
//                     );
                    
//           },
//         ));
//   }
// }

// class BodyLayout extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return _myListView(context);
//   }
// }

// Widget _myListView(BuildContext context) {
//   return ListView.builder(
//     itemCount: 50,
//     itemBuilder: (context, index) {
//       return Container(
//         margin: EdgeInsets.all(10),
//         padding: EdgeInsets.all(10),
//         decoration: BoxDecoration(
//           color: Color(0xFF94CCF9),
//           border: Border.all(
//             color: Color(0xFF04589A),
//             width: 4,
//           ),
//           borderRadius: BorderRadius.circular(10.0),
//         ),
//         child: Card(
//           child: ListTile(
//             onTap: () {
//               /////
//             },
//             title: Text('row$index'),
//           ),
//         ),
//       );
//     },
//   );
// }
