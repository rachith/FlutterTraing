import 'package:example_training/example/my_app.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {

  //Counter is user to pass the value from home page to profile page
  int counter;
  ProfilePage({Key key, this.counter}) : super(key: key);


  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  //This is profile page build widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile Screen"),
       // automaticallyImplyLeading: false,
      /*  Builder(
             builder: (BuildContext context) {
               return IconButton(
                 icon: const Icon(Icons.ac_unit),
                 onPressed: () { Navigator.pop(context); },
                 tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
               );
             },
           ),*/
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Counter value:',
              style: TextStyle(color: Colors.black,fontSize: 16.0),
            ),
            Text(
              '${widget.counter}',
              style: TextStyle(color: Colors.amberAccent,fontSize: 20.0),
            ),
          ],
        ),
      ),
        floatingActionButton: FloatingActionButton(
          onPressed:(){
            Navigator.pop(context);
          },
          tooltip: 'back',
          child: Icon(Icons.arrow_back),
        ),
    );
  }
}