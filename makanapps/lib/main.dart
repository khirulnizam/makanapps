import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'insertpage.dart';
import 'updatepage.dart';

void main() => runApp(MyApp());

final dummySnapshot = [
  {"name": "Nasi Goreng", "votes": 15},
  {"name": "Ayam Kumnyit", "votes": 14},
  {"name": "Ratatuile", "votes": 11},
  {"name": "Kangkung Masin", "votes": 10},
  {"name": "Kailan Goreng", "votes": 1},
];

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MakanApps',
      home: MyHomePage(),
      routes: <String, WidgetBuilder>{
        '/insertpage' : (BuildContext context) => new InsertPage(),
        '/updatepage' : (BuildContext context) => new UpdatePage(),
      },

    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('MakanApps Votes')),
      body: _buildBody(context),

      //flaoting button
        floatingActionButton: FloatingActionButton(
            onPressed: (){
              Navigator.of(context).pushNamed('/insertpage');
            },
          child: Icon(Icons.add),
          backgroundColor: Colors.green,
        ),

    );
  }

  Widget _buildBody(BuildContext context) {
    // TODO: get actual snapshot from Cloud Firestore
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('makanplace').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();

        return _buildList(context, snapshot.data.documents);
      },
    );
    //return _buildList(context, dummySnapshot);
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final record = Record.fromSnapshot(data);

    return Padding(
      key: ValueKey(record.name),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: ListTile(
          title: Text(record.name),
          leading: Icon(Icons.fastfood),
          subtitle: Text("Price: RM"+record.price.toString()),
          trailing: Text(record.votes.toString()),
            onTap: () => record.reference.updateData({'votes': record.votes + 1}),
            onLongPress: ()=>Navigator.of(context).pushNamed('/updatepage'),//will call update page
        ),
      ),
    );
  }
}

class Record {
  final String name;
  final int votes;
  final double price;
  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['name'] != null),
        assert(map['votes'] != null),
        assert(map['price'] != null),
        name = map['name'],
        price = map['price'],
        votes = map['votes'];

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Record<$name:$price:$votes>";
}