import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:testlogin/Service/loginVerification.dart' as TokenService;
import 'package:http/http.dart' as http ; 
import 'dart:convert';


Future<List<TestApi>> fetchTestApi() async {
  final String url = 'http://192.168.1.109:8000/auth/home/';
  final String tkn = TokenService.token;
  final response = 
      await http.get(
        url,
        headers: {'Authorization': 'Token $tkn'},
        );

  if (response.statusCode == 200){
    List<dynamic> body = jsonDecode(response.body);
    print('Success');
    print(response.body);
    List<TestApi> apis = body.map((dynamic item) => TestApi.fromJson(item)).toList();
    return apis;
  } else{
    print('NO return');
  }
}

class TestApi{
  final String message;
  final String username;

  TestApi({
    @required this.message, 
    @required this.username
    });

  factory TestApi.fromJson(Map<String, dynamic> json){
    return TestApi(
      message: json["message"],
      username: json["username"],
    );
  }
}