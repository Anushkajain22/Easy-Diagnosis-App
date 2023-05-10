// import 'dart:js';

import 'package:flutter/material.dart';
import 'package:self_login/dpchoice.dart';
import 'package:self_login/hdcchoice.dart';
import 'package:self_login/home.dart';
import 'package:self_login/hospitalist1.dart';
import 'package:self_login/hospitalist2.dart';
import 'package:self_login/otp.dart';
import 'package:self_login/home.dart';
import 'package:self_login/phone.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: 'HospitalList',
    routes: {
      'phone': (context) => MyPhone(),
      'otp': (context) => MyOtp(),
      'home': (context) => MyHome(),
      'Choice': (context) => Choice(),
      'hdChoice': (context) => hdChoice(),
      'HospitalistDetails': (context) => HospitalistDetails(),
      'HospitalList': (context) => HospitalList(),
    },
  ));
}
