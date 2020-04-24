import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:testlogin/Service/loginVerification.dart' as TokenService;
import 'package:testlogin/Model/postModel.dart';
import 'package:testlogin/urls.dart';

Future<List<Post>> fetchMyPost() async {
  final String url = hostName + '/post/mypost/api/';
  final String tkn = TokenService.token;
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
    List<Post> myPostApis = body.map((dynamic item) => Post.fromJson(item)).toList();
    return myPostApis;
  } else{
    print("No return");
  }
}

