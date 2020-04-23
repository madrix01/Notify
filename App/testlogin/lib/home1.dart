import 'dart:ffi';
import 'package:testlogin/posts/posts.dart';
import 'package:flutter/material.dart';
import 'package:testlogin/Service/homePage.dart';
import 'package:testlogin/Service/logoutService.dart' as lgOut;
import 'package:testlogin/Service/loginVerification.dart' as lgIn;
import 'package:testlogin/Model/postModel.dart';
import 'Service/logoutService.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:testlogin/posts/myposts.dart';

int _usr;
int get usr => _usr; 

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}
class _HomePageState extends State<HomePage>{
  Future<Void> refreshlist() async {
    await Future.delayed(Duration(seconds: 2));
    fetchPostApi();
  }
  TabController _controller;

  @override
  void dispose(){
    _controller.dispose();
    super.dispose();
  }

  _makeLogoutwithSharedPreferences(var context)async{
  SharedPreferences currentInstance = await SharedPreferences.getInstance();
  await currentInstance.setBool('loginStatus', false);

  Navigator.pushNamed(context, '/');
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()=> Future.value(false) ,
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomPadding: false,
          backgroundColor: Color(0xFF1c1c1c),
          body: Column(
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
              margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: Align(
                alignment: Alignment.center,
                child:
                    Text(
                      "Notify",
                      style: TextStyle(
                        fontSize: 50,
                        color: Colors.black,
                        fontWeight: FontWeight.bold
                      ),
                    ),
              ),
            ),
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
            SizedBox(height: 10,),
              Container(
                height: 600,
                child: DefaultTabController(
                  length: 2,                
                  child: TabBarView(
                    controller: _controller,
                    children: <Widget>[
                      Posts(),
                      MyPosts(),
                  ],
              ),
                ),
                ),
            ],
          ),
          bottomNavigationBar: BottomAppBar(
            notchMargin: 5,
            shape: CircularNotchedRectangle(),
            child: new Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(icon: Icon(Icons.lock_outline, color: Colors.white,),
                onPressed: (){
                    _makeLogoutwithSharedPreferences(context);
                   makeLogoutRequest(lgIn.token);
                   Navigator.of(context).pushNamed('/second');
                   print(lgIn.token);
                 },
                ),
                IconButton(icon: Icon(Icons.search, color: Colors.white,), onPressed: () {},),
              ],
            ),
            color: Colors.grey[850],
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.create),
            elevation: 4.0,
            backgroundColor: Colors.redAccent,
            onPressed: (){
              Navigator.of(context).pushNamed('/addPost');
            },
          ),
        ),
      ),
    );
  }
}
