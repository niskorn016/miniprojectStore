import 'package:flutter/material.dart';
import 'dart:io';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:store_1/main.dart';
import 'package:store_1/profile.dart';

class MyEditProfile extends StatefulWidget {
  const MyEditProfile(
      {super.key,
      required this.username,
      required this.phone,
      required this.profile});
  final String username;
  final String phone;
  final String profile;

  @override
  _MyEditProfileState createState() => _MyEditProfileState();
}

class _MyEditProfileState extends State<MyEditProfile> {
  final _formstate = GlobalKey<FormState>();

  final auth = FirebaseAuth.instance;

  final FirebaseFirestore db = FirebaseFirestore.instance;

  final storage = FirebaseStorage.instance;
  final storageRef = FirebaseStorage.instance.ref();

  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  String? _imageUrl;

  @override
  Widget build(BuildContext context) {
    TextEditingController fname = TextEditingController(text: widget.username);
    TextEditingController phone = TextEditingController(text: widget.phone);
    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.popAndPushNamed(context, '/proflie');
          },
        ),
        title: Text(
          "แก้ไขโปรไฟล์",
          style: GoogleFonts.kanit(),
          selectionColor: Colors.black,
        ),
        backgroundColor: Color.fromARGB(255, 12, 146, 255),
      ),
      body: ListView(
        children: <Widget>[
          Form(
            key: _formstate,
            child: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: imageProfile(),
                  ),
                  TextFormField(
                      controller: fname,
                      decoration: InputDecoration(
                        labelText: "ชื่อ",
                        prefixIcon: Icon(Icons.people),
                        border: myinputborder(),
                        enabledBorder: myinputborder(),
                        focusedBorder: myfocusborder(),
                      )),
                  Container(height: 20),
                  TextFormField(
                    controller: phone,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.phone),
                      labelText: "โทรศัพท์",
                      enabledBorder: myinputborder(),
                      focusedBorder: myfocusborder(),
                    ),
                  ),
                  Container(height: 20),
                  Container(
                    // height: 20,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 50,
                        width: 150,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                            ),
                            backgroundColor: MaterialStatePropertyAll<Color>(
                                Color.fromARGB(255, 12, 146, 255)),
                          ),
                          onPressed: () {
                            String? _imgUrl;
                            uploadImageProfile().then((value) {
                              _imgUrl = value;
                              print('_imgUrl:::: ${_imgUrl.toString()}');
                              if (_imgUrl == '') {
                                _imgUrl = widget.profile;
                              }
                              final users = db
                                  .collection('users')
                                  .doc(auth.currentUser?.email);

                              users
                                  .update({
                                    'name': fname.text.trim(),
                                    'phone': phone.text.trim(),
                                    'profile': _imgUrl.toString()
                                  })
                                  .then((value) => print('อัปเดตผู้เข้าใช้'))
                                  .catchError(
                                    (error) => print(
                                        'Failed to update user: ${error}'),
                                  );

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MyShowProfilePage(
                                            title: 'โปรไฟล์',
                                          )));
                            });
                          },
                          child: Text(
                            "ยืนยันการแก้ไข",
                            style: GoogleFonts.kanit(
                                color: Colors.black, fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget imageProfile() {
    return Stack(
      children: [
        CircleAvatar(
          radius: 90,
          backgroundImage: _imageFile == null
              ? NetworkImage(widget.profile)
              : FileImage(File(_imageFile!.path)) as ImageProvider,
        ),
        Positioned(
          bottom: 10,
          right: 10,
          child: InkWell(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: ((builder) => bottomSheet()),
              );
            },
            child: Icon(
              Icons.camera_alt,
              color: Color.fromARGB(255, 0, 0, 0),
              size: 28,
            ),
          ),
        )
      ],
    );
  }

  OutlineInputBorder myinputborder() {
    //return type is OutlineInputBorder
    return OutlineInputBorder(
        //Outline border type for TextFeild
        borderRadius: BorderRadius.all(Radius.circular(20)),
        borderSide: BorderSide(
          color: Colors.redAccent,
          width: 3,
        ));
  }

  OutlineInputBorder myfocusborder() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        borderSide: BorderSide(
          color: Colors.greenAccent,
          width: 3,
        ));
  }

  //create a function like this so that you can use it wherever you want
  Widget bottomSheet() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: [
          Text(
            'เลือกรูปโปรไฟล์',
            style: TextStyle(fontSize: 20.0),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton.icon(
                onPressed: () {
                  takePhoto(ImageSource.camera);
                },
                icon: Icon(Icons.camera),
                label: Text('กล้อง'),
              ),
              TextButton.icon(
                onPressed: () {
                  takePhoto(ImageSource.gallery);
                },
                icon: Icon(Icons.image),
                label: Text('อัลบั้ม'),
              )
            ],
          )
        ],
      ),
    );
  }

  void takePhoto(ImageSource source) async {
    final pickedFile =
        await ImagePicker().pickImage(source: source, imageQuality: 100);

    setState(() {
      _imageFile = File(pickedFile!.path);
    });

    print('imageFile path: ${_imageFile?.path}');
    print('imageFile : ${_imageFile}');
  }

  Future<String> uploadImageProfile() async {
    //Storage Image Upload
    if (_imageFile == null) {
      return "";
    } else {
      Reference ref = FirebaseStorage.instance
          .ref()
          .child('${auth.currentUser?.email}-profile.jpg');
      await ref.putFile(File(_imageFile!.path));
      final imgUrl = await ref.getDownloadURL().then((value) {
        print('value : ${value}');
        _imageUrl = value;
        print('imageUrl${_imageUrl}');
        return value;
      });
      print('imgUrl: ${imgUrl}');
      return imgUrl;
    }
  }
}
