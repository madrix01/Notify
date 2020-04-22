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
    WillPopScope(
      onWillPop: () => Future.value(false),
      child: SafeArea(
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
              SizedBox(height:30),
              //Admission no.
              Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                borderRadius: new BorderRadius.circular(20),
                color: Colors.grey[850],
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0.0, 1.0), //(x,y)
                    blurRadius: 6.0,
                  ),
                ]
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
                       ),
                      autofocus: false,
                      controller: admnController,
                    ),
              //Password field
                    SizedBox(height: 10),
                    TextField(
                      obscureText: true,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide(color:Colors.black, width:2)),
                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide(color:Colors.black, width:2)),
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                       ),
                      autofocus: false,
                      controller: pswdController,
                  ),
                    
                  ],
                ),
              ),
              SizedBox(height: 20,),
              Align(
                  alignment: Alignment.center,
                  child: FlatButton(
                    color: Colors.redAccent,
                    padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                    child: Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30
                        ),
                      ),

                    shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)),
                    onPressed: () async{
                      int sc = await Ts.makeLoginRequest(admnController.text, pswdController.text); 
                      print("sc = $sc");
                      if(sc == 200){
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
                    child: Text(
                      "Register Instead",
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
      ),
    );
  }
}
