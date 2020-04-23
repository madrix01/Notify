import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dio/dio.dart' as dio;

import './../urls.dart';

String _token;
String get token => _token; 

int _loginStatus;
int get loginStatus => _loginStatus;

makeLoginRequest(String admn_no, String password) async{
  print("Making login request $_token");
  final uri = hostName + '/auth/token/login';
  final headers = {'Content-Type': 'application/json'};
  Map<String, dynamic> body = { 
    'admn_no': admn_no,
    'password': password,
  };
  String jsonBody = json.encode(body);
  final encoding = Encoding.getByName('utf-8');
  http.Response response = await http.post(
    uri,
    headers: headers,
    body: jsonBody,
    encoding: encoding,
  );
  _loginStatus = response.statusCode;
  print("[Login Status code $_loginStatus]");
  String responseBody = response.body;
  Map valueMap = json.decode(responseBody);
  _token = valueMap['auth_token'];
  return response.statusCode;
 }
