import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:give_up_drugs/models/Auth/login.dart';
import 'package:give_up_drugs/modules/home/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SiginUp extends StatefulWidget {
  @override
  _SiginUpState createState() => _SiginUpState();
}

class _SiginUpState extends State<SiginUp> {
  var myUserName, mypassword, myemail;
  GlobalKey<FormState> formstate = new GlobalKey<FormState>();
  UserCredential userCredential;

  SiginUp() async {
    var formdata = formstate.currentState;
    if (formdata.validate()) {
      formdata.save();

      try {
        // showLoading(context);
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: myemail, password: mypassword);
        return userCredential;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          Navigator.of(context).pop();
          AwesomeDialog(
              context: context,
              title: "Error",
              body: Text("Password is to weak"))
            ..show();
        } else if (e.code == 'email-already-in-use') {
          Navigator.of(context).pop();
          AwesomeDialog(
              context: context,
              title: "Error",
              body: Text("The account already exists for that email"))
            ..show();
        }
      } catch (e) {
        print(e);
      }
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(
            height: 40,
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: Form(
              key: formstate,
              child: Column(
                children: [
                  //username
                  TextFormField(
                    onSaved: (val) {
                      myUserName = val;
                    },
                    validator: (val) {
                      if (val.length > 100) {
                        return "Email can't to be larger than 100 letter";
                      }
                      if (val.length < 2) {
                        return "Email can't to be less than 2 letter";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        labelText: "UserName",
                        border: OutlineInputBorder(
                            borderSide: BorderSide(width: 1))),
                  ),
                  SizedBox(height: 20),
                  //my email
                  TextFormField(
                    onSaved: (val) {
                      myemail = val;
                    },
                    validator: (val) {
                      if (val.length > 100) {
                        return "Email can't to be larger than 100 letter";
                      }
                      if (val.length < 2) {
                        return "Email can't to be less than 2 letter";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email),
                        labelText: "Email",
                        border: OutlineInputBorder(
                            borderSide: BorderSide(width: 1))),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    onSaved: (val) {
                      mypassword = val;
                    },
                    validator: (val) {
                      if (val.length > 100) {
                        return "Password can't to be larger than 100 letter";
                      }
                      if (val.length < 4) {
                        return "Password can't to be less than 4 letter";
                      }
                      return null;
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        labelText: "password",
                        border: OutlineInputBorder(
                            borderSide: BorderSide(width: 1))),
                  ),

                  SizedBox(height: 20),
                  Container(
                      height: MediaQuery.of(context).size.height / 15,
                      width: MediaQuery.of(context).size.width / 2,
                      child: ElevatedButton(
                        onPressed: () async {
                          UserCredential result = await SiginUp();
                          print('=================');
                          print(result.user.email);
                          print('=================');
                          if (result != null) {
                            await FirebaseFirestore.instance
                                .collection('Users')
                                .add(
                                    {'username': myUserName, 'email': myemail});
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomeScreen(),
                                ));
                          }
                        },
                        child: Text(
                          "Sign up",
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      )),
                  SizedBox(height: 10),
                  Container(
                    height: MediaQuery.of(context).size.height / 15,
                    width: MediaQuery.of(context).size.width / 2,
                    child: ElevatedButton(
                      onPressed: () async {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Login(),
                            ));
                      },
                      child: Text(
                        "Sign In",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
