import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ProfilePage();
  }
}

class ProfilePage extends State<Profile> {
  void initState() {
    super.initState();
    getAdminDataFromSharedPreferences();
  }

  String email, nationalId, name, password, graduated, age;

  Future getAdminDataFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      email = prefs.getString('Email');
      nationalId = prefs.getString('Nationalid');
      password = prefs.getString('Password');
      name = prefs.getString('realName');
      graduated = prefs.getString('graduted');
      age = prefs.getString('age');
    });
  }

  Widget getTheAdminData() {
    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Text("$email"),
          Text("$nationalId"),
          Text("$name"),
          Text("$graduated"),
          Text("$age"),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[getTheAdminData()],
        ),
      ),
    ));
  }
}
