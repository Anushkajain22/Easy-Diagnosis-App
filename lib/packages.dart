import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Packages extends StatefulWidget {
  @override
  _PackagesState createState() => _PackagesState();
}

class _PackagesState extends State<Packages> {
  double ratings = 0;
  int totalUsers = 0; // Variable to store the total number of users

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Hospital Packages',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('test')
            .where('Hospital name', isEqualTo: 'Neelam Hospital')
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

                for (int i = 1; i < 4; i++) {
                  final packageName = package['Package$i'];
                  final estimatedCost = package['estimated cost$i'];

                  if (packageName != null && estimatedCost != null) {
                    packageWidgets.add(
                      Container(
                        child: Row(
                          children: [
                            Text(
                              'Estimated Cost: $estimatedCost',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[700],
                              ),
                            ),
                            Text(
                              packageName,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
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
                      child: Row(
                        children: [
                          Text(
                            package['Hospital name'],
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      color: Colors.grey[400],
                      thickness: 1,
                      height: 0,
                    ),
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Location: $Location',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[700],
                            ),
                          ),
                          Text(
                            'Ratings',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[700],
                            ),
                          ),
                          Text(
                            'email: $email',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[700],
                            ),
                          ),
                          Text(
                            'Hospital Details: $Hospitald',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[700],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Rating: $ratings',
                                  style: TextStyle(fontSize: 14),
                                ),
                                RatingBar.builder(
                                  initialRating: ratings,
                                  maxRating: 1,
                                  itemSize: 46,
                                  itemBuilder: (context, _) => Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  updateOnDrag: true,
                                  onRatingUpdate: (rating) {
                                    setState(() {
                                      ratings = rating;
                                      totalUsers++; // Increment totalUsers when a user rates the app
                                    });
                                  },
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Total Users: $totalUsers', // Display the total number of users
                                  style: TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 16),
                    ...packageWidgets,
                    SizedBox(height: 16),
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
