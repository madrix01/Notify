import 'package:flutter/material.dart';
import 'package:testlogin/login.dart';
import 'package:testlogin/home.dart';
import 'package:testlogin/home1.dart';
import 'package:testlogin/addPost.dart';




class RouteGenerator{
  static Route<dynamic> generateRoute(RouteSettings settings){
    
    final args = settings.arguments;
    print(settings.name);

    switch (settings.name){
      case '/':
        return MaterialPageRoute(builder: (_) => NoteList());
      case '/':
        return MaterialPageRoute(builder: (_) => NoteList());
      case '/second':
        return MaterialPageRoute(builder: (_) => LoginPage());
      case '/home':
        return MaterialPageRoute(builder: (_) => HomePage());
      case '/addPost':
        return MaterialPageRoute(builder: (_) => CreatePost());
    }
  }
}