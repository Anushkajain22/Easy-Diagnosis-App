import 'package:flutter/material.dart';

import 'package:self_login/homepage.dart';
import 'package:self_login/evaluation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:self_login/profile main.dart';
import 'package:self_login/profile_page.dart';
import 'package:self_login/evaluation.dart';
import 'package:self_login/health package.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:self_login/home.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:self_login/Dr_info.dart';
import 'package:self_login/health package.dart';

// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:self_login/profile_page.dart';
// import 'package:self_login/evaluation.dart';
// import 'package:self_login/health package.dart';
// import 'package:self_login/Dr_info.dart';

//  void main() => runApp(ProfilePage());
class ProfilePage extends StatelessWidget {
  final String name;
  final int age;
  final String gender;
  final String paymentHistory;
  // final String upcomingAppointment;
  // final String testReports;
  // final String prescriptions;
  // final String logout;

  final String contactInfo;
  final String address;

  ProfilePage({
    required this.name,
    required this.age,
    required this.gender,
    required this.paymentHistory,
    // required this.upcomingAppointment,
    // required this.testReports,
    // required this.prescriptions,
    // required this.logout,

    required this.contactInfo,
    required this.address,
  });

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Profile',style:TextStyle(color: Colors.black),),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(16),
            child: CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/my2.jpg'),
            ),
          ),
          SizedBox(height: 16),
          // L

          ListTile(
            leading: Icon(Icons.person),
            title: Text(name),
            subtitle: Text('Age: $age Gender: $gender'),
          ),
          ListTile(
            leading: Icon(Icons.history),
            title: Text('Payment History'),
            subtitle: Text(paymentHistory),
          ),
          // ListTile(
          //   leading: Icon(Icons.calendar_today),
          //   title: Text('Upcoming Appointment'),
          //   subtitle: Text(upcomingAppointment),
          // // ),
          // ListTile(
          //   leading: Icon(Icons.receipt),
          //   title: Text('Test Reports'),
          //   subtitle: Text(testReports),
          // ),
          // // ListTile(
          // //   leading: Icon(Icons.local_pharmacy),
          // //   title: Text('Prescriptions'),
          // //   subtitle: Text(prescriptions),
          // // ),
          // ListTile(
          //   leading: Icon(Icons.favorite),
          //   title: Text('Vital Signs'),
          //   subtitle: Text(vitalSigns),
          // ),

          ListTile(
            leading: Icon(Icons.contact_mail),
            title: Text('Contact Information'),
            subtitle: Text(contactInfo),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Address'),
            subtitle: Text(address),
          ),
          SizedBox(height: 45,),
          Container(
              color: Colors.lightBlue,
            height: 43,width: 128,
            child:Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [ TextButton(
                onPressed: (){logout();
                Navigator.pushNamed(context, "phone");
                },
                child: Text("Sign out",style: TextStyle(color: Colors.white),),
              ) ,],
            ),
          ),

        ],

      ),



      bottomNavigationBar: BottomAppBar(
        elevation: 20,
        color: Colors.white,
        child: Container(
          height: MediaQuery.of(context).size.height * 0.08,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                children: [

                  IconButton(
                    icon: Icon(Icons.home),

                    iconSize: 29,
                    color: Colors.grey,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>HomePage(),),);
                    },

                  ),
                  Text("Home", style: TextStyle(color: Colors.black54),)

                ],
                // icon: Icon(Icons.home),
              ),
              Column(

                  children: [
                    // color:Colors.white;

                    IconButton(
                      icon: Icon(Icons.medical_services_outlined),
                      iconSize: 29,
                      color: Colors.black54,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>HealthMonitoringApp(),),);
                      },
                    ),
                    Text("Appointments", style: TextStyle(color: Colors.black54,),)

                  ]

              ),

              Column(
                  children: [
                    IconButton(
                      icon: Icon(Icons.note_add_sharp),
                      iconSize: 29,
                      color: Colors.black54,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>HealthMonitoringAppp(),),);
                      },
                    ),
                    Text("Evaluation", style: TextStyle(color: Colors.black54),)

                  ]),
              Column(
                  children: [

                    IconButton(
                      icon: Icon(Icons.person_add_alt_1_rounded,color: Colors.lightBlueAccent,),
                      iconSize: 29,
                      color: Colors.black54,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProfilePage
                              (
                              name: 'John Doe',
                              age: 35,
                              gender: 'Male',
                              paymentHistory: 'Dr.Anu: 10000',
                              // upcomingAppointment:
                              // 'Cardiologist, 02/28/2023, 10:00 AM',
                              // testReports: 'Cholesterol: 200, Blood Sugar: 120',
                              // prescriptions: 'Metformin, Lisinopril',
                              // vitalSigns: 'Blood Pressure: 120/80, Pulse: 72 bpm',
                              // healthGoals: 'Lose weight, Exercise regularly',
                              contactInfo: '92080989, john34@gmail.com',
                              address: 'House no. 17/1090 ,Jainbagh, Saharanpur',
                              // logout: '',
                            ),
                          ),
                        );
                      },

                    ),
                    Text("Profile", style: TextStyle(color: Colors.lightBlueAccent,fontWeight: FontWeight.bold),)


                  ]),




            ],
          ),

        ),

      ),

    );

  }
}
