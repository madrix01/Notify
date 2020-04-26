import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:testlogin/Model/postModel.dart';
import 'package:testlogin/Service/searchService.dart';
import 'package:testlogin/posts/postdetail.dart';

class PostSearch extends StatefulWidget {
  @override
  _PostSearchState createState() => _PostSearchState();
}

class _PostSearchState extends State<PostSearch> {
  
  List<dynamic> searchResult = [];

  searchPost(String query) async{
    fetchSearchApi(query).then((responseBody){
      List<dynamic> data = jsonDecode(responseBody);
      setState(() {
        data.forEach((query){
          searchResult.add(query);
        });
      });
    });
  }
  final searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        backgroundColor: Colors.black,
        body: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: <Widget>[
            Column(children: <Widget>[
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
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Column(
                    children: <Widget>[
                      Text(
                        "Notify",
                        style: TextStyle(
                          fontSize: 70,
                          color: Colors.black,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                            width: 290,
                            child: TextField(
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide(color:Colors.black, width:2)),
                                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide(color:Colors.black, width:2)),
                                hintText: 'Search any post',
                                filled: true,
                                fillColor: Colors.white
                               ),
                              autofocus: false,
                              controller: searchController,
                            ),
                          ),
                          SizedBox(height: 10,),
                          Container(
                            height: 60,
                            child: FlatButton(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(color: Colors.black, width:2),
                              borderRadius: BorderRadius.circular(50)),
                              onPressed: (){
                                searchResult.clear();
                                searchPost(searchController.text);
                              },
                              color: Colors.white,
                              child: Icon(Icons.search, color: Colors.grey, size: 30,),
                            ),
                          )
                        ],
                      ),
                                            
                    ]
                  ),
                )
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
              child: ListView.builder(
                itemCount: searchResult.length,
                itemBuilder: (BuildContext context, int index){
                  return buildResultCard(searchResult[index]);
                },
              ),
            )

          ],
          ),
        bottomNavigationBar: BottomAppBar(
            notchMargin: 5,
            shape: CircularNotchedRectangle(),
            child: new Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(icon: Icon(Icons.arrow_back_ios, color: Colors.white,), onPressed: () {
                  Navigator.of(context).pushNamed('/home');
                  },),
              ],
            ),
            color: Colors.grey[850],
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.create),
            elevation: 4.0,
            backgroundColor: Color(0xFF512DA8),
            onPressed: (){
              Navigator.of(context).pushNamed('/addPost');
            },
          ),
 
      ),
      );
  }
}

Widget buildResultCard(data){
  return Column(
    children: <Widget>[
      ListTile(
        title: Text(
          data['title'],
          style: TextStyle(
            color: Colors.white,
            fontSize: 30
            ),
          ),
        subtitle: Text(
          data['description'].toString(),
          style: TextStyle(
            color: Colors.grey,
            fontSize: 20
            ),
          ),
      ),
    ]
  );
}