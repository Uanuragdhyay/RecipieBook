import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class Home extends StatefulWidget {


  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController searchController = new TextEditingController();

  getRecipe( String query) async
  {
    String url = "https://api.edamam.com/search?q=$query&app_id=2eeffef2&app_key=a22a4be89733fe993fa6c5ad8ed8f0df&from=0&to=3&calories=591-722&health=alcohol-free";
    Response response = await get(Uri.parse(url));
    Map data= jsonDecode(response.body);
    log(data.toString());
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getRecipe("ladoo");
  }

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
                    Colors.white70,
                    Colors.yellowAccent.shade100,
                    Colors.orangeAccent.shade200
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
                          getRecipe(searchController.text);
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
                  Text("What you want to cook today ?",style: TextStyle(fontSize: 40,fontWeight: FontWeight.w800,color: Colors.black),),
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
