import 'package:flutter/material.dart';

const Color primaryColor = Color(0xfffc3b77);
void goTo(BuildContext context, Widget nextScreen) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => nextScreen));
}

dialogBox(BuildContext context, String text) {
  showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text(text),
          ));
}

Widget progressIndicator(BuildContext context) {
  return Center(
    child: CircularProgressIndicator(
      color: Colors.red,
      backgroundColor: primaryColor,
      strokeWidth: 7,
    ),
  );
}
