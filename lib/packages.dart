import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Packages extends StatefulWidget {
  final String hospital;

  const Packages({Key? key, required this.hospital}) : super(key: key);

  @override
  _PackagesState createState() => _PackagesState();
}

class _PackagesState extends State<Packages> {
  double ratings = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(200.0),
        child: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xfff36d1dc), Color(0xFFF5B86E5)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  children: [
                    SizedBox(
                      height: 200,
                      child: IconButton(
                        icon: Icon(Icons.arrow_back,
                            size: 40, color: Colors.white),
                        onPressed: () {
                          // Add your navigation code here
                        },
                      ),
                    ),
                    SizedBox(width: 20), // Add this SizedBox for spacing
                    Text(
                      'Hospital Packages',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('test')
            // .where('Hospital name', isEqualTo: 'Neelam Hospital')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final packages = snapshot.data!.docs;
            return ListView.builder(
              itemCount: packages.length,
              itemBuilder: (context, index) {
                final package = packages[index];
                List<Widget> packageWidgets = [];

                final email = package['email'];
                final Location = package['Location'];
                final Hospitald = package['Hospital Details'];

                for (int i = 1; i < 2; i++) {
                  final packageName = package['Package$i'];
                  final estimatedCost = package['estimated cost$i'];

                  if (packageName != null && estimatedCost != null) {
                    packageWidgets.add(
                      Container(
                        child: SizedBox(
                          height: 30,
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 19,
                                  ),
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(3),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 3),
                                          child: Text(
                                            packageName,
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 30.0),
                                    child: Row(
                                      children: [
                                        Text(
                                          'Estimated Cost: \u20B9$estimatedCost',
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),

                              // SizedBox(height: 10),
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 24,
                      ),
                      child: Column(
                        children: [
                          Text(
                            package['Hospital name'],
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          // SizedBox(height: 10,)
                        ],
                      ),
                    ),
                    Divider(
                      color: Colors.grey[400],
                      thickness: 1,
                      height: 0,
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              // Icon(Icons.info_outline,color: Colors.blue,),
                              // // SizedBox(width:3),
                              Flexible(
                                child: Text(
                                  'Hospital Details: $Hospitald',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey[700],
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment:
                                MainAxisAlignment.start, // added property
                            children: [
                              // Icon(Icons.location_on, color: Colors.red),
                              Flexible(
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 4),
                                  child: Text(
                                    'Location: $Location',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.grey[700],
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.red, width: 1),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 16.0),
                              child: Text(
                                'Email: $email',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.grey[700],
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 16),
                          Container(
                            child: Row(
                              children: [
                                Flexible(
                                  flex: 0,
                                  child: Text(
                                    'Rating: $ratings',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: RatingBar.builder(
                                    initialRating: ratings,
                                    minRating: 0,
                                    direction: Axis.horizontal,
                                    allowHalfRating: false,
                                    itemCount: 5,
                                    itemSize: 24,
                                    itemPadding:
                                        EdgeInsets.symmetric(horizontal: 4.0),
                                    itemBuilder: (context, _) => Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    onRatingUpdate: (rating) {
                                      setState(() {
                                        ratings = rating;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              SizedBox(height: 20),
                              Text(
                                'Services',
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16),
                    ...packageWidgets,
                    SizedBox(height: 16),
                    Container(
                      child: Container(
                          child: Row(
                        children: [
                          IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.thumb_up_sharp,
                                  color: Colors.grey, size: 20)),
                          IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.thumb_down,
                                color: Colors.grey,
                                size: 20,
                              ))
                        ],
                      )),
                    ),
                    Container(
                      child: // Expanded(child: ListView()),
                          Container(
                        padding: EdgeInsets.all(5),
                        child: Row(
                          children: [
                            Expanded(
                                child: TextFormField(
                              minLines: 1,
                              maxLines: 100,
                              decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 5),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15))),
                            )),
                            SizedBox(
                              width: 5,
                            ),
                            CircleAvatar(
                                radius: 25,
                                child: IconButton(
                                    onPressed: () {}, icon: Icon(Icons.send)))
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.red,
                ),
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
