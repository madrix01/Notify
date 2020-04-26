import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:testlogin/posts/myposts.dart';
import 'package:testlogin/Model/postModel.dart';

class PostDetail extends StatelessWidget {
  final Post post;
  const PostDetail({Key key, this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    String date = post.timepost.substring(0,10);
    String time = post.timepost.substring(12,19);

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        backgroundColor: Color(0xFF1c1c1c),
        body: Stack(
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
              ],
            ),
                  Column(
            children: <Widget>[
          Container(
            width: double.maxFinite,
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color:Colors.grey[850],
            ),
            height: 700,
            child: Column(
              children: <Widget>[
                Text(
                  post.title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 50
                  ),
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      date,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 20
                      ),
                      ),
                      Text(
                      time,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 20
                      ),
                      ),
                  ],
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    post.description,
                    style: TextStyle(
                      color: Colors.redAccent,
                      fontSize: 30
                    ),
                    ),
                ),
                Text(
                  post.user_id.toString(),
                  style: TextStyle(
                  color: Colors.grey,
                  fontSize: 20
                ),
                      ),
              ]
            ),
          )
          ],
          ),
            ],),
        ),
      );
  }
}