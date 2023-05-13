import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HospitalList extends StatefulWidget {
  const HospitalList({Key? key}) : super(key: key);

  @override
  State<HospitalList> createState() => _HospitalListState();
}

enum SortType { Name, Location, Rating }

class _HospitalListState extends State<HospitalList> {
  List<QueryDocumentSnapshot>? tests;
  SortType currentSortType = SortType.Name;
  bool isAscending = true;
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'Hospital List',
          style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              fontFamily: 'ProfessionalFont',
              color: Color(0xFF363f93)),
        ),
        elevation: 0,
        actions: [
          PopupMenuTheme(
            data: PopupMenuThemeData(
              elevation: 8,
              textStyle: TextStyle(fontSize: 16, color: Colors.black),
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            child: PopupMenuButton<SortType>(
              icon: Icon(
                Icons.sort,
                color: Colors.black,
              ),
              onSelected: (SortType selectedSortType) {
                setState(() {
                  currentSortType = selectedSortType;
                  isAscending = !isAscending;
                  sortTests();
                });
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<SortType>>[
                PopupMenuItem<SortType>(
                  value: SortType.Name,
                  child: Text('Sort by Name'),
                ),
                PopupMenuItem<SortType>(
                  value: SortType.Location,
                  child: Text('Sort by Location'),
                ),
                PopupMenuItem<SortType>(
                  value: SortType.Rating,
                  child: Text('Sort by Rating'),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                  filterTests();
                });
              },
              decoration: InputDecoration(
                labelText: 'Search',
                prefixIcon: Icon(Icons.search),
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none,
                ),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
                hintText: 'Search hospitals',
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('test').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  tests = snapshot.data?.docs.toList();
                  filterTests();
                  sortTests();
                }

                return ListView.builder(
                  itemCount: tests?.length ?? 0,
                  itemBuilder: (context, index) {
                    final test = tests![index];

                    return Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                      margin: EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 253, 250, 243),
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: TextButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          alignment: Alignment.topLeft,
                          overlayColor: MaterialStateColor.resolveWith(
                              (states) => Colors.transparent),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              test['Hospital name'],
                              style: TextStyle(
                                fontSize: 24,
                                color: Color.fromARGB(255, 10, 10, 10),
                                fontWeight: FontWeight.bold,
                                fontFamily: 'ProfessionalFont',
                              ),
                            ),
                            SizedBox(height: 16),
                            Row(
                              children: [
                                Icon(
                                  Icons.location_city,
                                  color: Colors.grey,
                                  size: 40,
                                ),
                                SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Text(
                                      //   test['Hospital name'],
                                      //   style: TextStyle(
                                      //     fontSize: 20,
                                      //     fontWeight: FontWeight.bold,
                                      //     fontFamily: 'ProfessionalFont',
                                      //   ),
                                      // ),
                                      SizedBox(height: 8),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.location_on,
                                            color: Colors.black54,
                                            size: 16,
                                          ),
                                          SizedBox(width: 4),
                                          Expanded(
                                            child: Text(
                                              test['Location'],
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.black54,
                                                fontFamily: 'ProfessionalFont',
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 16),
                            Text(
                              test['Hospital Details'],
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black87,
                                fontWeight: FontWeight.normal,
                                fontFamily: 'ProfessionalFont',
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void sortTests() {
    switch (currentSortType) {
      case SortType.Name:
        tests?.sort((a, b) => a['Hospital name'].compareTo(b['Hospital name']));
        break;
      case SortType.Location:
        tests?.sort((a, b) => a['Location'].compareTo(b['Location']));
        break;
      case SortType.Rating:
        tests?.sort((a, b) => _getRating(b).compareTo(_getRating(a)));
        break;
    }

    if (!isAscending) {
      tests?.reversed;
    }
  }

  double _getRating(QueryDocumentSnapshot doc) {
    // Replace this with your rating extraction logic
    return doc['Rating'] ?? 0.0;
  }

  void filterTests() {
    if (searchQuery.isEmpty) return;

    tests = tests
        ?.where((doc) =>
            doc['Hospital name']
                .toString()
                .toLowerCase()
                .contains(searchQuery.toLowerCase()) ||
            doc['Location']
                .toString()
                .toLowerCase()
                .contains(searchQuery.toLowerCase()))
        .toList();
  }
}
