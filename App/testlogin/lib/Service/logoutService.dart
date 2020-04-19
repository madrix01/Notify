import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:testlogin/Service/loginVerification.dart' as logreg;
import 'dart:async';


int _logoutState;
int get logoutState => _logoutState;


makeLogoutRequest(String tkn) async{
  final uri = 'http://192.168.1.109:8000/auth/token/logout/';
  String token = tkn;
  final encoding = Encoding.getByName('utf-8');
  final logoutResp = 
    await http.post(
      uri,
      headers: {'Authorization': 'Token $token'},
      encoding: encoding,   
    );
  _logoutState = logoutResp.statusCode;
  token = null;
}