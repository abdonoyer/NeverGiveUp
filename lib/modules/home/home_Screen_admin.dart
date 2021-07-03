import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:give_up_drugs/modules/admin/viewHospital.dart';
import 'package:give_up_drugs/modules/admin/viewVideo.dart';
import 'package:give_up_drugs/modules/intro/intro_screen.dart';


class HomeScreenAdmin extends StatefulWidget {
  @override
  _HomeScreenAdminState createState() => _HomeScreenAdminState();
}

class _HomeScreenAdminState extends State<HomeScreenAdmin> {
  CollectionReference notesref =
      FirebaseFirestore.instance.collection('AddHelp');
  getUser() {
    var user = FirebaseAuth.instance.currentUser;
    print(user.email);
  }

  CollectionReference noteUser = FirebaseFirestore.instance.collection('Users');
  @override
  Widget build(BuildContext context) {
   

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.red,
          elevation: 0.0,
          title: Text(
            'حياه بلا ادمان',
            style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
       
          bottom: TabBar(
            labelColor: Colors.red,
            unselectedLabelColor: Colors.white,
            indicatorSize: TabBarIndicatorSize.label,
            indicator: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              color: Colors.white,
            ),
            tabs: [
              Tab(
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'فيديوهات',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Tab(
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'المستشفيات',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.exit_to_app,
                color: Colors.white,
              ),
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => IntroScreen()));
              },
            )
          ],
        ),
        body: TabBarView(
          children: [viewVideos(), viewHospitals()],
        ),
      ),
    );
  }
}
