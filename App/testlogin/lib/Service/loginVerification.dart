import 'package:http/http.dart' as http;
import 'dart:convert';


String _token;
String get token => _token;

makeLoginRequest(String admn_no, String password) async{
  final uri = 'http://192.168.1.109:8000/auth/token/login/';
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
  String responseBody = response.body;
  Map valueMap = json.decode(responseBody);
  _token = valueMap['auth_token'];
}


class Token{
  final String authToken;

  Token({this.authToken});

}