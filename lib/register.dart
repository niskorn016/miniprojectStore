import 'package:store_1/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formstate = GlobalKey<FormState>();
  TextEditingController username = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController password1 = TextEditingController();
  TextEditingController password2 = TextEditingController();

  final auth = FirebaseAuth.instance;
  final FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue.shade100,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.popAndPushNamed(context, '/');
            },
          ),
          title: Text("ลงทะเบียน", style: GoogleFonts.kanit()),
          backgroundColor: Color.fromARGB(255, 12, 146, 255),
        ),
        body:
            // Form(
            // key: _formstate,
            // child: ListView(
            //   children: <Widget>[
            //     buildUserField(),
            //     buildPhoneField(),
            //     buildEmailField(),
            //     buildPasswordField(),
            //     buildConfirmPasswordFieldSame(),
            //     buildRegisterButton(),
            //   ],
            // ),
            // )
            ListView(
          children: [
            Form(
                key: _formstate,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: buildUserField(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: buildPhoneField(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: buildEmailField(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: buildPasswordField(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: buildConfirmPasswordFieldSame(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                child: SizedBox(
                                  height: 60, //height of button
                                  width: 150, //width of button
                                  child: buildRegisterButton(),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ))
          ],
        ));
  }

  ElevatedButton buildRegisterButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          primary: Colors.blueAccent, //background color of button
          side: BorderSide(
              width: 3, color: Colors.black), //border width and color
          elevation: 3, //elevation of button
          shape: RoundedRectangleBorder(
              //to set border radius to button
              borderRadius: BorderRadius.circular(30)),
          padding: EdgeInsets.all(20) //content padding inside button
          ),
      child: const Text('ลงทะเบียน'),
      onPressed: () async {
        if (password1.text.trim() == password2.text.trim())
          password = password1;
        print('สร้างบัญชีผู้ใช้ใหม่');
        if (_formstate.currentState!.validate()) print(email.text);
        print(password.text);
        final _user = await auth.createUserWithEmailAndPassword(
            email: email.text.trim(), password: password.text.trim());
        _user.user!.sendEmailVerification();
        Navigator.pushNamed(context, '/');
        if (_formstate.currentState!.validate()) {
          print(email.text);
          print(password.text);

          //กำหนดข้อมูลที่ต้องการเพิ่มลง Firestore
          Map<String, String> data = {
            'email': email.text.trim(),
            'name': username.text.trim(),
            'phone': phone.text.trim(),
            'profile': ''
          };

          //เพิ่มข้อมูล ลง Firestore ใน Collection users
          db.collection('users').doc(email.text.trim().toString()).set(data);
          //  final _user = await auth.createUserWithEmailAndPassword(
          //   email: email.text.trim(), password: password.text.trim());
          //   _user.user!.sendEmailVerification();
          //   Navigator.pushNamed(context, '/');
          // try {
          //   final _user =
          //       await FirebaseAuth.instance.createUserWithEmailAndPassword(
          //     email: email.text.trim(),
          //     password: password.text.trim(),
          //   );
          //   Navigator.popAndPushNamed(context, '/');
          // } on FirebaseAuthException catch (e) {
          //   if (e.code == 'weak-password') {
          //     print('The password providede is too weak');
          //   } else if (e.code == 'email-already-in-use') {
          //     print('The account already exists for that email');
          //   }
          // } catch (e) {
          //   print(e);
          // }
        }
      },
    );
  }

  TextFormField buildUserField() {
    return TextFormField(
      controller: username,

      // obscureText: true,
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(
        labelText: 'ชื่อผู้ใช้',
        icon: Icon(Icons.people),
      ),
    );
  }

  TextFormField buildPhoneField() {
    return TextFormField(
      controller: phone,
      // obscureText: true,
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(
        labelText: 'เบอร์โทรศัพท์',
        icon: Icon(Icons.phone),
      ),
    );
  }

  TextFormField buildPasswordField() {
    return TextFormField(
      controller: password1,
      validator: (value) {
        if (value!.length < 8)
          return 'กรุณากรอกรหัสผ่านอย่างน้อย 8 ตัวอักษร';
        else if (password1.text.trim() != password2.text.trim())
          return 'รหัสผ่านไม่เหมือนกัน!';
        else
          return null;
      },
      obscureText: true,
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(
        labelText: 'รหัสผ่าน',
        icon: Icon(Icons.lock),
      ),
    );
  }

  TextFormField buildConfirmPasswordFieldSame() {
    return TextFormField(
      controller: password2,
      validator: (value) {
        if (value!.length < 8)
          return 'กรุณากรอกรหัสผ่านอย่างน้อย 8 ตัวอักษร';
        else if (password1.text.trim() != password2.text.trim())
          return 'รหัสผ่านไม่เหมือนกัน!';
        else
          return null;
      },
      obscureText: true,
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(
        labelText: 'ยืนยันรหัสผ่าน',
        icon: Icon(Icons.lock),
      ),
    );
  }

  TextFormField buildEmailField() {
    return TextFormField(
      controller: email,
      validator: (value) {
        if (value!.isEmpty)
          return 'กรุณากรอกอีเมล';
        else
          return null;
      },
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      decoration: const InputDecoration(
        labelText: 'อีเมล',
        icon: Icon(Icons.email),
        hintText: 'xyz@mail.com',
      ),
    );
  }
}
