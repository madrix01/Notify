import 'dart:io';
import 'package:testlogin/Service/loginVerification.dart' as TokenService;
import 'package:http/http.dart' as http ; 
import 'dart:convert';

import './../urls.dart';

String _usrId;
String get usrId => _usrId;

Future<List<TestApi>> fetchTestApi() async {
  final String url = hostName + '/auth/home/';
  final String tkn = TokenService.token;
  final response = 
      await http.get(
        url,
        headers: {'Authorization': 'Token $tkn'},
        );

  if (response.statusCode == 200){
    List<dynamic> body = jsonDecode(response.body);
    List<TestApi> apis = body.map((dynamic item) => TestApi.fromJson(item)).toList();
    _usrId = apis[0].userId;
    return apis;
  } else{
    print('NO return');
  }
}

class TestApi{
  final String username;
  final String userId;

  TestApi({
    this.username, 
    this.userId,
    });

  factory TestApi.fromJson(Map<String, dynamic> json){
    return TestApi(
      username: json["username"],
      userId: json["userId"],
    );
  }
}