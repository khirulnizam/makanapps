//class InsertPage
import 'package:flutter/material.dart';

class InsertPage extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    //our code
    return Scaffold(
      appBar: new AppBar(title: new Text('Insert Page'),),
      body: new Center(
        //elements here
        child: new Column(
          children: <Widget>[
            new RaisedButton(
                child: const Text('Go to main'),
                onPressed: (){

                  //navigate to PageTwo by router
                  //Navigator.of(context).pushNamed('/page2');
                  //Navigator.push(context,
                  //  MaterialPageRoute(builder: (context)=> PageTwo())
                  //);

                }
            ), //RaisedButton to p1

            new RaisedButton(
                child: const Text('Pergi ke Laman3'),
                onPressed: (){

                  //navigate to PageThree by router
                  //Navigator.of(context).pushNamed('/page3');
                  //Navigator.push(context,
                  //  MaterialPageRoute(builder: (context)=> PageThree())
                  //);

                }
            ), //RaisedButton to p3

          ],
        ),
      ),
    );
  }//end Widget

}//end PageTwo