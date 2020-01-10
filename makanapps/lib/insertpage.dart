//class InsertPage
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class InsertPage extends StatelessWidget{
  final db = Firestore.instance;
  TextEditingController _name, _votes, _price = TextEditingController();
  @override
  Widget build(BuildContext context){
    //our code
    return Scaffold(
      appBar: new AppBar(title: new Text('Insert Page'),),
      body: ListView(
        padding: EdgeInsets.all(12.0),
        children: <Widget>[
          Padding(//TextField ID
            padding: EdgeInsets.symmetric(vertical: 15.0),
            child: TextField(
              controller: _name,
              decoration: InputDecoration(hintText: 'enter food menu name'),
            ),
          ),
          Padding(//TextField name
            padding: EdgeInsets.symmetric(vertical: 15.0),
            child: TextField(
              controller: _price,
              decoration: InputDecoration(hintText: 'enter menu price'),
            ),
          ),
          Padding(//TextField name
            padding: EdgeInsets.symmetric(vertical: 15.0),
            child: TextField(
              controller: _votes,
              decoration: InputDecoration(hintText: 'initial vote'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RaisedButton(
              child: Text('Add'),
              color: Colors.green,
              onPressed: () async {
                //auto-id provided by firebase
                await db.collection('makanplace')
                .add({'name': _name.text,
                  'price': _price.text,
                  'votes': _votes.text}
                );
              },
            ),
          ),
          SizedBox(height: 20.0),
          StreamBuilder<QuerySnapshot>(
              stream: db.collection('makanplace').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: snapshot.data.documents.map((doc) {
                      return ListTile(title: Text(doc.data['name']));
                    }).toList(),
                  );
                } else {
                  return SizedBox();
                }
              }),
        ],
      ),
    );
  }//end Widget

}//end PageTwo