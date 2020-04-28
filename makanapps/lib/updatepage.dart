//class InsertPage
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:toast/toast.dart';
import 'data.dart';
import 'dart:developer';//print log


class UpdatePage extends StatelessWidget {

  final Data data;
  bool confirmdelete=false;

  // In the constructor, require a Data.
  //capture data parameters
  UpdatePage({@required this.data});

  final db = Firestore.instance;

  TextEditingController _id = TextEditingController();
  TextEditingController _name = TextEditingController();
  TextEditingController _votes = TextEditingController();
  TextEditingController _price = TextEditingController();


  //TextEditingController _name, _votes, _price = TextEditingController();
  //@override
  Widget build(BuildContext context) {
    //initial the TextEditingController values
    _id.text = this.data.id.toString();
    _name.text = this.data.name.toString();
    _price.text = this.data.price.toString();
    _votes.text = this.data.votes.toString();
    //our code
    return Scaffold(

      appBar: new AppBar(title: new Text('Update/Delete Menu '
          'Page'),),
      body: ListView(

        padding: EdgeInsets.all(12.0),
        children: <Widget>[
          Padding( //TextField ID
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
            child: TextField(
              //initialValue: data.id,
              controller: _id,
              enabled: false,
              decoration: InputDecoration(hintText: 'id'),
            ),
          ),
          Padding( //TextField Name
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
            child: TextField(
              //initialValue: data.name,
              controller: _name,
              decoration: InputDecoration(hintText: 'Menu title'),
            ),
          ),
          Padding( //TextField price
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
            child: TextField(
              //initialValue: data.price.toString(),
              controller: _price,
              decoration: InputDecoration(hintText: 'Price (RM)'),
            ),
          ),
          Padding( //TextField votes
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
            child: TextField(
              //initialValue: data.votes.toString(),
              controller: _votes,
              decoration: InputDecoration(hintText: 'votes'),
            ),
          ),
          Padding( //padding for update button
            padding: const EdgeInsets.all(10.0),
            child: RaisedButton(
                child: Text('Update record'),
                color: Colors.orange,
                onPressed: ()  {
                  //update the record form
                  this.updateRec(context, data.id);

                  Toast.show("Record : "+ _name.text+" updated!", context, duration: Toast.LENGTH_LONG, gravity:  Toast.CENTER);
                }
            ),
          ), //for update button
          Padding( //padding for delete button
            padding: const EdgeInsets.all(10.0),
            child: RaisedButton(
              child: Text('Delete!'),
              color: Colors.red,
              onPressed: (){
                //call confirmation dialog box
                _showDialog(context);

              }, //end async await
            ),
          ), //for update button
        ],
      ),
    );
  } //end Widget

  // developer's defined function
  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Alert"),
          content: new Text("Confirm to delete record?"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("YES DELETE!"),//positive
              onPressed: () {
                this.deleteRec(context,data.id);
                Toast.show(
                    "Record: " + data.id + " deleted!",
                    context,
                    duration: Toast.LENGTH_LONG,
                    gravity: Toast.CENTER);
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: new Text("abort"),//abort
              onPressed: () {
                Toast.show(
                    "Abort!",
                    context,
                    duration: Toast.LENGTH_LONG,
                    gravity: Toast.CENTER);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );

  }//end function _showDialog

  //function to update record
  Future updateRec(context,id) async{
    final doc=Firestore.instance
        .collection("makanplace")
        .document(id);

    return await doc.updateData({'name': _name.text,
      'price': double.parse(_price.text),
      'votes': int.parse(_votes.text)});
  }//end deleteRec

  //function to delete record
  Future deleteRec(context,id) async{
    final doc=Firestore.instance
        .collection("makanplace")
        .document(id);

    return await doc.delete();
  }//end deleteRec
}//end UpdatePage with Delete
