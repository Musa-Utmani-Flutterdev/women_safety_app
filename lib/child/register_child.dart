import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:women_safety_ap/child/child_login_screen.dart';
import 'package:women_safety_ap/model/user_model.dart';
import '../components/PrimaryButton.dart';
import '../components/SecondaryButton.dart';
import '../components/constants.dart';
import '../components/custom_textfield.dart';

class RegisterChildScreen extends StatefulWidget {
  const RegisterChildScreen({Key? key}) : super(key: key);

  @override
  State<RegisterChildScreen> createState() => _RegisterChildScreenState();
}

class _RegisterChildScreenState extends State<RegisterChildScreen> {
  bool isPasswordShown = false;
  bool isRetypePasswordShown = true;
  final _formKey = GlobalKey<FormState>();
  final _formData = Map<String, Object>();
  bool isLoading = false;

  onSubmit() async {
    _formKey.currentState!.save();
    if (_formData['password'] != _formData['rpassword']) {
      dialogBox(context, 'password and retype password are not matching');
    } else {
      progressIndicator(context);
      try {
        setState(() {
          isLoading = true;
        });
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: _formData['cemail'].toString(),
                password: _formData['password'].toString());
        if (userCredential.user != null) {
          setState(() {
            isLoading = false;
          });
          final v = userCredential.user!.uid;
          final DocumentReference<Map<String, dynamic>> db =
              FirebaseFirestore.instance.collection('user').doc(v);
          final user = UserModel(
            name: _formData['name'].toString(),
            phone: _formData['phone'].toString(),
            childEmail: _formData['cemail'].toString(),
            guardianEmail: _formData['gemail'].toString(),
            id: v,
            type: 'child'
          );
          final jasonData = user.toJason();
          await db.set(jasonData).whenComplete(() {
            goTo(context, LoginScreen());
            setState(() {
              isLoading = false;
            });
          });
        }
      } on FirebaseAuthException catch (e) {
        setState(() {
          isLoading = false;
        });
        if (e.code == 'weak password') {
          dialogBox(context, 'the password provided is too weak');
          print('the password provided is too weak');
        } else if (e.code == 'email already in use') {
          dialogBox(context, 'the account already exist for that email');
          print('the account already exist for that email');
        }
      } catch (e) {
        setState(() {
          isLoading = false;
        });
        print(e);
        dialogBox(context, e.toString());
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
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Stack(
            children: [
              isLoading
                  ? progressIndicator(context)
                  : SingleChildScrollView(
                      child: Column(children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.3,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                'REGISTER AS CHILD',
                                textAlign: TextAlign.center,
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
                            ],
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.8,
                          child: Form(
                            key: _formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                CustomTextField(
                                  hintText: 'enter name',
                                  prefix: Icon(Icons.person),
                                  keyboardType: TextInputType.name,
                                  textInputAction: TextInputAction.next,
                                  onSave: (name) {
                                    _formData['name'] = name ?? '';
                                  },
                                  validate: (email) {
                                    if (email!.isEmpty || email.length < 3) {
                                      return 'please enter correct name';
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                                CustomTextField(
                                  hintText: 'enter phone',
                                  prefix: Icon(Icons.phone),
                                  keyboardType: TextInputType.phone,
                                  textInputAction: TextInputAction.next,
                                  onSave: (phone) {
                                    _formData['phone'] = phone ?? '';
                                  },
                                  validate: (email) {
                                    if (email!.isEmpty || email.length < 10) {
                                      return 'please enter correct phone number';
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                                CustomTextField(
                                  hintText: 'enter email',
                                  prefix: Icon(Icons.email_outlined),
                                  keyboardType: TextInputType.emailAddress,
                                  textInputAction: TextInputAction.next,
                                  onSave: (email) {
                                    _formData['cemail'] = email ?? '';
                                  },
                                  validate: (email) {
                                    if (email!.isEmpty ||
                                        email.length < 5 ||
                                        !email.contains('@')) {
                                      return 'please enter correct email address';
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                                CustomTextField(
                                  hintText: 'enter guardian email',
                                  prefix: Icon(Icons.email_outlined),
                                  keyboardType: TextInputType.emailAddress,
                                  textInputAction: TextInputAction.next,
                                  onSave: (gemail) {
                                    _formData['gemail'] = gemail ?? '';
                                  },
                                  validate: (email) {
                                    if (email!.isEmpty ||
                                        email.length < 5 ||
                                        !email.contains('@')) {
                                      return 'please enter correct email address';
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                                CustomTextField(
                                    hintText: 'enter password',
                                    isPassword: isPasswordShown,
                                    onSave: (password) {
                                      _formData['password'] = password ?? '';
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
                                          isPasswordShown = !isPasswordShown;
                                        });
                                      },
                                      icon: Icon(isPasswordShown
                                          ? Icons.visibility_off_outlined
                                          : Icons.visibility_outlined),
                                    )),
                                CustomTextField(
                                    hintText: 'retype password',
                                    isPassword: isRetypePasswordShown,
                                    onSave: (password) {
                                      _formData['rpassword'] = password ?? '';
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
                                          isRetypePasswordShown =
                                              !isRetypePasswordShown;
                                        });
                                      },
                                      icon: Icon(isRetypePasswordShown
                                          ? Icons.visibility_off_outlined
                                          : Icons.visibility_outlined),
                                    )),
                                PrimaryButton(
                                    title: 'REGISTER',
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        onSubmit();
                                      }
                                    }),
                              ],
                            ),
                          ),
                        ),
                        SecondaryButton(
                            onPressed: () {
                              goTo(context, LoginScreen());
                            },
                            title: 'Login with your account')
                      ]),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
