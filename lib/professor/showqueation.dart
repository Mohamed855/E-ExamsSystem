import 'package:easy_localization/easy_localization_delegate.dart';
import 'package:exam/data/globals.dart';
import 'package:exam/language/lang_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ShowQuestion extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ShowQuestionPage();
  }
}

class ShowQuestionPage extends State<ShowQuestion> {
  String subjectValue, subjectValue1, levelValue;
  List sub = ["MCQ", "TRUE&FAULSE"];
  List data = new List();
  List subData1 = new List();
  List levelData = ["A", "B", "C"];
  List subData = new List();
  @override
  void initState() {
    super.initState();
    subject();
    subject1();
    nameOfSubject();
  }

  GlobalState _store = GlobalState.instance;

  void subject() async {
    var url = "http://${_store.ipAddress}/app/professor.php";
    final response =
        await http.post(url, body: {"action": "get_the_queation_mcq"});
    print(response.body);
    String content = response.body;
    setState(() {
      data = json.decode(content);
    });
    data = List.from(data.reversed);
  }

  List data1 = new List();

  void subject1() async {
    var url = "http://${_store.ipAddress}/app/professor.php";
    final response = await http
        .post(url, body: {"action": "get_the_queationtrue_and_false"});
    print(response.body);
    String content = response.body;
    setState(() {
      data1 = json.decode(content);
    });
    data1 = List.from(data1.reversed);
  }

  var d;
  removeMCQQuestion(String id) async {
    var url = "http://${_store.ipAddress}/app/professor.php";
    d = await http.post(url,
        body: {"action": "remove_mcq_question", "id": id}).whenComplete(() {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => ShowQuestion()));
    });
    print(d.body);
  }

  removeTrueAndFalseQuestion(String id) async {
    var url = "http://${_store.ipAddress}/app/professor.php";
    d = await http.post(url, body: {
      "action": "queastion_true_and_false",
      "id": id
    }).whenComplete(() {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => ShowQuestion()));
    });
    print(d.body);
  }

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
      subData1 = json.decode(content);
    });

    for (int i = 0; i < subData1.length; i++) {
      subData.add(subData1[i]['Name']);
      data2[subData1[i]['Name'].toString()] = int.parse(subData1[i]['counter']);
    }
  }

  List number = [];
  Map data2 = new Map<String, int>();
  //get the count of chapter based on the name of subject
  void enterNumberChapter(String name) {
    int j = data2[name];
    for (int i = 1; i <= j; i++) {
      number.add(i.toString());
    }
  }

  String numberValue;
  Widget getQuestion() {
    return Container(
        width: MediaQuery.of(context).size.width / 1.2,
        child: ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              if (data.isEmpty) {
                return CircularProgressIndicator();
              } else if (data[index]['subject'] == subjectValue1 &&
                  data[index]['level'] == levelValue &&
                  data[index]['numberofchapter'] == numberValue) {
                return Card(
                    child: Column(
                  children: <Widget>[
                    Text("Subject :${data[index]['subject']}"),
                    Text("Chapter :${data[index]['numberofchapter']}"),
                    Text("level :${data[index]['level']}"),
                    Text("Question :${data[index]['Question']}?"),
                    Text("(A)${data[index]['answer1']}"),
                    Text("(B)${data[index]['answer2']}"),
                    Text("(C)${data[index]['answer3']}"),
                    Text("(D)${data[index]['answer4']}"),
                    Text("Correct answer :${data[index]['correctanswer']}"),
                    Text("Added to bank:${data[index]['bank']}"),
                    FlatButton(
                        color: Colors.blue,
                        onPressed: () {
                          removeMCQQuestion(data[index]['ID']);
                        },
                        child: Text("remove queation",
                            style: TextStyle(color: Colors.white)))
                  ],
                ));
              } else {
                return Container();
              }
            }));
  }

  Widget getQuestion1() {
    return Container(
        width: MediaQuery.of(context).size.width / 1.2,
        child: ListView.builder(
            itemCount: data1.length,
            itemBuilder: (context, index) {
              print(data1[index]['subject']);
              if (data1.isEmpty) {
                return CircularProgressIndicator();
              } else if (data1[index]['subject'] == subjectValue1) {
                return Card(
                    child: Column(
                  children: <Widget>[
                    Text("Subject:${data1[index]['subject']}"),
                    Text("Chapter :${data1[index]['numberofchapter']}"),
                    Text("Question:${data1[index]['Question']}?"),
                    Text("Correct answer :${data1[index]['correctanswer']}"),
                    Text("Added to bank:${data1[index]['bank']}"),
                    FlatButton(
                        color: Colors.blue,
                        onPressed: () {
                          removeTrueAndFalseQuestion(data1[index]['ID']);
                        },
                        child: Text("remove queation",
                            style: TextStyle(color: Colors.white)))
                  ],
                ));
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
        title: Text(AppLocalizations.of(context).tr('Questions')),
      ),
      backgroundColor: Color(0xff2e2e2e),
      body: Container(
          alignment: Alignment.center,
          child: Column(
            children: <Widget>[
              Container(
                  alignment: Alignment.center,
                  color: Colors.white,
                  margin: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height / 55),
                  width: MediaQuery.of(context).size.width / 1.2,
                  child: DropdownButtonFormField<dynamic>(
                    value: subjectValue1,
                    items: subData
                        .map((label) => DropdownMenuItem(
                              child: Text(label.toString()),
                              value: label,
                            ))
                        .toList(),
                    hint:
                        Text('${AppLocalizations.of(context).tr('subject')} :'),
                    onChanged: (value) {
                      setState(() {
                        enterNumberChapter(value);
                        subjectValue1 = value;
                      });
                    },
                  )),
              Container(
                  color: Colors.white,
                  margin: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height / 55),
                  width: MediaQuery.of(context).size.width / 1.2,
                  child: DropdownButtonFormField<dynamic>(
                    value: subjectValue,
                    items: sub
                        .map((label) => DropdownMenuItem(
                              child: Text(label.toString()),
                              value: label,
                            ))
                        .toList(),
                    hint: Text(
                        '${AppLocalizations.of(context).tr('typeOfQuestion')} :'),
                    onChanged: (value) {
                      setState(() {
                        subjectValue = value;
                      });
                    },
                  )),
              subjectValue == "MCQ"
                  ? Container(
                      alignment: Alignment.center,
                      color: Colors.white,
                      margin: EdgeInsets.only(
                          bottom: MediaQuery.of(context).size.height / 55),
                      width: MediaQuery.of(context).size.width / 1.2,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: DropdownButtonFormField<dynamic>(
                              value: numberValue,
                              items: number
                                  .map((label) => DropdownMenuItem(
                                        child: Text(label.toString()),
                                        value: label,
                                      ))
                                  .toList(),
                              hint: Text(
                                  '${AppLocalizations.of(context).tr('chapter')} :'),
                              onChanged: (value) {
                                setState(() {
                                  numberValue = value;
                                });
                              },
                            ),
                          ),
                          Expanded(
                            child: DropdownButtonFormField<dynamic>(
                              value: levelValue,
                              items: levelData
                                  .map((label) => DropdownMenuItem(
                                        child: Text(label.toString()),
                                        value: label,
                                      ))
                                  .toList(),
                              hint: Text(
                                  '${AppLocalizations.of(context).tr('subject')} :'),
                              onChanged: (value) {
                                setState(() {
                                  levelValue = value;
                                });
                              },
                            ),
                          )
                        ],
                      ))
                  : Container(),
              subjectValue == "TRUE&FAULSE"
                  ? Container(
                      child: Expanded(child: getQuestion1()),
                    )
                  : Container(child: Expanded(child: getQuestion()))
            ],
          )),
    ));
  }
}
