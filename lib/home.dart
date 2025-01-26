import 'package:flutter/material.dart';

class Home extends StatefulWidget {


  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height ,
            decoration: BoxDecoration(
              gradient:LinearGradient(
                  colors:[
                    Colors.white60,
                    Colors.yellowAccent.shade100,
                    Colors.orangeAccent.shade100
                  ]
              )
            ),
          ),
          SafeArea(child: Text("HEMLOO"),
          )
        ],
      )
    );
  }
}
