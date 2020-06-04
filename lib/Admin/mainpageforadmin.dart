import 'dart:convert';

import 'package:easy_localization/easy_localization_delegate.dart';
import 'package:exam/data/globals.dart';
import 'package:exam/language/lang_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'add_department.dart';
import 'add_subject.dart';
import 'get_subject.dart';
import 'profile.dart';

class MainAdmin extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MainAdminPage();
  }
}

class MainAdminPage extends State<MainAdmin> {
  void initState() {
    super.initState();
    getAdminDataFromSharedPreferences();
    getData();
  }

  GlobalState _store = GlobalState.instance;

  Map<String, dynamic> chatMap;
  List data = new List<dynamic>();
  //get the requests data
  Future<List> getData() async {
    var url = "http://${_store.ipAddress}/app/admin.php";
    final response = await http.post(url, body: {"action": "getrequestdata"});
    String content = response.body;
    setState(() {
      data = json.decode(content);
    });
    return json.decode(response.body);
  }

  //the action when admin reject request
  rejected(String id) async {
    var url = "http://${_store.ipAddress}/app/admin.php";
    await http
        .post(url, body: {"action": "rejected", "id": "$id"}).whenComplete(() {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => MainAdmin()));
    });
  }

  //the action when admin accept request
  accept(String nationalId, String email, String realName, String password,
      String id, String graduated, String age, String type) async {
    var url = "http://${_store.ipAddress}/app/admin.php";
    await http.post(url, body: {
      "action": "accept",
      "type": type,
      "id": id,
      "Nationalid": nationalId,
      "Email": email,
      "Password": password,
      "realName": realName,
      "graduted": graduated,
      "age": age
    }).catchError((e) {
      print(e);
    }).whenComplete(() {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => MainAdmin()));
    });
  }

  String email, nationalId, name, password, graduated, age;
  //get the data from shared preferences
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

  //the UI of the requests
  Widget getTheRequests() {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        return Card(
            margin: EdgeInsets.all(MediaQuery.of(context).size.width / 15),
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 5, bottom: 5),
                  child: Text(
                      "${AppLocalizations.of(context).tr('name')}:${data[index]['realName']}"),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 5),
                  child: Text(
                      "${AppLocalizations.of(context).tr('heIs')}:${data[index]['type']}"),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 5),
                  child: Text(
                      "${AppLocalizations.of(context).tr('email')}:${data[index]['Email']}"),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 5),
                  child: Text(
                      "${AppLocalizations.of(context).tr('nationalID')}:${data[index]['Nationalid']}"),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 5),
                  child: Text(
                      "${AppLocalizations.of(context).tr('graduatedFrom')}:${data[index]['graduted']}"),
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: IconButton(
                        onPressed: () {
                          accept(
                            data[index]['Nationalid'],
                            data[index]['Email'],
                            data[index]['realName'],
                            data[index]['Password'],
                            data[index]['ID'],
                            data[index]['graduted'],
                            data[index]['age'],
                            data[index]['type'],
                          );
                        },
                        icon: Icon(Icons.check),
                        color: Colors.blue,
                      ),
                    ),
                    Expanded(
                      child: IconButton(
                        onPressed: () {
                          rejected(data[index]['ID']);
                        },
                        icon: Icon(Icons.clear),
                        color: Colors.blue,
                      ),
                    )
                  ],
                )
              ],
            ));
      },
    );
  }

  //the action when admin logout
  logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('loginasadmin', "no");
    Navigator.of(context).pushNamedAndRemoveUntil(
        '/chooselogin', (Route<dynamic> route) => false);
  }

  Widget dataInMenu() {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 10, bottom: 10),
            child: CircleAvatar(
              radius: 45.0,
              backgroundImage: AssetImage(
                'img/professor.png',
              ),
            ),
          ),
          Text("Mr: $name"),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff2e2e2e),
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              ListTile(
                title: dataInMenu(),
                onTap: () {},
              ),
              Divider(),
              ListTile(
                title: Text(AppLocalizations.of(context).tr('Profile'),
                    style: TextStyle(fontWeight: FontWeight.bold)),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Profile()));
                },
              ),
              Divider(),
              ListTile(
                title: Text(
                    '${AppLocalizations.of(context).tr('addDepartment')}',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AddDepartment()));
                },
              ),
              Divider(),
              ListTile(
                title: Text('${AppLocalizations.of(context).tr('addSubject')}',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AddSubject()));
                },
              ),
              Divider(),
              ListTile(
                title: Text('${AppLocalizations.of(context).tr('editSubject')}',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => GetSubject()));
                },
              ),
              Divider(),
              ListTile(
                title: Text('${AppLocalizations.of(context).tr('logOut')}',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                onTap: () {
                  logout();
                },
              ),
              Divider(),
            ],
          ),
        ),
        appBar: AppBar(
          backgroundColor: Color(0xff254660),
          title: Text("E-exam"),
          actions: <Widget>[
            FlatButton(
              child: Icon(
                Icons.language,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => LanguageView(), fullscreenDialog: true),
                );
              },
            )
          ],
        ),
        body: Container(
            child: Column(
          children: <Widget>[
            Expanded(
              child: getTheRequests(),
            ),
          ],
        )),
      ),
    );
  }
}
