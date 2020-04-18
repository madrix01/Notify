import 'package:http/http.dart' as http;
import 'package:testlogin/Service/loginVerification.dart' as logreg;
import 'dart:async';


int _logoutState;
int get logoutState => _logoutState;


makeLogoutRequest(String tkn) async{
  final uri = 'http://192.168.1.109:8000/auth/token/logout/';
  final String token = tkn;
  final logoutResp = 
    await http.post(
      uri,
      headers: {'Authorization': 'Token $token'},   
    );
  _logoutState = logoutResp.statusCode;
}