import 'package:flutter/material.dart';

class Home extends StatefulWidget {


  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController searchController = new TextEditingController();
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
        Column(
          children: [

            //Search Bar
            SafeArea(
              child: Container(
                //Search Wala Container

                padding: EdgeInsets.symmetric(horizontal: 8),
                margin: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24)),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        if((searchController.text).replaceAll(" ", "") == "")
                        {
                          print("Blank search");
                        }else{
                          Navigator.pushReplacementNamed(context, "/loading",arguments: {
                            "searchText" : searchController.text,
                          });
                        }

                      },
                      child: Container(
                        child: Icon(
                          Icons.search,
                          color: Colors.blueAccent,
                        ),
                        margin: EdgeInsets.fromLTRB(3, 0, 7, 0),
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        decoration: InputDecoration(
                            border: InputBorder.none, hintText: "Let's Cook Something!"),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("What you want to cook today ?",style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold,color: Colors.black),),
                  SizedBox(height: 12,),
                  Text("Let's cook something new !!" , style: TextStyle(fontSize: 25,color: Colors.grey.shade900),)
                ],
              ),
            ),
          ],
        )
        ],
      )
    );
  }
}
