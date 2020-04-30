import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email;
  String _password;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: Center(
          child: Container(
              padding: EdgeInsets.all(25.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image(image: AssetImage('unlockfstm.png')),
                  TextField(
                      decoration: InputDecoration(hintText: 'Email'),
                      onChanged: (value) {
                        setState(() {
                          _email = value;
                        });
                      }),
                  SizedBox(height: 15.0),
                  TextField(
                    decoration: InputDecoration(hintText: 'Password'),
                    onChanged: (value) {
                      setState(() {
                        _password = value;
                      });
                    },
                    obscureText: true,
                  ),
                  SizedBox(height: 20.0),
                  RaisedButton(
                    child: Text('Login'),
                    color: Colors.blue,
                    textColor: Colors.white,
                    elevation: 7.0,
                    onPressed: () {
                      FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                          email: _email, password: _password)
                          .then((AuthResult auth) {
                              //email
                              //auth.user
                              _showDialog(context, auth.user.email);
                              //after authenticated redirect to updatepage
                              //Navigator.of(context).pushReplacementNamed('/insertpage');
                            }).catchError((e) {
                        print(e);
                      });
                    },
                  ),

                ],
              )),
        ));


  }


  //display username popup
  void _showDialog(BuildContext context, uname) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Selamat Datang"),
          content: new Text("Pengguna: "+uname),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("OK"),//positive
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushReplacementNamed('/homepage');
              },
            ),
          ],
        );
      },
    );

  }//end function _showDialog
}