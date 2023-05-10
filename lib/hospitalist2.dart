import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class HospitalList extends StatefulWidget {
  const HospitalList({super.key});

  @override
  State<HospitalList> createState() => _HospitalListState();
}

class _HospitalListState extends State<HospitalList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      // floatingActionButton: null,
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('test').snapshots(),
        builder: (context, snapshot) {
          List<Row> testWidgets = [];
          if (snapshot.hasData) {
            final tests = snapshot.data?.docs.reversed.toList();
            for (var test in tests!) {
              final testWidget = Row(
                // mainAxisAlignment: MainAxisAlignment.space,
                children: [
                  Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.only(top: 50, left: 20),
                      alignment: Alignment.centerLeft,
                      child: TextButton(
                        // backgroundColor: Colors.lightBlue,
                        onPressed: () {},
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(test['Hospital name'],
                                    style: TextStyle(
                                        fontSize: 31,
                                        color:
                                            Color.fromARGB(255, 33, 247, 226),
                                        fontWeight: FontWeight.bold)
                                    // color: Color.fromARGB(255, 2, 245, 216)),
                                    // textAlign: TextAlign.start,
                                    ),
                                SizedBox(
                                  width: 20,
                                ),
                                Icon(
                                  Icons.star_rate,
                                  color: Colors.yellow,
                                ),
                                Icon(
                                  Icons.star_rate,
                                  color: Colors.yellow,
                                ),
                                Icon(
                                  Icons.star_rate,
                                  color: Colors.yellow,
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              // mainAxisSize: MainAxisSize.max,
                              children: [
                                // Padding(padding: EdgeInsets.only(right: 92)),

                                Column(
                                  children: [
                                    Icon(
                                      Icons.location_city,
                                      color: Color.fromARGB(137, 177, 175, 175),
                                      size: 56,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      // children: [
                                      //   Text(
                                      //     test['Hospital name'],
                                      //     style: TextStyle(fontSize: 34),
                                      //     // textAlign: TextAlign.start,
                                      //   ),
                                      // ],
                                    ),
                                    SizedBox(
                                      width: 100,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Icon(
                                          Icons.location_on,
                                          color: Colors.black54,
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2,
                                          child: Text(
                                            test['Location'],
                                            style: TextStyle(
                                              color: Colors.black54,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 90,
                                ),
                                // SizedBox(
                                //   height: 80,
                                // ),
                                Container(
                                  width: MediaQuery.of(context).size.width / 2,
                                  // height: MediaQuery.of(context).size.height / 2,

                                  child: Text(test['Hospital Details'],
                                      style: TextStyle(
                                          // fontSize: 31,
                                          color: Colors.black54,
                                          fontWeight: FontWeight.bold)
                                      // color: Color.fromARGB(255, 2, 245, 216)),
                                      // textAlign: TextAlign.start,
                                      ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                              ],
                            ),

                            // Row(
                            //   children: [
                            //     Icon(Icons.location_on),
                            //     Text(test['Location']),
                            //   ],
                            // )
                          ],
                        ),

                        //
                      ))
                ],
              );

              testWidgets.add(testWidget);
            }
          }

          return ListView(
            children: testWidgets,
          );
        },
      ),
    );
  }
}
