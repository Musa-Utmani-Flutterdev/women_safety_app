import 'package:flutter/material.dart';
import 'package:women_safety_ap/widgets/home_widgets/emergencies/ambulance_emergency.dart';
import 'package:women_safety_ap/widgets/home_widgets/emergencies/army_emergency.dart';
import 'package:women_safety_ap/widgets/home_widgets/emergencies/police_emergency.dart';
import 'emergencies/firebrigade_emergency.dart';
class Emergency extends StatelessWidget {
  const Emergency({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
    width: MediaQuery.of(context).size.width,
      height: 180,
      child: ListView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: [
          PoliceEmergency(),
          AmbulanceEmergency(),
          FireBrigadeEmergency(),
          ArmyEmergency(),
        ],
      ),
    );
  }
}
