import 'package:testlogin/Service/loginVerification.dart' as TokenService;
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<Post>> fetchPostApi() async{
  final String url = 'http://192.168.1.109:8000/post/api';
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
    print("success");
    print(response.body);
    List<Post> postApis = body.map((dynamic item) => Post.fromJson(item)).toList();
    return postApis;
  } else{
    print("[No Return]");
  }
}


class Post{
  final int user_id;
  final String title;
  final String description;

  Post({this.user_id, this.title, this.description});

  factory Post.fromJson(Map<String, dynamic> json){
    return Post(
      user_id: json["user_id"],
      title: json["title"],
      description: json["description"],
    );
  }

}