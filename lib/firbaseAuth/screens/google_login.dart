import 'dart:async';
import 'dart:convert' show json;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_training/firbaseAuth/models/user_data.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

GoogleSignIn _googleSignIn = GoogleSignIn(
  // Optional clientId
  // clientId: '479882132969-9i9aqik3jfjd7qhci1nqf0bm2g71rm1u.apps.googleusercontent.com',
  scopes: <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);


class GoogleLogin extends StatefulWidget {
  const GoogleLogin({Key key}) : super(key: key);

  @override
  State createState() => SignInDemoState();
}

class SignInDemoState extends State<GoogleLogin> {
  GoogleSignInAccount _currentUser;
  String _contactText = '';
  UserData usr;

  @override
  void initState() {
    super.initState();
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
      setState(() {
        _currentUser = account;
        storeData();
      });
      if (_currentUser != null) {
        _handleGetContact(_currentUser);
      }
    });
    _googleSignIn.signInSilently();
  }

  Future<void> storeData() async {
    await FirebaseFirestore.instance.collection("Users").doc(_currentUser.id).set({
      'Name': _currentUser.displayName,
      'email': _currentUser.email,
      'profile_image': _currentUser.photoUrl}).then((value) => {
      print("Data has been added")
    });
  }

  Future<void> _handleGetContact(GoogleSignInAccount user) async {

    await FirebaseFirestore.instance.collection("Users").doc(_currentUser.id).get().then((value) =>{

     usr = UserData.fromJson(value.data()),

      print("UserEmail: ${usr.email}")
    });
    setState(() {
      _contactText = 'Loading contact info...';
    });
    final http.Response response = await http.get(
      Uri.parse('https://people.googleapis.com/v1/people/me/connections'
          'requestMask.includeField=person.names'),
      headers: await user.authHeaders,
    );
    if (response.statusCode != 200) {
      setState(() {
        _contactText = 'People API gave a ${response.statusCode} '
            'response. Check logs for details.';
      });
      print('People API ${response.statusCode} response: ${response.body}');
      return;
    }
    final Map<String, dynamic> data =
    json.decode(response.body) as Map<String, dynamic>;
    final String namedContact = _pickFirstNamedContact(data);
    setState(() {
      if (namedContact != null) {
        _contactText = 'I see you know $namedContact!';
      } else {
        _contactText = 'No contacts to display.';
      }
    });
  }

  String _pickFirstNamedContact(Map<String, dynamic> data) {
    final List<dynamic> connections = data['connections'] as List<dynamic>;
    final Map<String, dynamic> contact = connections.firstWhere(
          (dynamic contact) => (contact as Map<Object, dynamic>)['names'] != null,
      orElse: () => null,
    ) as Map<String, dynamic>;
    if (contact != null) {
      final List<dynamic> names = contact['names'] as List<dynamic>;
      final Map<String, dynamic> name = names.firstWhere(
            (dynamic name) =>
        (name as Map<Object, dynamic>)['displayName'] != null,
        orElse: () => null,
      ) as Map<String, dynamic>;
      if (name != null) {
        return name['displayName'] as String;
      }
    }
    return null;
  }

  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      print(error);
    }
  }

  Future<void> _handleSignOut() => _googleSignIn.disconnect();

  Widget _buildBody() {
    final GoogleSignInAccount user = _currentUser;
    if (user != null) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          ListTile(
            leading: GoogleUserCircleAvatar(
              identity: user,
            ),
            title: Text(user.displayName),
            subtitle: Text(user.email),
          ),
          const Text('Signed in successfully.'),
         // Text(_contactText),
          ElevatedButton(
            onPressed: _handleSignOut,
            child: const Text('SIGN OUT'),
          ),
          ElevatedButton(
            child: const Text('REFRESH'),
            onPressed: () => _handleGetContact(user),
          ),
        ],
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          const Text('You are not currently signed in.'),
          ElevatedButton(
            onPressed: _handleSignIn,
            child: const Text('SIGN IN'),
          ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Google Sign In'),
        ),
        body: ConstrainedBox(
          constraints: const BoxConstraints.expand(),
          child: _buildBody(),
        ));
  }
}