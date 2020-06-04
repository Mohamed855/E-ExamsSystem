import 'dart:convert';
import 'package:easy_localization/easy_localization_delegate.dart';
import 'package:exam/data/globals.dart';
import 'package:exam/language/lang_view.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'chooseexam.dart';
import 'showqueation.dart';

class MainStudent extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MainStudentPage();
  }
}

class MainStudentPage extends State<MainStudent> {
  void initState() {
    super.initState();
    nameOfSubject();

    getStudentDataFromSharedPreferences();
  }

  GlobalState _store = GlobalState.instance;

  List subData = new List();
  //get the name of his subjects
  void nameOfSubject() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var url = "http://${_store.ipAddress}/app/student.php";
    final response = await http.post(url, body: {
      "action": "getstudentsubject",
      "level": "${prefs.getString('level')}",
      "department": "${prefs.getString('department')}",
    });
    String content = response.body;
    setState(() {
      subData = json.decode(content);
    });
  }

  Widget theSubjects() {
    return Container(
      child: ListView.builder(
          itemCount: subData.length,
          itemBuilder: (context, index) {
            return Text("${index + 1}. ${subData[index]['Name']}");
          }),
    );
  }

  String email, nationalId, name, password, collageId, level, department;

  getStudentDataFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      email = prefs.getString('ID');
      nationalId = prefs.getString('Nationalid');
      collageId = prefs.getString('Collageid');
      password = prefs.getString('password');
      name = prefs.getString('name');
      level = prefs.getString('level');
      department = prefs.getString('department');
    });
  }

  Widget getTheStudentData() {
    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Text("${AppLocalizations.of(context).tr('email')}: $email"),
          Text("${AppLocalizations.of(context).tr('nationalID')}: $nationalId"),
          Text("${AppLocalizations.of(context).tr('name')}: $name"),
          Text("${AppLocalizations.of(context).tr('collageID')}: $collageId"),
          Text("${AppLocalizations.of(context).tr('level')}: $level"),
          Text("${AppLocalizations.of(context).tr('Password')}: $password"),
          Text("${AppLocalizations.of(context).tr('department')}: $department"),
        ],
      ),
    );
  }

  logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('loginasstudent', "no");
    Navigator.of(context).pushNamedAndRemoveUntil(
        '/chooselogin', (Route<dynamic> route) => false);
  }

  Widget dataInMenu() {
    return Column(
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
        Text(name ?? ""),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
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
        backgroundColor: Color(0xff254660),
        title: Text("E-exam"),
      ),
      backgroundColor: Color(0xff2e2e2e),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            ListTile(
              title: dataInMenu(),
            ),
            Divider(),
            ListTile(
              title: Text(AppLocalizations.of(context).tr('exam'),
                  style: TextStyle(fontWeight: FontWeight.bold)),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ChooseExam()));
              },
            ),
            Divider(),
            ListTile(
              title: Text(AppLocalizations.of(context).tr('bank'),
                  style: TextStyle(fontWeight: FontWeight.bold)),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ShowQuestionBank()));
              },
            ),
            Divider(),
            ListTile(
              title: Text(AppLocalizations.of(context).tr('logOut'),
                  style: TextStyle(fontWeight: FontWeight.bold)),
              onTap: () {
                logout();
              },
            ),
            Divider(),
          ],
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(top: 10),
        child: Column(
//          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Card(
                child: Container(
              width: MediaQuery.of(context).size.width / 1.5,
              height: MediaQuery.of(context).size.height / 10,
              child: Wrap(
                children: <Widget>[
                  Container(
                    child: Text(
                        "${AppLocalizations.of(context).tr('Welcome')} : $name"),
                  ),
                ],
              ),
            )),
            Container(
              width: MediaQuery.of(context).size.width / 1.5,
              //height: MediaQuery.of(context).size.height / 10,
              child: getTheStudentData(),
            ),
            Card(
                child: Container(
              width: MediaQuery.of(context).size.width / 1.5,
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: Text(
                        "${AppLocalizations.of(context).tr('subjectsYouTeach')} :"),
                  ),
                  Container(
                      height: 70,
                      width: MediaQuery.of(context).size.width / 2,
                      child: theSubjects())
                ],
              ),
            ))
          ],
        ),
      ),
    ));
  }
}
