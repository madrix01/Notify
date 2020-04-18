import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:testlogin/login.dart';
import 'package:testlogin/routeGenerator.dart';
import 'package:testlogin/Service/registration.dart' as reg ;
import 'package:bordered_text/bordered_text.dart';


class NoteList extends StatefulWidget {
  @override
  _NoteListState createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {

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
    return
    SafeArea(
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        backgroundColor: Color(0xFF3c3c3c),
        body:
        Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0.0, 1.0), //(x,y)
                    blurRadius: 6.0,
                  ),
                ],
                color: Color(0xFFBC7EFF),
                borderRadius: new BorderRadius.only(bottomLeft: Radius.circular(80)),
                border:Border.all(
                  color: Color(0xFF000000), 
                  width: 5,
                )),
              height: 160,
              width: double.maxFinite,
              padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
              child: Center(
                child: Text(
                  "Notify",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Ubuntu"
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
                  child: BorderedText(
                    strokeColor: Colors.black,
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
            ),
            SizedBox(height:30),
            //Admission no.
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0.0, 1.0), //(x,y)
                    blurRadius: 6.0,
                  ),
                ],
                color: Color(0xFFBC7EFF),
                borderRadius: BorderRadius.all(Radius.circular(30)),
                border:Border.all(
                  color: Color(0xFF000000), 
                  width: 5,
                )),
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.topLeft,
                    child: BorderedText(
                      strokeColor: Colors.black,
                      child: Text(
                        "Admission No.",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                        ),
                        ),
                    ),
                  ),
                  SizedBox(height: 5),
                  TextField(
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      hintStyle: TextStyle(color: Colors.black),
                      filled: true,
                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide(color:Colors.black, width:5)),
                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide(color:Colors.black, width:5)),
                    ),
                  ),
                   SizedBox(height: 10,),
            //email field
            Align(
                    alignment: Alignment.topLeft,
                    child: BorderedText(
                      strokeColor: Colors.black,
                      child: Text(
                        "E-mail",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                        ),
                        ),
                    ),
                  ),
                  SizedBox(height: 5),
                  TextField(
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      hintStyle: TextStyle(color: Colors.black),
                      filled: true,
                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide(color:Colors.black, width:5)),
                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide(color:Colors.black, width:5)),
                    ),
                    controller: emailController,
                  ),
                   SizedBox(height: 10,),
            //Password field
                  Align(
                    alignment: Alignment.topLeft,
                    child: BorderedText(
                      strokeColor: Colors.black,
                      child: Text(
                        "Password",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                        ),
                        ),
                    ),
                  ),
                  SizedBox(height: 5),
                  TextField(
                    obscureText: true,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintStyle: TextStyle(color: Colors.red),
                      filled: true,
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide(color:Colors.black, width:5)),
                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide(color:Colors.black, width:5)),
                    ),
                    controller: pswdController,
                  ),
                  SizedBox(height:20),
                  
                ],
              ),
            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.center,
              child: FlatButton(
                color: Color(0xFFBC7EFF),
                padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                child: BorderedText(
                  strokeColor: Colors.black,
                    child: Text(
                    'Sign Up',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30
                    ),
                    ),
                ),
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: Colors.black,
                    width: 5,
                    style: BorderStyle.solid
                    ), 
                  borderRadius: BorderRadius.circular(50)),
                onPressed: (){
                  reg.makePostRequest(myController.text, emailController.text, pswdController.text);
                  int state = reg.statusCode;
                  if(state == 200){
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
                  child: BorderedText(
                    strokeColor: Colors.black,
                    child: Text(
                    "Login Instead",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
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


