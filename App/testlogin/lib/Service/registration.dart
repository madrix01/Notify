import 'dart:convert';
import 'package:http/http.dart' as http;

import './../urls.dart';

int _statusCode;
int get statusCode => _statusCode;

makePostRequest(String admn_no, String email, String password,) async {
  final uri = hostName + '/auth/users/';
  final headers = {'Content-Type': 'application/json'};
  Map<String, dynamic> body = {
    'admn_no': admn_no,
    'email': email,
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
  return response.statusCode;
}