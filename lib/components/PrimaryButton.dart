import 'package:flutter/material.dart';
import 'package:women_safety_ap/components/constants.dart';

class PrimaryButton extends StatelessWidget {
  final String title;
  final Function onPressed;
  final bool loading;
  const PrimaryButton({Key? key, this.loading=false,required this.title,required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width:double.infinity,
      child: ElevatedButton(onPressed: (){
        onPressed();
      },
          child: Text(title,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          backgroundColor: primaryColor,
        ),
      ),
    );
  }
}
