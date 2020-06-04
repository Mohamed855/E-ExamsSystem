import 'dart:convert';
import 'package:easy_localization/easy_localization_delegate.dart';
import 'package:exam/data/globals.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart' as Toast;
import 'package:http/http.dart' as http;

class DynamicDialog extends StatefulWidget {
  DynamicDialog(
      {this.title,
      this.examSubject,
      this.examTime,
      this.examDurationOfTheExam});

  final String title;
  final String examSubject;
  final String examTime;
  final String examDurationOfTheExam;

  @override
  State<StatefulWidget> createState() {
    return _DynamicDialogState();
  }
}

class _DynamicDialogState extends State<DynamicDialog> {
  GlobalState _store = GlobalState.instance;
  int counter = 1, counterToSave = 0;
  String button,
      result = "[",
      _title,
      valueMCQLevelA,
      valueMCQLevelB,
      valueMCQLevelC,
      valueTrueAndFalse,
      examSubject,
      examTime,
      examDurationOfTheExam;
  List counterOfMCQ = new List();
  List counterOfTrueAndFalse = new List();
  List numberOfTrueAndFalse = ["0"],
      numberOfMCQLevelA = ["0"],
      numberOfMCQLevelB = ["0"],
      numberOfMCQLevelC = ["0"];

  @override
  void initState() {
    _title = widget.title;
    examDurationOfTheExam = widget.examDurationOfTheExam;
    examTime = widget.examTime;
    examSubject = widget.examSubject;
    counterTrueAndFalse(_title);
    counterMCQ(_title);
    super.initState();
  }

  void counterTrueAndFalse(String subject) async {
    var url = "http://${_store.ipAddress}/app/professor.php";
    final response = await http.post(url,
        body: {"action": "counterTrueAndFalse", "subject": "$_title"});
    String content = response.body;
    setState(() {
      counterOfTrueAndFalse = json.decode(content);
    });
    int q = int.parse(counterOfTrueAndFalse[counterToSave]['counter']);
    for (int i = 1; i <= q; i++) {
      setState(() {
        numberOfTrueAndFalse.add("$i");
      });
    }
  }

  void counterMCQ(String subject) async {
    var url = "http://${_store.ipAddress}/app/professor.php";
    final response = await http
        .post(url, body: {"action": "counterMCQ", "subject": "$subject"});
    print(response.body);
    String content = response.body;
    setState(() {
      counterOfMCQ = json.decode(content);
    });
    int q = int.parse(counterOfMCQ[counterToSave]['levelA']);
    for (int i = 1; i <= q; i++) {
      setState(() {
        numberOfMCQLevelA.add("$i");
      });
    }
    q = int.parse(counterOfMCQ[counterToSave]['levelB']);
    for (int i = 1; i <= q; i++) {
      setState(() {
        numberOfMCQLevelB.add("$i");
      });
    }
    q = int.parse(counterOfMCQ[counterToSave]['levelC']);
    for (int i = 1; i <= q; i++) {
      setState(() {
        numberOfMCQLevelC.add("$i");
      });
    }
  }

  nextChapter(String countOfTrueAndFalse, String countOfMCQLevelA,
      String countOfMCQLevelB, String countOfMCQLevelC) {
    String numberValue = _store.get("numberValue");

    if (int.parse(numberValue) == counter) {
      String data =
          '{"countOfTrueAndFalse":$countOfTrueAndFalse,"countOfMCQLevelA":$countOfMCQLevelA,"countOfMCQLevelB":$countOfMCQLevelB,"countOfMCQLevelC":$countOfMCQLevelC}]';
      setState(() {
        result = result + data;
      });
      List<dynamic> stringList =
          (jsonDecode(result) as List<dynamic>).cast<dynamic>();
      addExam(examSubject, examTime, examDurationOfTheExam, stringList);

      //print(stringList[0]);
      //  print(result);
    } else {
      String data =
          '{"countOfTrueAndFalse":$countOfTrueAndFalse,"countOfMCQLevelA":$countOfMCQLevelA,"countOfMCQLevelB":$countOfMCQLevelB,"countOfMCQLevelC":$countOfMCQLevelC},';
      setState(() {
        result = result + data;
        counterToSave++;
        counter++;
        numberOfTrueAndFalse.clear();
        numberOfMCQLevelA.clear();
        numberOfMCQLevelB.clear();
        numberOfMCQLevelC.clear();
        numberOfTrueAndFalse.add("0");
        numberOfMCQLevelA.add("0");
        numberOfMCQLevelB.add("0");
        numberOfMCQLevelC.add("0");
        int q = int.parse(counterOfTrueAndFalse[counterToSave]['counter']);
        for (int i = 1; i <= q; i++) {
          setState(() {
            numberOfTrueAndFalse.add("$i");
          });
        }
        q = int.parse(counterOfMCQ[counterToSave]['levelA']);
        for (int i = 1; i <= q; i++) {
          setState(() {
            numberOfMCQLevelA.add("$i");
          });
        }
        q = int.parse(counterOfMCQ[counterToSave]['levelB']);
        for (int i = 1; i <= q; i++) {
          setState(() {
            numberOfMCQLevelB.add("$i");
          });
        }
        q = int.parse(counterOfMCQ[counterToSave]['levelC']);
        for (int i = 1; i <= q; i++) {
          setState(() {
            numberOfMCQLevelC.add("$i");
          });
        }
        valueTrueAndFalse = "0";
        valueMCQLevelB = "0";
        valueMCQLevelC = "0";
        valueMCQLevelA = "0";
        if (counter == int.parse(numberValue)) {
          setState(() {
            button = AppLocalizations.of(context).tr('Done');
          });
        }
      });
    }
  }

  var b1;
  addChapterToExam(String idExam, String chapter, String level, String type,
      String count) async {
    var url = "http://${_store.ipAddress}/app/professor.php";

    b1 = await http.post(url, body: {
      "action": "addchaptertoexam",
      "examid": "$idExam",
      "chapter": "$chapter",
      "level": "$level",
      "type": "$type",
      "count": "$count"
    });
    print(b1.body);
  }

  addExam(String subject, String when, String time, var data) async {
    var url = "http://${_store.ipAddress}/app/professor.php";
    //List<dynamic> stringList =
    //  (jsonDecode(data) as List<dynamic>).cast<dynamic>();

    var response = await http.post(url, body: {
      "action": "add_detailsexam",
      "subject": subject,
      "when": when,
      "time": time,
      "data": data.toString()
    });
    String add = response.body;
    int q = 1;
    //print(response.body);
//    String numberValue = ;

    for (int i = 0; i < data.length; i++) {
      data[i]['countOfTrueAndFalse'] == null ||
              data[i]['countOfTrueAndFalse'] == "0"
          ? print("")
          : addChapterToExam("$add", "$q", "null", "trueandfalse",
              "${data[i]['countOfTrueAndFalse']}");
      data[i]['countOfMCQLevelA'] == null || data[i]['countOfMCQLevelA'] == "0"
          ? print("")
          : addChapterToExam(
              "$add", "$q", "A", "mcq", "${data[i]['countOfMCQLevelA']}");
      data[i]['countOfMCQLevelB'] == null || data[i]['countOfMCQLevelB'] == "0"
          ? print("")
          : addChapterToExam(
              "$add", "$q", "B", "mcq", "${data[i]['countOfMCQLevelB']}");
      data[i]['countOfMCQLevelC'] == null || data[i]['countOfMCQLevelC'] == "0"
          ? print("")
          : addChapterToExam(
              "$add", "$q", "C", "mcq", "${data[i]['countOfMCQLevelC']}");
      q++;
      if (q == int.parse(_store.get("numberValue"))) {
        Toast.Toast.show(
            AppLocalizations.of(context).tr('thatExamIsAdded'), context,
            duration: Toast.Toast.LENGTH_SHORT, gravity: Toast.Toast.BOTTOM);

        Navigator.of(context).pushNamedAndRemoveUntil(
            '/mainprofessor', (Route<dynamic> route) => false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    String numberValue = _store.get("numberValue");
    return AlertDialog(
      title: Text('${AppLocalizations.of(context).tr('chapter')} $counter'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Column(
              children: <Widget>[
                Text("True&False"),
                DropdownButtonFormField<dynamic>(
                    value: valueTrueAndFalse,
                    items: numberOfTrueAndFalse
                        .map((label) => DropdownMenuItem(
                              child: Text("$label"),
                              value: label,
                            ))
                        .toList(),
                    hint: Text(
                      '${AppLocalizations.of(context).tr('numberOfTrueAndFalseQuestion')} :',
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width / 29),
                    ),
                    onChanged: (value) {
                      setState(() {
                        valueTrueAndFalse = value;
                      });
                    }),
                Text("MCQ"),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        "A",
                      ),
                      flex: 1,
                    ),
                    Expanded(
                      flex: 6,
                      child: DropdownButtonFormField<dynamic>(
                          value: valueMCQLevelA,
                          items: numberOfMCQLevelA
                              .map((label) => DropdownMenuItem(
                                    child: Text(label.toString()),
                                    value: label,
                                  ))
                              .toList(),
                          hint: Text(
                            //AppLocalizations.of(context).tr('numberOfTrueAndFalseQuestion')
                            '${AppLocalizations.of(context).tr('numberOfQuestionInLevel')} A :',
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width / 29),
                          ),
                          onChanged: (value) {
                            setState(() {
                              valueMCQLevelA = value;
                            });
                          }),
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        "B",
                      ),
                      flex: 1,
                    ),
                    Expanded(
                      flex: 6,
                      child: DropdownButtonFormField<dynamic>(
                          value: valueMCQLevelB,
                          items: numberOfMCQLevelB
                              .map((label) => DropdownMenuItem(
                                    child: Text(label.toString()),
                                    value: label,
                                  ))
                              .toList(),
                          hint: Text(
                            '${AppLocalizations.of(context).tr('numberOfQuestionInLevel')} B :',
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width / 29),
                          ),
                          onChanged: (value) {
                            setState(() {
                              valueMCQLevelB = value;
                            });
                          }),
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        "C",
                      ),
                      flex: 1,
                    ),
                    Expanded(
                      child: DropdownButtonFormField<dynamic>(
                          value: valueMCQLevelC,
                          items: numberOfMCQLevelC
                              .map((label) => DropdownMenuItem(
                                    child: Text(label.toString()),
                                    value: label,
                                  ))
                              .toList(),
                          hint: Text(
                            '${AppLocalizations.of(context).tr('numberOfQuestionInLevel')} C :',
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width / 29),
                          ),
                          onChanged: (value) {
                            setState(() {
                              valueMCQLevelC = value;
                            });
                          }),
                      flex: 6,
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text(AppLocalizations.of(context).tr('Cancel')),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        FlatButton(
          child: numberValue == "1" || int.parse(numberValue) == counter
              ? Text(AppLocalizations.of(context).tr('Done'))
              : numberValue != "1"
                  ? Text(AppLocalizations.of(context).tr('Next'))
                  : Text('$button'),
          onPressed: () {
            nextChapter(valueTrueAndFalse, valueMCQLevelA, valueMCQLevelB,
                valueMCQLevelC);
          },
        ),
      ],
    );
  }
}
