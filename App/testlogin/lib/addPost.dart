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
    return Scaffold(
      backgroundColor: Color(0xFF1c1c1c),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                borderRadius: new BorderRadius.circular(20),
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
              height: 250,
              width: double.maxFinite,
              child: Column(
                children: <Widget>[
                  TextField(
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide(color:Colors.black, width:2)),
                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide(color:Colors.black, width:2)),
                      border: OutlineInputBorder(),
                      labelText: 'Title',
                      hintText: 'Short and Sweet title',
                     ),
                    autofocus: false,
                    controller: titleCtrl,
                  ),
                  SizedBox(height: 15,),
                  TextField(
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide(color:Colors.black, width:2)),
                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide(color:Colors.black, width:2)),
                      border: OutlineInputBorder(),
                      labelText: 'Description',
                      hintText: 'No longer than 69',
                     ),
                    autofocus: false,
                    controller: descriptionCtrl,
                  ),
                  SizedBox(height:15),
                  Align(
                    alignment: Alignment.center,
                    child: FlatButton(
                      color: Colors.redAccent,
                      child: Text("POST"),
                      shape: RoundedRectangleBorder(
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
        )
      ),
    );
  }
}