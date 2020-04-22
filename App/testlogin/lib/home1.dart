import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:testlogin/Service/homePage.dart';
import 'package:testlogin/Service/logoutService.dart' as lgOut;
import 'package:testlogin/Service/loginVerification.dart' as lgIn;
import 'package:testlogin/Model/postModel.dart';
import 'Service/logoutService.dart';

int _usr;
int get usr => _usr; 

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  Future<Void> refreshlist() async {
    await Future.delayed(Duration(seconds: 2));
    fetchPostApi();
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
              SizedBox(height: 10,),
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
              Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color:Colors.grey[850],
                ),
                
                height: 550,
                child: RefreshIndicator(
                  onRefresh: refreshlist,
                  child: FutureBuilder(
                    future: fetchPostApi(),
                    builder: (BuildContext context, AsyncSnapshot<List<Post>> snapshot){
                      if(snapshot.hasData){
                        List<Post> posts = snapshot.data;
                        return ListView(
                          children: posts.map((Post post) => ListTile(
                            title: Text(
                              post.title,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 30
                                ),
                              ),
                            subtitle: Text(
                              post.description,
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 20
                                )
                              ),
                            ),
                        ).toList(),
                        );
                      }else {
                        Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                ),
              ),
              // Align(
              // alignment: Alignment.center,
              // child: FlatButton(
                 
              //   padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
              //   child: Text(
              //     'Logout',
              //     style: TextStyle(
              //       color: Colors.red,
              //       fontSize: 30
              //     ),
              //     ),
              //   shape: RoundedRectangleBorder(
              //     side: BorderSide(
              //       color: Colors.red,
              //       width: 1,
              //       style: BorderStyle.solid
              //       ), 
              //     borderRadius: BorderRadius.circular(50)),
              // )
              // ),
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
