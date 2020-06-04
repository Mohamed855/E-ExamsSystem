import 'dart:convert';
import 'package:easy_localization/easy_localization_delegate.dart';
import 'package:exam/data/globals.dart';
import 'package:exam/language/lang_view.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart' as Toast;

class GetChapter extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return GetChapterPage();
  }
}

class GetChapterPage extends State<GetChapter> {
  String subjectValue;
  List sub = [];
  GlobalState _store = GlobalState.instance;

  List subData = new List();
  void nameOfSubject() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var url = "http://${_store.ipAddress}/app/professor.php";
    final response = await http.post(url, body: {
      "action": "get_the_subject",
      "Professor": "${prefs.getString('realName')}"
    });
    print(response.body);
    String content = response.body;
    setState(() {
      subData = json.decode(content);
    });
    for (int i = 0; i < subData.length; i++) {
      sub.add(subData[i]['Name']);
    }
    //   });
  }

  void initState() {
    super.initState();
    nameOfSubject();
    subject();
  }

  List data = new List();
  void subject() async {
    var url = "http://${_store.ipAddress}/app/professor.php";
    final response = await http.post(url, body: {"action": "getchapterdata"});
    String content = response.body;
    setState(() {
      data = json.decode(content);
    });
  }

  removeChapter(String subjectName, String id) async {
    var url = "http://${_store.ipAddress}/app/professor.php";
    await http.post(url, body: {
      "action": "remove_chapter",
      "subjectname": subjectName,
      "id": id
    }).whenComplete(() {
      Toast.Toast.show(
          AppLocalizations.of(context).tr('thatSubjectIsRemoved'), context,
          duration: Toast.Toast.LENGTH_SHORT, gravity: Toast.Toast.BOTTOM);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => GetChapter()));
    });
  }

  Widget getQuestion() {
    int i = 0;
    print(data);
    return Container(
        width: MediaQuery.of(context).size.width / 1.2,
        child: ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              if (data.isEmpty) {
                return CircularProgressIndicator();
              } else if (data[index]['subjectname'] == subjectValue) {
                i++;
                return Card(
                  child: Column(
                    children: <Widget>[
                      Text(
                          "${AppLocalizations.of(context).tr('chapter')} $i :${data[index]['chaptername']}"),
                      FlatButton(
                        onPressed: () {
                          removeChapter(subjectValue, data[index]['ID']);
                        },
                        child: Text(
                            "${AppLocalizations.of(context).tr('removeChapter')}",
                            style: TextStyle(color: Colors.white)),
                        color: Colors.blue,
                      )
                    ],
                  ),
                );
              } else {
                return Container();
              }
            }));
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
        title: Text(AppLocalizations.of(context).tr('getChapter')),
      ),
      backgroundColor: Color(0xFF2E2E2E),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            Container(
                color: Colors.white,
                margin: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height / 55,
                    top: MediaQuery.of(context).size.height / 55),
                width: MediaQuery.of(context).size.width / 1.2,
                child: DropdownButtonFormField<dynamic>(
                  value: subjectValue,
                  items: sub
                      .map((label) => DropdownMenuItem(
                            child: Text(label.toString()),
                            value: label,
                          ))
                      .toList(),
                  hint: Text('${AppLocalizations.of(context).tr('subject')} :'),
                  onChanged: (value) {
                    setState(() {
                      subjectValue = value;
                    });
                  },
                )),
            Expanded(child: getQuestion())
          ],
        ),
      ),
    ));
  }
}
