import 'package:flutter/material.dart';
import 'package:store_1/main.dart';
import 'package:store_1/setting.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:store_1/home.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  bool statusRedEye = true;
  final _formstate = GlobalKey<FormState>();
  String? email;
  String? password;
  final auth = FirebaseAuth.instance;
  TextEditingController username = TextEditingController();
  TextEditingController a = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue.shade100,
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 80),
              child: Form(
                key: _formstate,
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "SUEA STORE",
                        style: TextStyle(
                          color: Color.fromARGB(255, 0, 21, 39),
                          fontWeight: FontWeight.w500,
                          fontSize: 35,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: Image.asset(
                        'assets/logostore.png',
                        height: 239,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: emailTextFormField(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: passwordTextFormField(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              child: SizedBox(
                                height: 60, //height of button
                                width: 150, //width of button
                                child: loginButton(),
                              ),
                            ),
                            Container(
                              child: SizedBox(
                                height: 60, //height of button
                                width: 150, //width of button
                                child: registerButton(),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
            ),
          ],
        ));
  }

  ElevatedButton registerButton() {
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
        child: Text('ลงทะเบียน'),
        onPressed: () {
          Navigator.pushNamed(context, '/register');
        });
  }

  ElevatedButton loginButton() {
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
        child: Text('หน้าเข้าสู่ระบบ'),
        onPressed: () async {
          await btLogin_Click();
        });
  }

  Future<void> btLogin_Click() async {
    if (_formstate.currentState!.validate()) {
      print('Valid Form');

      _formstate.currentState!.save();

      try {
        print('Can login');
        await auth.signInWithEmailAndPassword(
            email: email!, password: password!);
        print('Login: ${auth.currentUser?.email} success');
        // Navigator.pushReplacementNamed(context, '/');
        Navigator.popAndPushNamed(context, '/home');
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          print('No user found for that email.');
          final snackBar = const SnackBar(
            content: Text('ไม่พบอีเมล กรุณาใส่ใหม่อีกครั้ง'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
          final snackBar = const SnackBar(
            content: Text('รหัสผ่านผิด กรุณาใส่ใหม่อีกครั้ง'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      }
    } else {
      print('Invalid Form');
      final snackBar = const SnackBar(
        content: Text('กรุณากรอกอีเมลและรหัสผ่านให้ถูกต้อง'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  TextFormField passwordTextFormField() {
    return TextFormField(
        obscureText: statusRedEye,
        onSaved: (value) {
          password = value!.trim();
        },
        validator: (value) {
          if (value!.length < 8)
            return 'รหัสผ่านจะต้องมีตัวอักษรอย่างน้อย 8 ตัว';
          else
            return null;
        },
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.lock),
          labelText: "รหัสผ่าน",
          enabledBorder: myinputborder(),
          focusedBorder: myfocusborder(),
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                statusRedEye = !statusRedEye;
              });
            },
            icon: statusRedEye
                ? Icon(
                    Icons.remove_red_eye,
                    color: Color.fromARGB(182, 55, 53, 53),
                  )
                : Icon(
                    Icons.remove_red_eye_outlined,
                    color: Colors.black,
                  ),
          ),
        ));
  }

  TextFormField emailTextFormField() {
    return TextFormField(
        onSaved: (value) {
          email = value!.trim();
        },
        decoration: InputDecoration(
          labelText: "ชื่อผู้ใช้",
          prefixIcon: Icon(Icons.people),
          border: myinputborder(),
          enabledBorder: myinputborder(),
          focusedBorder: myfocusborder(),
        ));
  }

  bool validateEmail(String value) {
    RegExp regex = RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

    return (!regex.hasMatch(value)) ? false : true;
  }

  OutlineInputBorder myinputborder() {
    //return type is OutlineInputBorder
    return OutlineInputBorder(
        //Outline border type for TextFeild
        borderRadius: BorderRadius.all(Radius.circular(20)),
        borderSide: BorderSide(
          color: Colors.black,
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
}
