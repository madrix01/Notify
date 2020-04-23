import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:testlogin/login.dart';
import 'package:testlogin/routeGenerator.dart';
import 'package:testlogin/Service/registration.dart' as reg ;
import 'package:bordered_text/bordered_text.dart';
import 'package:shared_preferences/shared_preferences.dart';



class NoteList extends StatefulWidget {
  @override
  _NoteListState createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {

  _CheckIsUserLoggedIn(var context)async{
  SharedPreferences currentInstance = await SharedPreferences.getInstance();
  bool userStatus = currentInstance.getBool('loginStatus') ?? false;
  print("User Login Status"); print(userStatus);
  if(userStatus == true){
    Navigator.pushNamed(context, '/home');
  } 
}

  final myController = TextEditingController();
  final pswdController = TextEditingController();
  final emailController = TextEditingController();


  @override
  void dispose(){
    myController.dispose();
    pswdController.dispose();
    emailController.dispose();
    super.dispose();
  }
  void fieldClear(){
    myController.clear();
    pswdController.clear();
    emailController.clear();
  }

  @override
  Widget build(BuildContext context) {
  _CheckIsUserLoggedIn(context);
   

    return
    SafeArea(
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        backgroundColor: Color(0xFF1c1c1c),
        body:
        Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.redAccent,
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0.0, 1.0), //(x,y)
                    blurRadius: 6.0,
                  ),
                ]
              ),
              width: double.maxFinite,
              height: 100,
              margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  "Notify",
                  style: TextStyle(
                    fontSize: 50,
                    color: Colors.black,
                    fontWeight: FontWeight.bold
                  ),
                  ),
              ),
            ),
            SizedBox(height: 10),
            //Heading
            Align(
              alignment: Alignment.centerLeft,
                child: Container(
                  margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 45,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Ubuntu',
                    ),
                ),
              ),
            ),
            SizedBox(height:30),
            //Admission no.
            Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0.0, 1.0), //(x,y)
                    blurRadius: 6.0,
                  ),
                ],
                color: Colors.grey[850],
                borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
              
              child: Column(
                children: <Widget>[
                  TextField(
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide(color:Colors.black, width:2)),
                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide(color:Colors.black, width:2)),
                      border: OutlineInputBorder(),
                      labelText: 'Admission No.',
                      hintText: '8 digit admission no.',
                     ),
                    autofocus: false,
                    controller: myController,
                  ),
                   SizedBox(height: 10,),
            //email field
                  TextField(
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide(color:Colors.black, width:2)),
                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide(color:Colors.black, width:2)),
                      border: OutlineInputBorder(),
                      labelText: 'E-Mail',
                      hintText: 'Email for for Updates',
                     ),
                    autofocus: false,
                    controller: emailController,
                  ),
                   SizedBox(height: 10,),
            //Password field
                  TextField(
                    obscureText: true,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide(color:Colors.black, width:2)),
                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide(color:Colors.black, width:2)),
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                      hintText: 'Password Longer than 8 charecters',
                     ),
                    autofocus: false,
                    controller: pswdController,
                  ),
                  
                ],
              ),
            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.center,
              child: FlatButton(
                color: Colors.redAccent,
                padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                child: Text(
                    'Sign Up',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30
                    ),
                    ),
                shape: RoundedRectangleBorder( 
                  borderRadius: BorderRadius.circular(20)),
                onPressed: () async{
                  int state = await reg.makePostRequest(myController.text, emailController.text, pswdController.text);
                  if(state == 201){
                    print('Request made');
                    Navigator.of(context).pushNamed('/second');
                  } else {
                    print('Registration error');
                    showDialog(
                        context: context,
                        builder: (_) => 
                    AlertDialog(
                      actions: <Widget>[FlatButton( child: Text('Ok'), onPressed:(){Navigator.of(context).pop();} ),],
                      backgroundColor: Colors.black,
                      title: Text(
                        'Bad Registration Info',
                        style: TextStyle(
                          color:Colors.red,
                          fontSize: 15,
                        ),
                      )
                      )
                    );
                    fieldClear();
                  }
                },
                ),
            ),
            SizedBox(height: 30,),
            Align(
              alignment: Alignment.center,
                child: GestureDetector(
                  onTap: (){
                    Navigator.of(context).pushNamed('/second');
                  },
                  child: Text(
                    "Login Instead",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                    ),
                ),
            ),
          ],
        ),
      ),
    );
  }
}


