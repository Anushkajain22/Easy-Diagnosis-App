import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:neumorphic_button/neumorphic_button.dart';
import 'package:self_login/hospital_info.dart/review_system/hospitalist2.dart';

// import 'hospitalist2.dart';

// import 'hospitalist2.dart';

class HospitalistDetails extends StatefulWidget {
  const HospitalistDetails({super.key});

  @override
  State<HospitalistDetails> createState() => _HospitalistDetailsState();
}

class _HospitalistDetailsState extends State<HospitalistDetails> {
  final geolocator =
      Geolocator.getCurrentPosition(forceAndroidLocationManager: true);
  Position? _currentPosition;
  String currentaddress = "";
  void getCurrentLocation() {
    Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });
      getAddressFromLatLng();
    }).catchError((e) {
      print(e);
    });
  }

  void getAddressFromLatLng() async {
    try {
      List<Placemark> p = await placemarkFromCoordinates(
          _currentPosition!.latitude, _currentPosition!.longitude);
      Placemark place = p[0];
      setState(() {
        currentaddress = "${place.street},${place.name},${place.country}";
      });
    } catch (e) {
      print(e);
    }
  }

  TextEditingController sampledata1 = new TextEditingController();
  TextEditingController sampledata2 = new TextEditingController();
  TextEditingController sampledata3 = new TextEditingController();
  TextEditingController sampledata4 = new TextEditingController();
  TextEditingController sampledata5 = new TextEditingController();
  TextEditingController sampledata6 = new TextEditingController();
  TextEditingController sampledata7 = new TextEditingController();
  TextEditingController sampledata8 = new TextEditingController();
  TextEditingController sampledata9 = new TextEditingController();
  TextEditingController sampledata10 = new TextEditingController();
  TextEditingController sampledata11 = new TextEditingController();
  TextEditingController sampledata12 = new TextEditingController();
  TextEditingController sampledata13 = new TextEditingController();
  TextEditingController sampledata14 = new TextEditingController();

  static final RegExp nameRegExp = RegExp('[a-zA-Z]');
  final formkey = GlobalKey<FormState>();
  String name = "";
  // String email = "";
  // String location = "";
  // String details = "";

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;

    final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: Color(0xFFffffff),
      body: Container(
        padding: EdgeInsets.only(left: 40, right: 40),
        child: SingleChildScrollView(
          child: Form(
              key: formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: height * 0.04,
                  ),
                  Text(
                    'How to Get',
                    style: TextStyle(fontSize: 30, color: Color(0xFF363f93)),
                  ),
                  Text(
                    'Welcomed !',
                    style: TextStyle(fontSize: 30, color: Color(0xFF363f93)),
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  TextFormField(
                    controller: sampledata1,
                    decoration: InputDecoration(labelText: "Hospital name"),
                    validator: ((value) {
                      if (value!.isEmpty ||
                          !RegExp(r'^[a-z A-Z]+$').hasMatch(value!)) {
                        return "Enter correct name";
                      } else {
                        return null;
                      }
                    }),
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  TextFormField(
                    controller: sampledata2,
                    decoration: InputDecoration(labelText: "Phone no"),
                    validator: ((value) {
                      if (value!.isEmpty ||
                          !RegExp(r'^(?:[+0]9)?[0-9]{10}$').hasMatch(value!)) {
                        return "Enter correct phone no";
                      } else {
                        return null;
                      }
                    }),
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  TextFormField(
                    controller: sampledata3,
                    decoration: InputDecoration(labelText: "email"),
                    validator: ((value) {
                      if (value!.isEmpty ||
                          !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value!)) {
                        return "Enter correct Contact info";
                      } else {
                        return null;
                      }
                    }),
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),

                  TextButton(
                    onPressed: getCurrentLocation,
                    child: Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: Colors.black54,
                        ),
                        Text(
                          ' Current location',
                          style: TextStyle(fontSize: 19, color: Colors.black54),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 100,
                  ),
                  if (_currentPosition != null && currentaddress != null)
                    Text(currentaddress)
                  else
                    Text('No location track'),

                  // TextFormField(
                  //   controller: sampledata4,
                  //   decoration: InputDecoration(labelText: "Location"),
                  //   validator: ((value) {
                  //     if (value!.isEmpty
                  //         // ||
                  //         //     !RegExp(r'^[a-z A-Z]+$').hasMatch(value!)
                  //         ) {
                  //       return "Enter correct Location";
                  //     } else {
                  //       return null;
                  //     }
                  //   }),
                  // ),
                  SizedBox(
                    width: 100,
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  TextFormField(
                    controller: sampledata5,
                    decoration:
                        InputDecoration(labelText: "Details about Hospital"),
                    validator: ((value) {
                      if (value!.isEmpty
                          // !RegExp(r'^[a-z A-Z]+$').hasMatch(value!)
                          ) {
                        return "Enter correct details";
                      } else {
                        return null;
                      }
                    }),
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  Text(
                    'Dr.',
                    style: TextStyle(fontSize: 30, color: Color(0xFF363f93)),
                  ),
                  Text(
                    'Details !',
                    style: TextStyle(fontSize: 30, color: Color(0xFF363f93)),
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  TextFormField(
                    controller: sampledata6,
                    decoration: InputDecoration(labelText: "Package1"),
                    validator: ((value) {
                      if (value!.isEmpty) {
                        // !RegExp(r'^[a-z A-Z]+$').hasMatch(value!)) {
                        return "Enter correct details please";
                      } else {
                        return null;
                      }
                    }),
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  TextFormField(
                    controller: sampledata7,
                    decoration: InputDecoration(labelText: "estimated cost1"),
                    validator: ((value) {
                      // if (value!.isEmpty) {
                      //   // !RegExp(r'^[a-z A-Z]+$').hasMatch(value!)) {
                      //   return "Enter correct details please";
                      // } else {
                      //   return null;
                      // }
                    }),
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  TextFormField(
                    controller: sampledata8,
                    decoration: InputDecoration(labelText: "Package2"),
                    validator: ((value) {
                      // if (value!.isEmpty) {
                      //   // !RegExp(r'^[a-z A-Z]+$').hasMatch(value!)) {
                      //   return "Enter correct details please";
                      // } else {
                      //   return null;
                      // }
                    }),
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  TextFormField(
                    controller: sampledata9,
                    decoration: InputDecoration(labelText: "estimated cost2"),
                    validator: ((value) {
                      // if (value!.isEmpty) {
                      //   // !RegExp(r'^[a-z A-Z]+$').hasMatch(value!)) {
                      //   return "Enter correct details please";
                      // } else {
                      //   return null;
                      // }
                    }),
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  TextFormField(
                    controller: sampledata10,
                    decoration: InputDecoration(labelText: "Package3"),
                    validator: ((value) {
                      // if (value!.isEmpty) {
                      //   // !RegExp(r'^[a-z A-Z]+$').hasMatch(value!)) {
                      //   return "Enter correct details please";
                      // } else {
                      //   return null;
                      // }
                    }),
                  ),
                  TextFormField(
                    controller: sampledata11,
                    decoration: InputDecoration(labelText: "estimated cost3"),
                    validator: ((value) {
                      // if (value!.isEmpty) {
                      //   // !RegExp(r'^[a-z A-Z]+$').hasMatch(value!)) {
                      //   return "Enter correct details please";
                      // } else {
                      //   return null;
                      // }
                    }),
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  // SizedBox(
                  //   height: height * 0.05,
                  // ),
                  // TextFormField(
                  //   controller: sampledata11,
                  //   decoration:
                  //       InputDecoration(labelText: "sixth Doctor Details"),
                  //   validator: ((value) {
                  //     // if (value!.isEmpty) {
                  //     //   // !RegExp(r'^[a-z A-Z]+$').hasMatch(value!)) {
                  //     //   return "Enter correct details please";
                  //     // } else {
                  //     //   return null;
                  //     // }
                  //   }),
                  // ),
                  // SizedBox(
                  //   height: height * 0.05,
                  // ),
                  // TextFormField(
                  //   controller: sampledata12,
                  //   decoration:
                  //       InputDecoration(labelText: "seventh Doctor Details"),
                  //   validator: ((value) {
                  //     // if (value!.isEmpty) {
                  //     //   // !RegExp(r'^[a-z A-Z]+$').hasMatch(value!)) {
                  //     //   return "Enter correct details please";
                  //     // } else {
                  //     //   return null;
                  //     // }
                  //   }),
                  // ),
                  // SizedBox(
                  //   height: height * 0.05,
                  // ),
                  // TextFormField(
                  //   controller: sampledata13,
                  //   decoration:
                  //       InputDecoration(labelText: "Eighth Doctor Details"),
                  //   validator: ((value) {
                  //     // if (value!.isEmpty) {
                  //     //   // !RegExp(r'^[a-z A-Z]+$').hasMatch(value!)) {
                  //     //   return "Enter correct details please";
                  //     // } else {
                  //     //   return null;
                  //     // }
                  //   }),
                  // ),
                  // SizedBox(
                  //   height: height * 0.05,
                  // ),
                  Row(
                    children: [
                      SizedBox(
                        height: 120,
                      ),
                      FloatingActionButton.extended(
                        backgroundColor: Color(0xFF363f93),
                        onPressed: () {
                          if (formkey.currentState!.validate()) {
                            Map<String, dynamic> data = {
                              "Hospital name": sampledata1.text,
                              "Phone no": sampledata2.text,
                              "email": sampledata3.text,
                              "Location": sampledata4.text,

                              "Hospital Details": sampledata5.text,
                              "Package1": sampledata6.text,
                              "estimated cost1": sampledata7.text,
                              "Package2": sampledata8.text,
                              "estimated cost2": sampledata9.text,
                              "Package3": sampledata10.text,
                              "estimated cost3": sampledata11.text,

                              // "Package5": sampledata10.text,

                              // "7. Second Doctor Details": sampledata7.text,
                              // "8. Third Doctor Details": sampledata8.text,
                              // "9. Fourth Doctor Details": sampledata9.text,
                              // "9.1 Fifth Dr Details": sampledata10.text,
                              // "9.2 sixth Dr Details": sampledata11.text,
                              // "9.3. seventh Dr Details": sampledata12.text,
                              // "9.4. Eighth Doctor Details": sampledata8.text,

                              // FirebaseFirestore.
                            };
                            // sampledata1.clear();
                            // sampledata2.clear();
                            // sampledata3.clear();
                            // sampledata4.clear();

                            FirebaseFirestore.instance
                                .collection("test")
                                .add(data);

// 5:05

                            // onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HospitalList(),
                              ),
                            );
                          } else {
                            return null;
                          }
                        },
                        label:
                            // Icon(Icons.arrow_forward),h
                            Text(
                          'Next',
                          // style: TextStyle(fontSize: 21),
                        ),
                        //
                      ),

                      // )

                      // NeumorphicButton(
                      //   width: 20,
                      //   height: 20,
                      //   backgroundColor: Colors.purple,
                      //   onTap: (() {
                      //     if (formkey.currentState!.validate()) {
                      //       final snackBar = SnackBar(content: Text('nkj'));
                      //     }
                      //   }),
                      //   child: Icon(),boxShape: Neumo,
                      // )
                    ],
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
