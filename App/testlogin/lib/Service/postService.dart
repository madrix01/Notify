import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:testlogin/Service/homePage.dart' as hp;
int _postStatCode;
int get postStatCode => _postStatCode;

makeNewRequest(String title, String description, String tkn) async{
  final uri = 'http://192.168.1.109:8000/post/allpost/api/';
  final headers = {
    'Authorization': 'Token $tkn',
    'Content-Type': 'application/json',
    };
  Map<String, dynamic> body = {
    'title': title,
    'description': description,
    'user_id': hp.usrId
  };
  String jsonBody = json.encode(body);
  print(jsonBody);
  final encoding = Encoding.getByName('utf-8');
  http.Response response = await http.post(
    uri,
    headers: headers,
    body: jsonBody,
    encoding: encoding,
  );
  print(response.body);
  int stat = response.statusCode; 
  print("Post Status $stat");
  _postStatCode = response.statusCode;
}