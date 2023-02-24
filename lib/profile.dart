import 'package:example_training/example/my_app.dart';
import 'package:example_training/show_toast.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {

  //Counter is user to pass the value from home page to profile page
  int counter;
  ProfilePage({Key key, this.counter}) : super(key: key);


  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String email="", password="";

  @override
  void initState() {
    // TODO: implement initState
  getData();
    super.initState();
  }

  getData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      email = prefs.get("email");
      password = prefs.get("pswd");
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }


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
              'Email Address',
              style: TextStyle(color: Colors.black,fontSize: 16.0),
            ),
            Text(
              email,
              style: TextStyle(color: Colors.amberAccent,fontSize: 20.0),
            ),
            Text(
              'Password',
              style: TextStyle(color: Colors.black,fontSize: 16.0),
            ),
            Text(
              password,
              style: TextStyle(color: Colors.amberAccent,fontSize: 20.0),
            ),
          ],
        ),
      ),
        floatingActionButton: FloatingActionButton(
          onPressed:() async {
            ShowToast.showToast("You have logged out!!!!");
            final prefs = await SharedPreferences.getInstance();
            prefs.setBool("login", false);
            Navigator.pushNamed(context, 'myLogin');
          },
          tooltip: 'back',
          child: Icon(Icons.arrow_back),
        ),
    );
  }
}