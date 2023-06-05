import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:women_safety_ap/utils/quotes.dart';

class CustomCarouel extends StatelessWidget {
  const CustomCarouel({Key? key}) : super(key: key);
 void NavigaterToRoute(BuildContext context,Widget route){
   Navigator.push(context, CupertinoPageRoute(builder: (context)=>route));
 }
  @override
  Widget build(BuildContext context) {
    return Container(
    child: CarouselSlider(
        options:CarouselOptions(
          aspectRatio: 2.0,
          autoPlay: true,
          enlargeCenterPage: true,
        ),
      items: List.generate(imageSliders.length, (index) => Card(
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: InkWell(
          onTap: (){
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                fit: BoxFit.cover,
                  image: NetworkImage(imageSliders[index]
              ))
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(colors: [
                  Colors.black.withOpacity(0.5),
                  Colors.transparent,
                ]),
              ),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8,left: 8),
                  child: Text(articleTitle[index],
                    style: TextStyle(color: Colors.white,
                      fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.of(context).size.width*.05),),
                ),
              ),
            ),
          ),
        ),

      )),
    ),
    );
  }
}
