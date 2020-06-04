import 'dart:convert';

import 'package:easy_localization/easy_localization_delegate.dart';
import 'package:exam/data/globals.dart';
import 'package:exam/language/lang_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'edit_subject.dart';

class GetSubject extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return GetSubjectPage();
  }
}

class GetSubjectPage extends State<GetSubject> {
  GlobalState _store = GlobalState.instance;
  @override
  void initState() {
    super.initState();
    getData();
  }

  List data = new List<dynamic>();
  //get the data of subject
  Future<List> getData() async {
    var url = "http://${_store.ipAddress}/app/admin.php";
    final response = await http.post(url, body: {"action": "getsubject"});
    String content = response.body;
    setState(() {
      data = json.decode(content);
    });
    return json.decode(response.body);
  }

  //the UI of card for subject
  Widget subjectData() {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        if (data.isEmpty) {
          return CircularProgressIndicator();
        } else {
          return Card(
              margin: EdgeInsets.all(MediaQuery.of(context).size.width / 15),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 5, bottom: 5),
                    child: Text(
                        "${AppLocalizations.of(context).tr('subjectName')} :${data[index]['Name']}"),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5, bottom: 5),
                    child: Text(
                        "${AppLocalizations.of(context).tr('Professor')} :${data[index]['professor']}"),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5, bottom: 5),
                    child: Text(
                        "${AppLocalizations.of(context).tr('Department')} :${data[index]['department']}"),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5, bottom: 5),
                    child: Text("${data[index]['level']}"),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5, bottom: 5),
                    child: Text(
                        "${AppLocalizations.of(context).tr('Semester')} :${data[index]['semester']}"),
                  ),
                  Card(
                    margin: EdgeInsets.only(top: 5, bottom: 5),
                    color: Colors.blue,
                    child: FlatButton.icon(
                      icon: Icon(
                        Icons.edit,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        _store.set('Name', data[index]['Name']);
                        _store.set('department', data[index]['department']);
                        _store.set('professor', data[index]['professor']);
                        _store.set('level', data[index]['level']);
                        _store.set('semester', data[index]['semester']);
                        _store.set('ID', data[index]['ID']);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditSubject()));
                      },
                      label: Text(
                        AppLocalizations.of(context).tr('edit'),
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Colors.blue,
                    ),
                  ),
                ],
              ));
        }
      },
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
        title: Text(AppLocalizations.of(context).tr('Subjects')),
      ),
      backgroundColor: Color(0xff2e2e2e),
      body: Container(
        child: subjectData(),
      ),
    ));
  }
}
