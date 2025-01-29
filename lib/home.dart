import 'dart:convert';
import 'dart:developer';
import 'package:recipiebook/model.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:recipiebook/search.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isLoading = true;
  List<RecipeModel> recipeList = <RecipeModel>[];
  TextEditingController searchController = new TextEditingController();
  List reciptCatList = [
    {
      "imgUrl": "https://th.bing.com/th/id/OIP.v-JS0wBINTRFTf8h_FfvKQHaEO?w=328&h=186&c=7&r=0&o=5&dpr=1.3&pid=1.7",
      "heading": "Chinese"
    },
    {
      "imgUrl": "https://th.bing.com/th/id/OIP.6PrNl6vmox8Ba-LPCq7GuAHaFj?w=280&h=211&c=7&r=0&o=5&dpr=1.3&pid=1.7",
      "heading": "Burgers"
    },
    {
      "imgUrl": "https://th.bing.com/th/id/OIP.AkriBJbGcXA0G69_QQp8owHaEK?w=253&h=180&c=7&r=0&o=5&dpr=1.3&pid=1.7",
      "heading": "Salad"
    },
    {
      "imgUrl": "https://th.bing.com/th/id/OIP.7-eGGZxV0tDSmddu5bax_gHaE8?w=252&h=180&c=7&r=0&o=5&dpr=1.3&pid=1.7",
      "heading": "Sweets"
    },
    {
      "imgUrl": "https://th.bing.com/th/id/OIP.2dhr5Ln6cMHIu9SmwE_uBgHaE7?w=281&h=188&c=7&r=0&o=5&dpr=1.3&pid=1.7",
      "heading": "Pizza"
    },
    {
      "imgUrl": "https://th.bing.com/th/id/OIP.l6iDvJGrlAoADUsju2QspAHaGJ?w=226&h=187&c=7&r=0&o=5&dpr=1.3&pid=1.7",
      "heading": "South Indian"
    },
    {
      "imgUrl":"https://th.bing.com/th/id/OIP.53mmDUWg0c0F1W7xmuDlPAHaD-?w=316&h=180&c=7&r=0&o=5&dpr=1.3&pid=1.7",
      "heading":"North Indian"
    }
  ];
  getRecipe(String query) async {
    String url =
        "https://api.edamam.com/search?q=$query&app_id=2eeffef2&app_key=a22a4be89733fe993fa6c5ad8ed8f0df";
    Response response = await get(Uri.parse(url));
    Map data = jsonDecode(response.body);
    // log(data.toString());

    data["hits"].forEach((element) {
      RecipeModel recipeModel = new RecipeModel();
      recipeModel = RecipeModel.fromMap(element['recipe']);
      recipeList.add(recipeModel);
      setState(() {
        isLoading= false;
      });
      log(recipeList.toString());
    });
    recipeList.forEach((Recipe) {
      print(Recipe.applabel);
      print(Recipe.Calories);
    });
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
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              Colors.white70,
              Colors.yellowAccent.shade100,
              Colors.orangeAccent.shade200
            ])),
          ),
          SingleChildScrollView(
            child: Column(
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
                            if ((searchController.text).replaceAll(" ", "") ==
                                "") {
                              print("Blank search");
                            } else {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> Search(searchController.text)));
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
                                border: InputBorder.none,
                                hintText: "Let's Cook Something!"),
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
                      Text(
                        "What you want to cook today ?",
                        style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.w800,
                            color: Colors.black),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: isLoading ? Center(child: CircularProgressIndicator()) : ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: recipeList.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {},
                          child: Card(
                            margin: EdgeInsets.all(10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 0.0,
                            child: Stack(
                              children: [
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      recipeList[index].appimageUrl,
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      height: 200,
                                    )),
                                Positioned(
                                  left: 0,
                                  right: 0,
                                  bottom: 0,
                                  child: Container(
                                    decoration:
                                        BoxDecoration(color: Colors.black38),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 10),
                                    child: Text(
                                      recipeList[index].applabel.toUpperCase(),
                                      style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  height: 40,
                                  width: 80,
                                  right: 0,
                                  child: Container(
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(10),
                                            bottomLeft: Radius.circular(10))),
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.local_fire_department,
                                            size: 16,
                                          ),
                                          Text(
                                            recipeList[index].Calories.toString().length > 7
                                                ? recipeList[index].Calories.toString().substring(0, 7)
                                                : recipeList[index].Calories.toString(),
                                            style: TextStyle(color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      }),
                ),
                Container(
                  height: 100,
                  child: ListView.builder(
                      itemCount: reciptCatList.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Container(
                            child: InkWell(
                          onTap: () {},
                          child: Card(
                              margin: EdgeInsets.all(20),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40),
                              ),
                              elevation: 0.0,
                              child: Stack(
                                children: [
                                  ClipRRect(
                                      borderRadius: BorderRadius.circular(40.0),
                                      child: Image.network(
                                        reciptCatList[index]["imgUrl"],
                                        fit: BoxFit.cover,
                                        width: 200,
                                        height: 200,
                                      )),
                                  Positioned(
                                      left: 0,
                                      right: 0,
                                      bottom: 0,
                                      top: 0,
                                      child: Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 10),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(40),
                                              color: Colors.black26),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                reciptCatList[index]["heading"],
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 28),
                                              ),
                                            ],
                                          ))),
                                ],
                              )),
                        ));
                      }),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
