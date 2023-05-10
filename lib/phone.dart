import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:self_login/home.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';

class MyPhone extends StatefulWidget {
  const MyPhone({super.key});
  static String verify = "";

  @override
  State<MyPhone> createState() => MyPhoneState();
}

class MyPhoneState extends State<MyPhone> {
  TextEditingController countrycode = TextEditingController();
  var phone = "";
  googleLogin() async {
    print("googleLogin method Called");
    GoogleSignIn _googleSignIn = GoogleSignIn();
    try {
      var reslut = await _googleSignIn.signIn();
      if (reslut == null) {
        return;
      }

      final userData = await reslut.authentication;
      final credential = GoogleAuthProvider.credential(
          accessToken: userData.accessToken, idToken: userData.idToken);
      var finalResult =
          await FirebaseAuth.instance.signInWithCredential(credential);
      print("Result $reslut");
      print(reslut.displayName);
      print(reslut.email);
      print(reslut.photoUrl);
    } catch (error) {
      print(error);
    }
  }

  Future<void> logout() async {
    await GoogleSignIn().disconnect();
    FirebaseAuth.instance.signOut();
  }

  @override
  void initState() {
    // TODO: implement initState
    countrycode.text = "+91";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                'https://www.kimshealth.org/media/filer_public/1a/bb/1abbb983-e33b-43f0-803f-44406d8b19e3/untitled_design_30.png',

                // height: 150,
                // width: 150,
              ),
              SizedBox(
                height: 25,
              ),
              Text(
                'Phone Verification',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'You need to register your phone before get started !',
                style: TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 38,
              ),
              Container(
                height: 55,
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 40,
                      child: TextField(
                        controller: countrycode,
                        decoration: InputDecoration(border: InputBorder.none),
                      ),
                    ),
                    Text(
                      "|",
                      style: TextStyle(color: Colors.grey, fontSize: 33),
                    ),
                    Expanded(
                        child: TextField(
                      keyboardType: TextInputType.phone,
                      onChanged: (value) {
                        phone = value;
                      },
                      decoration: InputDecoration(
                          border: InputBorder.none, hintText: "Phone"),
                    ))
                  ],
                ),
              ),
              SizedBox(height: 25),
              SizedBox(
                height: 45,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    await FirebaseAuth.instance.verifyPhoneNumber(
                      phoneNumber: '${countrycode.text + phone}',
                      verificationCompleted:
                          (PhoneAuthCredential credential) {},
                      verificationFailed: (FirebaseAuthException e) {},
                      codeSent: (String verificationId, int? resendToken) {
                        MyPhone.verify = verificationId;
                        Navigator.pushNamed(context, "otp");
                      },
                      codeAutoRetrievalTimeout: (String verificationId) {},
                    );
                    // Navigator.pushNamed(context, "otp");
                  },
                  child: Text('Send the code'),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.pinkAccent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Text(
                "or",
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(
                height: 12,
              ),
              Container(
                  // height:5
                  // color: Colors.yellow,
                  child: Container(
                height: 43,
                width: double.infinity,
                // color: Colors.pink,

                child: ElevatedButton(
                  onPressed: () {
                    googleLogin();
                    Navigator.pushNamed(context, "Choice");
                  },
                  child: Row(mainAxisAlignment: MainAxisAlignment.center,
                      //
                      // mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          // color: Colors.yellow,

                          child: (Image.network(
                            'https://static.vecteezy.com/system/resources/previews/009/469/630/original/google-logo-isolated-editorial-icon-free-vector.jpg',
                            fit: BoxFit.cover,
                            scale: 15,
                          )),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Sign in using google",
                          style: TextStyle(color: Colors.red),
                        )
                      ]),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
              )),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        logout();
                      },
                      child: Text("logout"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
