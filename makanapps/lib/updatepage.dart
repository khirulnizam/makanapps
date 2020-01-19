//class InsertPage
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:toast/toast.dart';

class UpdatePage extends StatelessWidget {

  final db = Firestore.instance;
  TextEditingController _name = TextEditingController();
  TextEditingController _votes = TextEditingController();
  TextEditingController _price = TextEditingController();
  //TextEditingController _name, _votes, _price = TextEditingController();
  //@override
  Widget build(BuildContext context){
    //our code
    return Scaffold(
      appBar: new AppBar(title: new Text('Update Menu '
          'Page'),),
      body: ListView(
        padding: EdgeInsets.all(12.0),
        children: <Widget>[
          Padding(//TextField ID
            padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 15.0),
            child: TextField(
              controller: _name,
              decoration: InputDecoration(hintText: 'enter food menu name'),
            ),
          ),
          Padding(//TextField name
            padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 15.0),
            child: TextField(
              controller: _price,
              decoration: InputDecoration(hintText: 'menu price (RM)'),
            ),
          ),
          Padding(//TextField name
            padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 15.0),
            child: TextField(
              controller: _votes,
              decoration: InputDecoration(hintText: 'initial vote'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: RaisedButton(
              child: Text('Update'),
              color: Colors.green,
              onPressed: () async {
                //auto-id provided by firestore
                await db.collection('makanplace')
                    .add({'name': _name.text,
                  'price': double.parse(_price.text.toString()),
                  'votes': int.parse(_votes.text.toString())});
                Toast.show("Firebase add", context, duration: Toast.LENGTH_LONG, gravity:  Toast.CENTER);
              },
            ),
          ),

        ],
      ),
    );
  }//end Widget

}//end InsertPage