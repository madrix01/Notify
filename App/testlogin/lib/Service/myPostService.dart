import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:testlogin/Service/loginVerification.dart' as TokenService;
import 'package:testlogin/Model/postModel.dart';

Future<List<Post>> fetchMyPost() async {
  final String url = 'http://192.168.1.109:8000/post/mypost/api/';
  final String tkn = TokenService.token;
  print(tkn);
  final response = 
    await http.get(
      url,
      headers: {
        'Authorization': 'Token $tkn',
        'Content-type': 'application/json'
      }
    );
  if(response.statusCode == 200){
    List<dynamic> body = jsonDecode(response.body);
    print("success");
    List<Post> myPostApis = body.map((dynamic item) => Post.fromJson(item)).toList();
    return myPostApis;
  } else{
    print("No return");
  }
}

