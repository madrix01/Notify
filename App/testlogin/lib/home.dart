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
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomPadding: false,
          backgroundColor: Color(0xFF1c1c1c),
          body:
          Stack(
            alignment: AlignmentDirectional.centerEnd,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(50),
                        bottomRight: Radius.circular(50),
                      ),
                      gradient: LinearGradient(
                        colors: [Color(0xFF512da8), Color(0xFFB388FF)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight
                      ),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0.0, 1.0), //(x,y)
                          blurRadius: 6.0,
                      ),
                      ],
                    ),
                  width: double.maxFinite,
                  height: 400,
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: Align(
                      alignment: Alignment.center,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Notify",
                            style: TextStyle(
                              fontSize: 70,
                              color: Colors.black,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          SizedBox(height: 90,),
                          Text(
                            "Sign Up",
                            style: TextStyle(
                              fontSize: 40,
                              color: Colors.black,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ]
              ),
              Container(
                height: 300,
                  padding: EdgeInsets.all(20),
                  margin: EdgeInsets.all(20),
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
                      Container(
                        height: 50,
                        width: 320,
                        child: TextField(
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide(color:Colors.black, width:2)),
                            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide(color:Colors.black, width:2)),
                            border: OutlineInputBorder(),
                            hintText: '8 digit admission no.',
                           ),
                          autofocus: false,
                          controller: myController,
                        ),
                      ),
                       SizedBox(height: 20,),
                //email field
                      Container(
                        height: 50,
                        width: 320,
                        child: TextField(
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide(color:Colors.black, width:2)),
                            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide(color:Colors.black, width:2)),
                            border: OutlineInputBorder(),
                            hintText: 'Email for for Updates',
                           ),
                          autofocus: false,
                          controller: emailController,
                        ),
                      ),
                       SizedBox(height: 20,),
                //Password field
                      Container(
                        height: 50,
                        width: 320,
                        child: TextField(
                          obscureText: true,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide(color:Colors.black, width:2)),
                            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide(color:Colors.black, width:2)),
                            border: OutlineInputBorder(),
                            hintText: 'Password Longer than 8 charecters',
                           ),
                          autofocus: false,
                          controller: pswdController,
                        ),
                      ),
                      SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Align(
                          alignment: Alignment.center,
                          child: FlatButton(
                            color: Color(0xFF512da8),
                            padding: EdgeInsets.all(10),
                            child: Icon(Icons.person_add, color: Colors.white,),
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
                        Align(
                          alignment: Alignment.center,
                          child: GestureDetector(
                            onTap: (){
                              Navigator.of(context).pushNamed('/');
                            },
                            child: FlatButton(
                              color: Color(0xFF512da8),
                              padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                              child: Icon(Icons.lock_open, color: Colors.white,),
                              shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                              onPressed: (){
                                Navigator.of(context).pushNamed('/second');
                              },
                              ),
                          ),
                        ),
                        ],
                      ),
                      
                    ],
                  ),
                ),
            ]  
          ),
        ),
      ),
    );
  }
}


