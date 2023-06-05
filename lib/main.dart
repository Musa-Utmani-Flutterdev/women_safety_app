import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:women_safety_ap/components/constants.dart';
import 'package:women_safety_ap/db/share_pref.dart';
import 'package:women_safety_ap/home_screen.dart';
import 'package:women_safety_ap/child/child_login_screen.dart';
import 'package:women_safety_ap/parent/parent_home_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await MySharedPreference.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:FutureBuilder(
        future: MySharedPreference.getUserType(),
          builder: (BuildContext context,AsyncSnapshot snapshot){
            if(snapshot.data==''){
              return LoginScreen();
            }
            if(snapshot.data=='parent'){
              return ParentHomeScreen();
            }
            if(snapshot.data=='child'){
              return ParentHomeScreen();
            }
            return progressIndicator(context);
          })
    );
  }
}
