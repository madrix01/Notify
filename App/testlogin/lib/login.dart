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
                            "Login",
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
                      Container(
                        height: 50,
                        width: 320,
                        child: TextField(
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide(color:Colors.black, width:2)),
                            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide(color:Colors.black, width:2)),
                            border: OutlineInputBorder(),
                            hintText: 'Admission No.',
                            fillColor: Colors.white,
                            filled: true,
                           ),
                          autofocus: false,
                          controller: admnController,
                        ),
                      ),
                    //Password field
                      SizedBox(height: 20),
                      Container(
                        height: 50,
                        width: 320,
                        child: TextField(
                          obscureText: true,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide(color:Colors.black, width:2)),
                            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide(color:Colors.black, width:2)),
                            border: OutlineInputBorder(),
                            hintText: 'Password',
                            filled: true,
                            fillColor: Colors.white
                           ),
                          autofocus: false,
                          controller: pswdController,
                    ),
                      ),
                    SizedBox(height: 20,),
                    Align(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        FlatButton(
                          color: Color(0xFF512da8),
                          padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                          child: Icon(Icons.lock_open, color: Colors.white,),
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
                              SizedBox(height: 30,),
                      Align(
                        alignment: Alignment.center,
                          child: GestureDetector(
                            onTap: (){
                              Navigator.of(context).pushNamed('/');
                            },
                            child: FlatButton(
                              color: Color(0xFF512da8),
                              padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                              child: Icon(Icons.person_add, color: Colors.white,),
                              shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                              onPressed: (){
                                Navigator.of(context).pushNamed('/');
                              },
                              ),
                          ),
                      ),
                      ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20,),
            ],
          ),
        ),
      ),
    );
  }
}
