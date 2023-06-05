import 'package:flutter/material.dart';

class SafeHome extends StatelessWidget {
  showModalSafeHome(BuildContext context){
    showBottomSheet(context: context,
        builder: (context){
      return Container(
        height: MediaQuery.of(context).size.height/1.8,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))
        ),
      );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=>showModalSafeHome(context),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          height: 180,
          width: MediaQuery.of(context).size.width * 0.7,
          child: Row(
            children: [
              Expanded(
                  child: Column(
                children: [
                  ListTile(
                    title: Text('Send Location'),
                    subtitle: Text('Share Location'),
                  ),
                ],
              )),
              ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset('assets/route.jpg'))
            ],
          ),
        ),
      ),
    );
  }
}
