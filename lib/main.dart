import 'package:flutter/material.dart';
import 'package:recipiebook/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'RecipieBook',
      theme: ThemeData(
       primarySwatch: Colors.red,
      ),
      home: Home(),
    );
  }
}

