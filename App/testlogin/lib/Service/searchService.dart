import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:testlogin/Model/postModel.dart';
import 'package:testlogin/Service/homePage.dart' as hp;
import './../urls.dart';
import 'package:testlogin/Service/loginVerification.dart' as TokenService;


Future<String> fetchSearchApi(String search) async{
  final String url = hostName + '/post/search/?search=$search';
  final String tkn = TokenService.token;
  final response = 
    await http.get(
      url,
      headers: {
        'Authorization' : 'Token $tkn',
        'Content-type' : 'application/json'
      },
    );
  return response.body;
}