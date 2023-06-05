import 'package:flutter/material.dart';
import 'package:women_safety_ap/utils/quotes.dart';

class CustomAppBar extends StatelessWidget {
   // CustomAppBar({Key? key}) : super(key: key);
   Function? onTap;
   int? quotesIndex;
   CustomAppBar({this.quotesIndex, this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        onTap!();
      },
      child: Container(
        child: Text(sweetSayings[quotesIndex!],
          style: TextStyle(fontSize: 22),),
      ),
    );
  }
}
