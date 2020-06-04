import 'dart:convert';
import 'package:easy_localization/easy_localization_delegate.dart';
import 'package:exam/data/globals.dart';
import 'package:exam/language/lang_view.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShowQuestionBank extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ShowQuestionBankPage();
  }
}

class ShowQuestionBankPage extends State<ShowQuestionBank> {
  String subjectValue, subjectValue1;
  List sub = ["MCQ", "TRUE&FALSE"];
  List data = new List();
  GlobalState _store = GlobalState.instance;
//get the question mcq
  void subject() async {
    var url = "http://${_store.ipAddress}/app/student.php";
    final response =
        await http.post(url, body: {"action": "get_the_queation_mcq"});
    String content = response.body;
    setState(() {
      data = json.decode(content);
    });
    data = List.from(data.reversed);
  }

  List data1 = new List();
//get the question true and false
  void subject1() async {
    var url = "http://${_store.ipAddress}/app/student.php";
    final response = await http
        .post(url, body: {"action": "get_the_queationtrue_and_false"});
    String content = response.body;
    setState(() {
      data1 = json.decode(content);
    });
  }

  List subData1 = new List();
  List subData = new List();
  //get the name of subject
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
      subData1 = json.decode(content);
    });
    for (int i = 0; i < subData1.length; i++) {
      setState(() {
        subData.add(subData1[i]['Name']);
        data2[subData1[i]['Name'].toString()] =
            int.parse(subData1[i]['counter']);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    subject();
    subject1();
    nameOfSubject();
  }

  //the UI of mcq question
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
                    Text("${data[index]['subject']}"),
                    Text(
                        "${AppLocalizations.of(context).tr('chapter')} :${data[index]['numberofchapter']}"),
                    Text(
                        "${AppLocalizations.of(context).tr('Level')} ${data[index]['level']}"),
                    Text(
                        "${AppLocalizations.of(context).tr('Question')} :${data[index]['Question']}"),
                    Text("(A) ${data[index]['answer1']}"),
                    Text("(B) ${data[index]['answer2']}"),
                    Text("(C) ${data[index]['answer3']}"),
                    Text("(D) ${data[index]['answer4']}"),
                    Text(
                        "${AppLocalizations.of(context).tr('correctAnswer')} :${data[index]['correctanswer']}"),
                    //Text("bank:${data[index]['bank']}"),
                  ],
                ));
              } else {
                return Container();
              }
            }));
  }

  //the UI of true and false question
  Widget getQuestion1() {
    return Container(
        width: MediaQuery.of(context).size.width / 1.2,
        child: ListView.builder(
            itemCount: data1.length,
            itemBuilder: (context, index) {
              if (data1.isEmpty) {
                return CircularProgressIndicator();
              } else if (subjectValue1 != null &&
                  data1[index]['subject'] == subjectValue1) {
                return Card(
                    child: Column(
                  children: <Widget>[
                    Text(
                        "${AppLocalizations.of(context).tr('Question')} :${data1[index]['Question']}"),
                    Text("${data1[index]['subject']}"),
                    Text(
                        "${AppLocalizations.of(context).tr('chapter')} :${data1[index]['numberofchapter']}"),
                    Text(
                        "${AppLocalizations.of(context).tr('correctAnswer')}:${data1[index]['correctanswer']}"),
                    //Text("Bank:${data1[index]['bank']}"),
                  ],
                ));
              } else {
                return Container();
              }
            }));
  }

  String numberValue, levelValue;
  List levelData = ["A", "B", "C"];
  List number = [];
  Map data2 = new Map<String, int>();
  //get the count of chapter based on the name of subject
  void enterNumberChapter(String name) {
    int j = data2[name];
    for (int i = 1; i <= j; i++) {
      number.add(i.toString());
    }
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
        title: Text(AppLocalizations.of(context).tr('questionBank')),
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
                        number.clear();
                        enterNumberChapter(value);
                        numberValue = number[0];
                        subjectValue1 = value;
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
                                  '${AppLocalizations.of(context).tr('Level')}'),
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
              subjectValue == "TRUE&FALSE"
                  ? Container(child: Expanded(child: getQuestion1()))
                  : Container(child: Expanded(child: getQuestion()))
            ],
          )),
    ));
  }
}
