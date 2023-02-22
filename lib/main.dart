import 'package:example_training/profile.dart';
import 'package:example_training/register.dart';
import 'package:flutter/material.dart';
import 'login.dart';

void main() {
  runApp(
    MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: 'register',
        routes: {
          'myLogin': (context) => const MyLogin(),
          'register': (context) => const MyRegister(),
          'profile': (context) => ProfilePage(),
        }),
  );
}
