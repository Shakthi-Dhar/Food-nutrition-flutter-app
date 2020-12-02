import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
            builder: (BuildContext context){
              return IconButton(
                icon: Icon(Icons.fastfood, color: Colors.black,size: 40,),
                onPressed: () {
                },
              );
            }),
        title: Text("The Nutrionist"),
      ),
      body: Center(
        child:
        SpinKitPouringHourglass(
          color: Colors.cyanAccent,
          size: 250,
        ),
      ),
    );
  }
}
