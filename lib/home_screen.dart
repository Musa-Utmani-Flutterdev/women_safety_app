import 'dart:math';

import 'package:flutter/material.dart';
import 'package:women_safety_ap/widgets/home_widgets/CustomCarouel.dart';
import 'package:women_safety_ap/widgets/home_widgets/custom_appbar.dart';
import 'package:women_safety_ap/widgets/home_widgets/safehome/safehome.dart';
import 'package:women_safety_ap/widgets/live_safe.dart';

import 'widgets/home_widgets/emergency.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int qIndex = 0;
  getRandomQuote() {
    Random random = Random();
    setState(() {
      qIndex = random.nextInt(6);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getRandomQuote();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              CustomAppBar(
                  quotesIndex: qIndex,
                  onTap: () {
                    getRandomQuote();
                  }),
              Expanded(
                  child: ListView(
                shrinkWrap: true,
                children: [
                  CustomCarouel(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Emergency',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Emergency(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Explore LiveSafe',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  LiveSafe(),
                  SafeHome(),
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
