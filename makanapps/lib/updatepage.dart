//class InsertPage
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:toast/toast.dart';
import 'data.dart';

class UpdatePage extends StatelessWidget {

  final Data data;
  // In the constructor, require a Data.
  UpdatePage({@required this.data});

  final db = Firestore.instance;

  TextEditingController _id = TextEditingController();
  TextEditingController _name = TextEditingController();
  TextEditingController _votes = TextEditingController();
  TextEditingController _price = TextEditingController();

  //TextEditingController _name, _votes, _price = TextEditingController();
  //@override
  Widget build(BuildContext context){
    //initial the TextEditingController values
    _id.text=this.data.id.toString();
    _name.text=this.data.name.toString();
    _price.text=this.data.price.toString();
    _votes.text=this.data.votes.toString();
    //our code
    return Scaffold(

      appBar: new AppBar(title: new Text('Update/Delete Menu '
          'Page'),),
      body: ListView(

        padding: EdgeInsets.all(12.0),
        children: <Widget>[
          Padding(//TextField ID
            padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 15.0),
            child: TextField(
              //initialValue: data.id,
              controller: _id,
              enabled: false,
              decoration: InputDecoration(hintText: 'enter food menu name'),
            ),
          ),
          Padding(//TextField Name
            padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 15.0),
            child: TextField(
              //initialValue: data.name,
              controller: _name,
              decoration: InputDecoration(hintText: 'enter food menu name'),
            ),
          ),
          Padding(//TextField price
            padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 15.0),
            child: TextField(
              //initialValue: data.price.toString(),
              controller: _price,
              decoration: InputDecoration(hintText: 'menu price (RM)'),
            ),
          ),
          Padding(//TextField votes
            padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 15.0),
            child: TextField(
              //initialValue: data.votes.toString(),
              controller: _votes,
              decoration: InputDecoration(hintText: 'initial vote'),
            ),
          ),
          Padding(//padding for update button
            padding: const EdgeInsets.all(10.0),
            child: RaisedButton(
              child: Text('Update'),
              color: Colors.green,
              onPressed: () async {
                //update the record form
                await db
                    .collection('makanplace')
                    .document(data.id)
                    .updateData({'name': _name.text,
                                'price':double.parse(_price.text),
                                'votes':int.parse(_votes.text.toString())});

                Toast.show("Record for :"+ _name.text+" updated!", context, duration: Toast.LENGTH_LONG, gravity:  Toast.CENTER);
              }
            ),
          ), //for update button
          Padding(//padding for delete button
            padding: const EdgeInsets.all(10.0),
            child: RaisedButton(
              child: Text('Delete!'),
              color: Colors.red,
              onPressed: () async {
                await db
                    .collection('makanplace')//firestore collection
                    .document(_id.text)//the ID
                    .delete();
                Toast.show("Record for :"+ _name.text+" deleted!", context, duration: Toast.LENGTH_LONG, gravity:  Toast.CENTER);
                Navigator.pop(context);
              },
            ),
          ), //for update button
        ],
      ),
    );
  }//end Widget

}//end InsertPage