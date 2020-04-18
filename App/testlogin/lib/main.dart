import 'package:flutter/material.dart';
import 'package:testlogin/home.dart';
import 'package:testlogin/routeGenerator.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget{
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>{
  
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: "Notify",
      initialRoute: '/',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red
      ),
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}