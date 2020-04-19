import 'package:flutter/material.dart';
import 'package:testlogin/Service/homePage.dart';
import 'package:testlogin/Service/logoutService.dart' as lgOut;
import 'package:testlogin/Service/loginVerification.dart' as lgIn;

import 'Service/logoutService.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()=> Future.value(false) ,
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        backgroundColor: Color(0xFF131313),
        body: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Container(
                color: Colors.red,
                height: 160,
                width: double.maxFinite,
                padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
                child: Center(
                  child: Text(
                    "Notify",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 50,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Welcome,",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(width: 10,),
                FutureBuilder<List<TestApi>>(
                    future: fetchTestApi(),
                    builder: (BuildContext context,AsyncSnapshot<List<TestApi>> snapshot){
                      if (snapshot.hasData){
                        List<TestApi> apis = snapshot.data;
                          return Text(
                              apis[0].username.toUpperCase(),
                              style:
                                TextStyle(
                                  color: Color(0xFF00D7EC),
                                  fontSize: 30
                              ),
                            );
                        } else if (snapshot.hasError){
                          return Text('${snapshot.error}');
                        }
                        return CircularProgressIndicator();
                    },
                  ),
              ],
            ),
            Align(
            alignment: Alignment.center,
            child: FlatButton(
              onPressed: (){
                makeLogoutRequest(lgIn.token);
                Navigator.of(context).pushNamed('/second');
                print(lgIn.token);
              },
              padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
              child: Text(
                'Logout',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 30
                ),
                ),
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: Colors.red,
                  width: 1,
                  style: BorderStyle.solid
                  ), 
                borderRadius: BorderRadius.circular(50)),
            )
            ),
          ],
        )
      ),
    );
  }
}