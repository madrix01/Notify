import 'package:flutter/material.dart';
import 'package:testlogin/Service/postService.dart' as ps;
import 'package:testlogin/Service/loginVerification.dart' as lgin ;

class CreatePost extends StatefulWidget {
  @override
  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {

  final titleCtrl = TextEditingController();
  final descriptionCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                          SizedBox(height: 130,),
                          Text(
                            "Add Post",
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
                height: 220,
                width: double.maxFinite,
                child: Column(
                  children: <Widget>[
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
                          hintText: 'Short and Sweet title',
                         ),
                        autofocus: false,
                        controller: titleCtrl,
                      ),
                    ),
                    SizedBox(height: 20,),
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
                          hintText: 'Description > no longer than 69',
                         ),
                        autofocus: false,
                        controller: descriptionCtrl,
                      ),
                    ),
                    SizedBox(height:15),
                    Align(
                      alignment: Alignment.center,
                      child: FlatButton(
                        padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                        color: Color(0xFF512da8),
                        child: Icon(Icons.create, color: Colors.white,),
                        shape:RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)
                        ),
                        onPressed: () async {
                          int state = await ps.makeNewRequest(titleCtrl.text, descriptionCtrl.text, lgin.token);
                          print("[state $state]");
                          if(state == 201){
                            print('Request made');
                            Navigator.of(context).pushNamed('/home');
                          } else {
                            showDialog(
                              context: context,
                              builder: (_) =>
                              AlertDialog(
                                actions: <Widget>[FlatButton(child: Text('Ok'),onPressed:(){Navigator.of(context).pop();},)],
                                backgroundColor: Colors.black,
                                title: Text(
                                  "Registration Error",
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 15
                                  ),
                                  ),
                              )
                            );
                          }

                        },
                        ),
                    )
                  ],
                  ),
                ),
          ],
        ),
      ),
    );
  }
}