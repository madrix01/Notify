import 'package:flutter/material.dart';
import 'package:testlogin/Service/loginVerification.dart' as Ts;
import 'package:bordered_text/bordered_text.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final admnController = TextEditingController();
  final pswdController = TextEditingController();

  void fieldClear(){
    admnController.clear();
    pswdController.clear();
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
                    'Login',
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
                  SizedBox(height: 10),
                  TextField(
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      hintStyle: TextStyle(color: Colors.black),
                      filled: true,
                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide(color:Colors.black, width:5)),
                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide(color:Colors.black, width:5)),
                    ),
                    controller: admnController,
                  ),
                   SizedBox(height: 20,),
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
                  SizedBox(height: 10),
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
                  SizedBox(height:30),
                  
                ],
              ),
            ),
            SizedBox(height: 20,),
            Align(
                alignment: Alignment.center,
                child: FlatButton(
                  color: Color(0xFFBC7EFF),
                  padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                  child: BorderedText(
                    strokeColor: Colors.black,
                    child: Text(
                      'Login',
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
                    Ts.makeLoginRequest(admnController.text, pswdController.text);
                    print(Ts.token);
                    if(Ts.token != null){
                      Navigator.of(context).pushNamed('/home');
                    } else{
                      showDialog(
                        context: context,
                        builder: (_) => 
                      AlertDialog(
                        actions: <Widget>[FlatButton( child: Text('Ok'), onPressed:(){Navigator.of(context).pop();} ),],
                        backgroundColor: Colors.black,
                        title: Text(
                          'Wrong Username or Password',
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
                    Navigator.of(context).pushNamed('/');
                  },
                  child: BorderedText(
                    strokeColor: Colors.black,
                    child: Text(
                    "Register Instead",
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
