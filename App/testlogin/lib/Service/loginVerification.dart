import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dio/dio.dart' as dio;


String _token;
String get token => _token; 

int _loginStatus;
int get loginStatus => _loginStatus;

makeLoginRequest(String admn_no, String password) async{
  print("Making login request $_token");
  final uri = 'http://192.168.1.109:8000/auth/token/login';
   print('1');
   final headers = {'Content-Type': 'application/json'};
   print('2');
   Map<String, dynamic> body = { 
     'admn_no': 'u19ec012',
     'password': '########',
   };
   print('3');
   String jsonBody = json.encode(body);
   print('4');
   final encoding = Encoding.getByName('utf-8');
   print('5');
   http.Response response = await http.post(
     uri,
     headers: headers,
     body: jsonBody,
     encoding: encoding,
   );
   _loginStatus = response.statusCode;
   print(_loginStatus);
   print('6');
   String responseBody = response.body;
   Map valueMap = json.decode(responseBody);
   _token = valueMap['auth_token'];
   print(_token);
   print('7');
   return response.statusCode;
 }
