import 'dart:io';
import 'dart:math';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:give_up_drugs/models/helper/Alert.dart';
import 'package:give_up_drugs/modules/home/home_Screen_admin.dart';
import 'package:give_up_drugs/modules/home/home_screen.dart';
import 'package:path/path.dart';

import 'package:flutter/material.dart';

class EditHelp extends StatefulWidget {
  final docid;
  final list;
  EditHelp({Key key, this.docid, this.list});
  @override
  _EditHelpState createState() => _EditHelpState();
}

class _EditHelpState extends State<EditHelp> {
  CollectionReference helpref =
      FirebaseFirestore.instance.collection('AddHelp');

  File file;
  var nameHospital, addressHospital, phoneHospital;
  GlobalKey<FormState> formstate = new GlobalKey<FormState>();

  EditHelp(context) async {
    var formdata = formstate.currentState;
    if (file == null) {
      if (formdata.validate()) {
        showLoading(context);
        formdata.save();

        await helpref
            .doc(widget.docid)
            .update({
              "nameHospital": nameHospital,
              "addressHospital": addressHospital,
              "phoneHospital": phoneHospital,
              "id": FirebaseAuth.instance.currentUser.uid
            })
            .then((value) => () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomeScreen()));
                  showLoading(context);
                })
            .catchError((e) {
              print("$e");
            });
      }
    } else {
      if (formdata.validate()) {
        showLoading(context);
        formdata.save();
        await helpref
            .doc(widget.docid)
            .update({
              "nameHospital": nameHospital,
              "addressHospital": addressHospital,
              "phoneHospital": phoneHospital,
              "id": FirebaseAuth.instance.currentUser.uid
            })
            .then((value) => () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HomeScreenAdmin()));
                  showLoading(context);
                })
            .catchError((e) {
              print("$e");
            });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'تعديل البيانات',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0.0,
        centerTitle: true,
      ),
      body: ListView(children: [
        Container(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              Form(
                key: formstate,
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            child: Icon(Icons.person),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            "${FirebaseAuth.instance.currentUser.email}",
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15)),
                      child: TextFormField(
                        initialValue: widget.list['nameHospital'],
                        validator: (val) {
                          if (val.length > 100) {
                            return "Title can't to be larger than 30 letter";
                          }
                          if (val.length < 2) {
                            return "Title can't to be less than 2 letter";
                          }
                          return null;
                        },
                        onSaved: (val) {
                          nameHospital = val;
                        },
                        maxLength: 50,
                        decoration: InputDecoration(
                            labelText: " اسم المستشفي",
                            border: OutlineInputBorder(
                                borderSide: BorderSide(width: 1))),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      initialValue: widget.list['addressHospital'],
                      validator: (val) {
                        if (val.length > 100) {
                          return "Bio can't to be larger than 200 letter";
                        }
                        if (val.length < 2) {
                          return "Bio can't to be less than 2 letter";
                        }
                        return null;
                      },
                      onSaved: (val) {
                        addressHospital = val;
                      },
                      maxLength: 100,
                      decoration: InputDecoration(
                          labelText: "العنوان",
                          border: OutlineInputBorder(
                              borderSide: BorderSide(width: 1))),
                      scrollPadding: EdgeInsets.all(14.0),
                      maxLines: 8,
                      minLines: 5,
                      keyboardType: TextInputType.multiline,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15)),
                      child: TextFormField(
                        initialValue: widget.list['phoneHospital'],
                        validator: (val) {
                          if (val.length > 100) {
                            return "Title can't to be larger than 30 letter";
                          }
                          if (val.length < 2) {
                            return "Title can't to be less than 2 letter";
                          }
                          return null;
                        },
                        onSaved: (val) {
                          phoneHospital = val;
                        },
                        maxLength: 15,
                        decoration: InputDecoration(
                            labelText: "رقم الهاتف",
                            border: OutlineInputBorder(
                                borderSide: BorderSide(width: 1))),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                height: MediaQuery.of(context).size.height / 18,
                width: MediaQuery.of(context).size.width / 2,
                child: ElevatedButton(
                 
                  onPressed: () async {
                    await EditHelp(context);
                  },
                  child: Text(
                    'حفظ البيانات',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ]),
    );
  }
}
