import 'dart:convert';
import 'package:easy_localization/easy_localization_delegate.dart';
import 'package:exam/Student/takeexam.dart';
import 'package:exam/data/globals.dart';
import 'package:exam/language/lang_view.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart' as Toast;

class ChooseExam extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ChooseExamPage();
  }
}

class ChooseExamPage extends State<ChooseExam> {
  List examData = new List();
  GlobalState _store = GlobalState.instance;
  void initState() {
    super.initState();
    nameOfSubject();
  }

  List subData = new List();
  List subData2 = new List();
  var subData3;
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
      subData = json.decode(content);
    });
    for (int i = 0; i < subData.length; i++) {
      subData2.add(subData[i]['Name']);
    }
    examDetails(subData2);
  }

  //get the exam details
  void examDetails(List data) async {
    var url = "http://${_store.ipAddress}/app/student.php";
    final response = await http
        .post(url, body: {"action": "examdetails", "subject": data.toString()});

    String content = response.body;
    print(response.body);

    setState(() {
      examData = json.decode(content);
    });
  }

  //the UI of exam details
  Widget details() {
    return Container(
        child: ListView.builder(
            itemCount: examData.length,
            itemBuilder: (context, index) {
              if (examData != null) {
                return Card(
                  child: Column(
                    children: <Widget>[
                      //    Text(examData[index]['ID']),
                      Text(examData[index]['subject']),
                      Text(examData[index]['whenstart']),
                      Text(examData[index]['time']),
                      //Text("${examData[index]['time'].substring(0, 1)}"),
                      FlatButton(
                        color: Colors.blue,
                        child: Text(
                          AppLocalizations.of(context).tr('loginToExam'),
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          var m = examData[index]['whenstart'];
                          DateTime now = new DateTime.now();
                          DateTime dateTime = DateTime.parse(m);
                          var fiftyDaysFromNow =
                              dateTime.add(new Duration(minutes: 20));

                          if (dateTime.isBefore(now) &&
                              fiftyDaysFromNow.isAfter(now)) {
                            print(fiftyDaysFromNow);
                            print("done");
                            print(now);
                            _store.set('idexam', examData[index]['ID']);
                            _store.set(
                                'examsubject', examData[index]['subject']);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => GetExam(
                                        time: int.parse(examData[index]['time']
                                            .substring(0, 1)))));
                          } else {
                            print(dateTime);
                            print("not");
                            print(now);
                            Toast.Toast.show(
                                AppLocalizations.of(context)
                                    .tr('youCannotAccessToThatExam'),
                                context,
                                duration: Toast.Toast.LENGTH_SHORT,
                                gravity: Toast.Toast.BOTTOM);
                          }
                        },
                      ),
                    ],
                  ),
                );
              } else {
                return CircularProgressIndicator(
                  backgroundColor: Colors.white,
                );
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
        title: Text(AppLocalizations.of(context).tr('chooseExam')),
      ),
      backgroundColor: Color(0xff2e2e2e),
      body: Container(
        margin: const EdgeInsets.only(left: 20.0, right: 20.0),
        child: details(),
      ),
    ));
  }
}
