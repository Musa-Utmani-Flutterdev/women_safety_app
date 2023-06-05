import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:women_safety_ap/components/PrimaryButton.dart';
import 'package:women_safety_ap/components/SecondaryButton.dart';
import 'package:women_safety_ap/components/constants.dart';
import 'package:women_safety_ap/components/custom_textfield.dart';
import 'package:women_safety_ap/child/register_child.dart';
import 'package:women_safety_ap/db/share_pref.dart';
import 'package:women_safety_ap/home_screen.dart';
import 'package:women_safety_ap/parent/register_parent.dart';

import '../parent/parent_home_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isPasswordShown = false;
  final _formKey = GlobalKey<FormState>();
  final _formData = Map<String, Object>();
  bool isLoading = false;

  onSubmit() async {
    _formKey.currentState!.save();
    try {
      setState(() {
        isLoading = true;
      });
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: _formData['email'].toString(),
              password: _formData['password'].toString());
      if (userCredential != null) {
        setState(() {
          isLoading = false;
        });
        FirebaseFirestore.instance
            .collection('user')
            .doc(userCredential.user!.uid)
            .get()
            .then((value) {
          if (value['type'] == 'parent') {
            MySharedPreference.saveUserType('parent');
            print(value['type']);
            goTo(context, ParentHomeScreen());
          } else {
          MySharedPreference.saveUserType('child');
            goTo(context, HomeScreen());
          }
        });
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        isLoading = false;
      });
      if (e.code == 'user not found') {
        dialogBox(context, 'no user found for that email');
        print('no user found for that email.');
      } else if (e.code == 'wrong password') {
        dialogBox(context, 'wrong password provided for that user.');
        print('wrong password provided for that user.');
      }
    }
    print(_formData['email']);
    print(_formData['password']);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 40, left: 10, right: 10),
          child: Stack(
            children: [
              isLoading
                  ? progressIndicator(context)
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * 0.8,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  'USER LOGIN',
                                  style: TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Image.asset(
                                  'assets/logo.png',
                                  height: 100,
                                  width: 100,
                                ),
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.39,
                                  child: Form(
                                    key: _formKey,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        CustomTextField(
                                          hintText: 'email',
                                          prefix: Icon(Icons.email_outlined),
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          textInputAction: TextInputAction.next,
                                          onSave: (email) {
                                            _formData['email'] = email ?? '';
                                          },
                                          validate: (email) {
                                            if (email!.isEmpty ||
                                                email.length < 3 ||
                                                !email.contains('@')) {
                                              return 'please enter correct email';
                                            } else {
                                              return null;
                                            }
                                          },
                                        ),
                                        CustomTextField(
                                            hintText: 'password',
                                            isPassword: isPasswordShown,
                                            onSave: (password) {
                                              _formData['password'] =
                                                  password ?? '';
                                            },
                                            validate: (password) {
                                              if (password!.isEmpty ||
                                                  password.length < 6) {
                                                return 'please enter correct password';
                                              } else {
                                                return null;
                                              }
                                            },
                                            prefix: Icon(Icons.lock_outline),
                                            suffix: IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  isPasswordShown =
                                                      !isPasswordShown;
                                                });
                                              },
                                              icon: Icon(isPasswordShown
                                                  ? Icons
                                                      .visibility_off_outlined
                                                  : Icons.visibility_outlined),
                                            )),
                                        PrimaryButton(
                                            title: 'LOGIN',
                                            onPressed: () {
                                              // progressIndicator;
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                onSubmit();
                                              }
                                            }),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Forgot Password?",
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      SecondaryButton(
                                          onPressed: () {},
                                          title: 'click here'),
                                    ],
                                  ),
                                ),
                                SecondaryButton(
                                    onPressed: () {
                                      goTo(context, RegisterChildScreen());
                                    },
                                    title: 'Register as child'),
                                SecondaryButton(
                                    onPressed: () {
                                      goTo(context, RegisterParentScreen());
                                    },
                                    title: 'Register as parent')
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
