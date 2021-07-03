import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Hospitals extends StatefulWidget {
  @override
  _HospitalsState createState() => _HospitalsState();
}

class _HospitalsState extends State<Hospitals> {
  CollectionReference helpref =
      FirebaseFirestore.instance.collection('AddHelp');
  getUser() {
    var user = FirebaseAuth.instance.currentUser;
    print(user.email);
  }

  CollectionReference noteUser = FirebaseFirestore.instance.collection('Users');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: FutureBuilder(
            future: helpref.get(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.separated(
                  separatorBuilder: (context, index) => Padding(
                    padding: EdgeInsetsDirectional.only(start: 20),
                    child: Container(
                      height: 1.0,
                      width: double.infinity,
                      color: Colors.grey[400],
                    ),
                  ),
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, i) {
                    return ListHospital(
                      hospitals: snapshot.data.docs[i],
                      docid: snapshot.data.docs[i].id,
                    );
                  },
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            }),
      ),
    );
  }
}

class ListHospital extends StatelessWidget {
  final hospitals;
  final docid;
  ListHospital({this.hospitals, this.docid});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey[200], borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 40.0,
                child: Icon(
                  Icons.local_hospital_sharp,
                  size: 45.0,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${hospitals['nameHospital']}",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "${hospitals['addressHospital']}",
                        style: TextStyle(
                          fontSize: 15.0,
                        ),
                      ),
                      Text(
                        "${hospitals['phoneHospital']}",
                        style: TextStyle(
                          fontSize: 15.0,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
