import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:self_login/hospital_info.dart/review_system/packages.dart';

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
  String selectedHospital = '';
  String searchQuery = '';
  String hospitalName = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(200.0),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 5,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              size: 35,
            ),
            onPressed: () {
              // handle on press event
            },
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xfff36d1dc), Color(0xFFF5B86E5)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
            child: FlexibleSpaceBar(
              titlePadding: EdgeInsets.only(
                left: 20.0,
                bottom: 100,
              ),
              title: Text(
                'Select a Hospital',
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'ProfessionalFont',
                  color: Colors.white,
                ),
              ),
            ),
          ),
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
                  color: Colors.white,
                ),
                onSelected: (SortType selectedSortType) {
                  setState(() {
                    currentSortType = selectedSortType;
                    isAscending = !isAscending;
                    sortTests();
                  });
                },
                itemBuilder: (BuildContext context) =>
                    <PopupMenuEntry<SortType>>[
                  PopupMenuItem<SortType>(
                    value: SortType.Name,
                    child: Row(
                      children: [
                        Text(
                          'Sort by Name',
                        ),
                        SizedBox(width: 17),
                        Icon(
                          Icons.person,
                          color: Colors.blue,
                        ),
                      ],
                    ),
                  ),
                  PopupMenuItem<SortType>(
                    value: SortType.Location,
                    child: Row(
                      children: [
                        Text('Sort by Location'),
                        Icon(
                          Icons.location_on,
                          color: Colors.red,
                        ),
                      ],
                    ),
                  ),
                  PopupMenuItem<SortType>(
                    value: SortType.Rating,
                    child: Row(
                      children: [
                        Text('Sort by Rating'),
                        SizedBox(width: 16),
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            child: Container(
              color: Colors.grey[200],
              padding: EdgeInsets.all(5.0), // reduced padding
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
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 8.0), // reduced content padding
                  hintText: 'Search hospitals',
                  hintStyle: TextStyle(color: Colors.grey),
                ),
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
                        child: TextButton(
                          onPressed: (() {
                            // print("n);
                            fetchHospitalDetails(test['Hospital name']);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Packages(
                                  hospital: selectedHospital,
                                ),
                              ),
                            );
                          }),
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
                                              color: Colors.red,
                                              size: 16,
                                            ),
                                            SizedBox(width: 4),
                                            Expanded(
                                              child: Text(
                                                test['Location'],
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.black54,
                                                  fontFamily:
                                                      'ProfessionalFont',
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

  void fetchHospitalDetails(String hospitalName) {
    final selectedHospital = tests?.firstWhere(
      (doc) => doc['Hospital name'] == hospitalName,
      // orElse: () => null,
    );

    if (selectedHospital != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            if (selectedHospital.exists) {
              // Access the 'hospitalName' property if it exists
              final hospitalName = selectedHospital!['Hospital name'];
              return Packages(hospital: hospitalName);
            } else {
              // Handle the case when the document does not exist
              return Container(); // Replace with your desired fallback widget
            }
          },
        ),
      );
    }
  }
}
