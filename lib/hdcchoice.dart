import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:self_login/hospitalist1.dart';

class hdChoice extends StatefulWidget {
  const hdChoice({super.key});

  @override
  State<hdChoice> createState() => _hdChoiceState();
}

class _hdChoiceState extends State<hdChoice> {
  @override
  Widget build(BuildContext context) {
    BackButton(
      color: Colors.black,
    );
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Who are you ?',
              style: TextStyle(
                  fontSize: 44,
                  fontWeight: FontWeight.w200,
                  color: Color.fromARGB(255, 20, 164, 231)),
              // textAlign: TextAlign.right,
            ),
            SizedBox(
              height: 20,
            ),
            FloatingActionButton.extended(
              heroTag: "btn1",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HospitalistDetails(),
                  ),
                );
              },
              label: Text(
                "A Hospitalist",
                // style: TextStyle(fontSize: 23),
              ),
              backgroundColor: Color.fromARGB(255, 24, 169, 206),
            ),
            SizedBox(height: 10),
            Text('Or'),
            SizedBox(height: 10),
            FloatingActionButton.extended(
              heroTag: "btn2",
              onPressed: () {},
              label: Text(
                "Private Dr.",
              ),
              backgroundColor: Color.fromARGB(255, 24, 169, 206),
            ),
            SizedBox(height: 10),
            Text('Or'),
            SizedBox(height: 10),
            FloatingActionButton.extended(
              heroTag: "btn3",
              onPressed: () {},
              label: Text(
                "Chemist",
              ),
              backgroundColor: Color.fromARGB(255, 24, 169, 206),
            ),
          ],
        ),
      ),
    );
  }
}
