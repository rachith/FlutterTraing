import 'package:example_training/profile.dart';
import 'package:example_training/register.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
   bool login = prefs.get("login");
  runApp(
    MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: login!=null ? login == true ? 'profile' : 'register' : 'register',
        routes: {
          'myLogin': (context) => const MyLogin(),
          'register': (context) => const MyRegister(),
          'profile': (context) => ProfilePage(),
        }),
  );
}
