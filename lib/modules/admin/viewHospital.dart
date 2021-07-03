import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:give_up_drugs/modules/admin/add.dart';
import 'package:give_up_drugs/modules/admin/edit.dart';

class viewHospitals extends StatefulWidget {
  @override
  _viewHospitalsState createState() => _viewHospitalsState();
}

class _viewHospitalsState extends State<viewHospitals> {
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
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddHelp()));
        },
      ),
      body: Container(
        child: FutureBuilder(
            future: helpref
                .get(),
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
                    return Dismissible(
                        onDismissed: (change) async {
                          await helpref.doc(snapshot.data.docs[i].id).delete();
                        },
                        key: UniqueKey(),
                        child: ListHospital(
                          viewHospitals: snapshot.data.docs[i],
                          docid: snapshot.data.docs[i].id,
                        ));
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
  final viewHospitals;
  final docid;
  ListHospital({this.viewHospitals, this.docid});
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
                        "${viewHospitals['nameHospital']}",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "${viewHospitals['addressHospital']}",
                        style: TextStyle(
                          fontSize: 15.0,
                        ),
                      ),
                      Text(
                        "${viewHospitals['phoneHospital']}",
                        style: TextStyle(
                          fontSize: 15.0,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return EditHelp(docid: docid, list: viewHospitals);
                      }));
                    },
                    icon: Icon(
                      Icons.edit,
                      color: Colors.grey,
                    ),
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
