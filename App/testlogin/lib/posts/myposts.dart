import 'package:flutter/material.dart';
import 'package:testlogin/Service/myPostService.dart';
import 'package:testlogin/Model/postModel.dart';
import 'package:testlogin/posts/postdetail.dart';

class MyPosts extends StatefulWidget {
  @override
  _MyPostsState createState() => _MyPostsState();
}

class _MyPostsState extends State<MyPosts> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          "My Post",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20
          ),
          ),
        Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color:Colors.grey[850],
          ),
          
          height: 550,
          child: FutureBuilder(
              future: fetchMyPost(),
              builder: (BuildContext context, AsyncSnapshot<List<Post>> snapshot){
                if(snapshot.hasData){
                  List<Post> posts = snapshot.data;
                  return ListView(
                    children: posts.map((Post post) => ListTile(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => PostDetail(
                            post : post,
                          )
                        )
                      ),
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
                return Center(child: CircularProgressIndicator());
              },
            ),
        ),
      ],
    );
  }
}