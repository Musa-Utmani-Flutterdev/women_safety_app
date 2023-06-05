import 'package:flutter/material.dart';
class SecondaryButton extends StatelessWidget {
  final String title;
  final Function onPressed;
  const SecondaryButton({Key? key,required this.onPressed,required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextButton(onPressed: (){
        onPressed();
      }, child:Text(title,style: TextStyle(
        fontSize: 18,
      ),) ),
    );
  }
}
