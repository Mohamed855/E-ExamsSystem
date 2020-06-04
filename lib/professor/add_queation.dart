import 'dart:convert';
import 'package:easy_localization/easy_localization_delegate.dart';
import 'package:exam/data/globals.dart';
import 'package:exam/language/lang_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart' as Toast;
import 'package:http/http.dart' as http;

class AddQuestion extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AddQuestionPage();
  }
}

enum SingingCharacter { lafayette, jefferson }

class AddQuestionPage extends State<AddQuestion> {
  final _formKey = GlobalKey<FormState>();
  final FocusNode questionNode = FocusNode();
  final FocusNode answer1node = FocusNode();
  final FocusNode answer2node = FocusNode();
  final FocusNode answer3node = FocusNode();
  final FocusNode answer4node = FocusNode();
  TextEditingController question;
  TextEditingController answer1;
  TextEditingController answer2;
  TextEditingController answer3;
  TextEditingController answer4;
  String questionSave, answer1save, answer2save, answer3save, answer4save;
  List number = [];
  List trueAndFalseAnswer = ["True", "False"];
  List MCQAnswer = ["", "", "", ""];
  List level = ["A", "B", "C"];
  List sub = [];
  SingingCharacter _character = SingingCharacter.lafayette;

  void initState() {
    super.initState();
    nameOfSubject();
    question = new TextEditingController();
    answer1 = new TextEditingController();
    answer2 = new TextEditingController();
    answer3 = new TextEditingController();
    answer4 = new TextEditingController();
  }

  Map data = new Map<String, int>();
  //get the count of chapter based on the name of subject
  void enterNumberChapter(String name) {
    int j = data[name];
    for (int i = 1; i <= j; i++) {
      number.add(i.toString());
    }
  }

  GlobalState _store = GlobalState.instance;

  List subData = new List();
  //get the name of subjects
  void nameOfSubject() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var url = "http://${_store.ipAddress}/app/professor.php";
    final response = await http.post(url, body: {
      "action": "get_the_subject",
      "Professor": "${prefs.getString('realName')}"
    });
    String content = response.body;
    setState(() {
      subData = json.decode(content);
    });
    for (int i = 0; i < subData.length; i++) {
      sub.add(subData[i]['Name']);
      data[subData[i]['Name'].toString()] = int.parse(subData[i]['counter']);
    }
  }

  var b2;
  //send the question to database
  Future<void> addQuestionMCQ(
      String question,
      String subject,
      String numberOfChapter,
      String level,
      String answer1,
      String answer2,
      String answer3,
      String answer4,
      String correctAnswer) async {
    var url = "http://${_store.ipAddress}/app/professor.php";
    b2 = await http.post(url, body: {
      "action": "add_question_mcq_tosqlite",
      "question": question,
      "subject": subject,
      "numberofchapter": numberOfChapter,
      "level": level,
      "answer1": answer1,
      "answer2": answer2,
      "answer3": answer3,
      "answer4": answer4,
      "correctanswer": correctAnswer,
      "bank": _value1.toString()
    }).whenComplete(() {
      Toast.Toast.show(
          AppLocalizations.of(context).tr('thatQueationIsAdd'), context,
          duration: Toast.Toast.LENGTH_SHORT, gravity: Toast.Toast.BOTTOM);
      Navigator.pop(context);
    });
  }

  var b1;
  Future<void> addQuestionTrueAndFalse(String question, String subject,
      String numberOfChapter, String correctAnswer) async {
    var url = "http://${_store.ipAddress}/app/professor.php";
    b1 = await http.post(url, body: {
      "action": "add_question_true_and_false_tosqlite",
      "question": question,
      "subject": subject,
      "numberofchapter": numberOfChapter,
      "correctanswer": correctAnswer,
      "bank": _value1.toString()
    }).catchError((e) {
      print(e);
    }).whenComplete(() {
      Toast.Toast.show(
          AppLocalizations.of(context).tr('thatQueationIsAdd'), context,
          duration: Toast.Toast.LENGTH_SHORT, gravity: Toast.Toast.BOTTOM);
      Navigator.pop(context);
    });
  }

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  String trueAndFalseValue, levelValue, MCQValue, subjectValue, numberValue;
  bool mcq = true;
  Widget theAnswerOfMCQ() {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
              color: Colors.white,
              margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height / 55,
              ),
              width: MediaQuery.of(context).size.width / 1.2,
              child: DropdownButtonFormField<dynamic>(
                value: levelValue,
                validator: (value) {
                  if (value == null) {
                    return AppLocalizations.of(context)
                        .tr('enterTheLevelOfQuestion');
                  } else if (value == " ") {
                    return AppLocalizations.of(context)
                        .tr('enterTheLevelOfQuestion');
                  } else {
                    return null;
                  }
                },
                items: level
                    .map((label) => DropdownMenuItem(
                          child: Text(label.toString()),
                          value: label,
                        ))
                    .toList(),
                hint: Text(
                    '${AppLocalizations.of(context).tr('levelOfQuestion')} :'),
                onChanged: (value) {
                  setState(() {
                    levelValue = value;
                  });
                },
              )),
          Container(
              margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height / 55),
              width: MediaQuery.of(context).size.width / 1.2,
              child: TextFormField(
                keyboardType: TextInputType.text,
                controller: answer1,
                focusNode: answer1node,
                onChanged: (q) {
                  MCQAnswer[0] = q;
                },
                textInputAction: TextInputAction.next,
                onSaved: (input) => answer1save = input,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context).tr('answer1'),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue,
                    ),
                  ),
                  hintText: AppLocalizations.of(context).tr('enterAnswer1'),
                ),
                onFieldSubmitted: (input) {
                  _fieldFocusChange(context, answer1node, answer2node);
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return AppLocalizations.of(context).tr('enterAnswer1');
                  } else {
                    return null;
                  }
                },
              )),
          Container(
              margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height / 55),
              width: MediaQuery.of(context).size.width / 1.2,
              child: TextFormField(
                keyboardType: TextInputType.text,
                controller: answer2,
                focusNode: answer2node,
                textInputAction: TextInputAction.next,
                onChanged: (q) {
                  MCQAnswer[1] = q;
                },
                onSaved: (input) {
                  answer2save = input;
                },
                onFieldSubmitted: (input) {
                  _fieldFocusChange(context, answer2node, answer3node);
                },
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context).tr('answer2'),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue,
                    ),
                  ),
                  hintText: AppLocalizations.of(context).tr('enterAnswer2'),
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return AppLocalizations.of(context).tr('enterAnswer2');
                  } else {
                    return null;
                  }
                },
              )),
          Container(
              margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height / 55),
              width: MediaQuery.of(context).size.width / 1.2,
              child: TextFormField(
                keyboardType: TextInputType.text,
                controller: answer3,
                focusNode: answer3node,
                textInputAction: TextInputAction.next,
                onChanged: (q) {
                  MCQAnswer[2] = q;
                },
                onSaved: (input) => answer3save = input,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context).tr('answer3'),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue,
                    ),
                  ),
                  hintText: AppLocalizations.of(context).tr('enterAnswer3'),
                ),
                onFieldSubmitted: (input) {
                  _fieldFocusChange(context, answer3node, answer4node);
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return AppLocalizations.of(context).tr('enterAnswer3');
                  } else {
                    return null;
                  }
                },
              )),
          Container(
              margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height / 55),
              width: MediaQuery.of(context).size.width / 1.2,
              child: TextFormField(
                keyboardType: TextInputType.text,
                controller: answer4,
                focusNode: answer4node,
                textInputAction: TextInputAction.done,
                onChanged: (q) {
                  MCQAnswer[3] = q;
                },
                onSaved: (input) => answer4save = input,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context).tr('answer4'),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue,
                    ),
                  ),
                  hintText: AppLocalizations.of(context).tr('enterAnswer4'),
                ),
                onFieldSubmitted: (input) {
                  answer4node.unfocus();
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return AppLocalizations.of(context).tr('enterAnswer4');
                  } else {
                    return null;
                  }
                },
              )),
          Container(
              color: Colors.white,
              margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height / 55,
              ),
              width: MediaQuery.of(context).size.width / 1.2,
              child: DropdownButtonFormField<dynamic>(
                value: MCQValue,
                validator: (value) {
                  if (value == null) {
                    return AppLocalizations.of(context)
                        .tr('enterTheCorrectAnswer');
                  } else if (value == " ") {
                    return AppLocalizations.of(context)
                        .tr('enterTheCorrectAnswer');
                  } else {
                    return null;
                  }
                },
                items: MCQAnswer.map((label) => DropdownMenuItem(
                      child: Text(label.toString()),
                      value: label,
                    )).toList(),
                hint: Text('${AppLocalizations.of(context).tr('answer')} :'),
                onChanged: (value) {
                  setState(() {
                    MCQValue = value;
                  });
                },
              ))
        ],
      ),
    );
  }

  bool trueAndFalse = false;
  Widget trueAndFalseQuestion() {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
              color: Colors.white,
              margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height / 55,
              ),
              width: MediaQuery.of(context).size.width / 1.2,
              child: DropdownButtonFormField<dynamic>(
                value: trueAndFalseValue,
                validator: (value) {
                  if (value == null) {
                    return AppLocalizations.of(context)
                        .tr('enterTheCorrectAnswer');
                  } else if (value == " ") {
                    return AppLocalizations.of(context)
                        .tr('enterTheCorrectAnswer');
                  } else {
                    return null;
                  }
                },
                items: trueAndFalseAnswer
                    .map((label) => DropdownMenuItem(
                          child: Text(label.toString()),
                          value: label,
                        ))
                    .toList(),
                hint: Text('${AppLocalizations.of(context).tr('answer')} :'),
                onChanged: (value) {
                  setState(() {
                    trueAndFalseValue = value;
                  });
                },
              )),
        ],
      ),
    );
  }

  bool _value1 = false;
  void _value1Changed(bool value) => setState(() => _value1 = value);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        title: Text(AppLocalizations.of(context).tr('addQuestion')),
      ),
      backgroundColor: Color(0xff2e2e2e),
      body: Container(
        margin: EdgeInsets.only(
            left: MediaQuery.of(context).size.width / 12,
            right: MediaQuery.of(context).size.width / 12),
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width / 1.2,
        child: Form(
            key: _formKey,
            child: ListView(
              scrollDirection: Axis.vertical,
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.height / 55,
                        top: MediaQuery.of(context).size.height / 55),
                    width: MediaQuery.of(context).size.width / 1.2,
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      controller: question,
                      focusNode: questionNode,
                      textInputAction: TextInputAction.next,
                      onSaved: (input) => questionSave = input,
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context).tr('Question'),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.blue,
                          ),
                        ),
                        hintText:
                            AppLocalizations.of(context).tr('enterQuestion'),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return AppLocalizations.of(context)
                              .tr('enterQuestion');
                        } else {
                          return null;
                        }
                      },
                    )),
                Container(
                    alignment: Alignment.center,
                    color: Colors.white,
                    margin: EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.height / 55),
                    width: MediaQuery.of(context).size.width / 1.2,
                    child: DropdownButtonFormField<dynamic>(
                      value: subjectValue,
                      validator: (value) {
                        if (value == null) {
                          return AppLocalizations.of(context)
                              .tr('enterSubjectName');
                        } else if (value == " ") {
                          return AppLocalizations.of(context)
                              .tr('enterSubjectName');
                        } else {
                          return null;
                        }
                      },
                      items: sub
                          .map((label) => DropdownMenuItem(
                                child: Text(label.toString()),
                                value: label,
                              ))
                          .toList(),
                      hint: Text(
                          '${AppLocalizations.of(context).tr('subject')} :'),
                      onChanged: (value) {
                        setState(() {
                          subjectValue = value;
                          number.clear();
                          enterNumberChapter(subjectValue);
                          numberValue = number[0];
                        });
                      },
                    )),
                Container(
                    alignment: Alignment.center,
                    color: Colors.white,
                    margin: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height / 55,
                    ),
                    width: MediaQuery.of(context).size.width / 1.2,
                    child: DropdownButtonFormField<dynamic>(
                      value: numberValue,
                      validator: (value) {
                        if (value == null && numberValue == null) {
                          return AppLocalizations.of(context)
                              .tr('enterNumberOfChapter');
                        } else if (value == " ") {
                          return AppLocalizations.of(context)
                              .tr('enterNumberOfChapter');
                        } else {
                          return null;
                        }
                      },
                      items: number
                          .map((label) => DropdownMenuItem(
                                child: Text(label.toString()),
                                value: label,
                              ))
                          .toList(),
                      hint: Text(
                          '${AppLocalizations.of(context).tr('numberOfChapter')} :'),
                      onChanged: (value) {
                        setState(() {
                          numberValue = value;
                        });
                      },
                    )),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: ListTile(
                        title: const Text(
                          'MCQ',
                          style: TextStyle(color: Colors.white),
                        ),
                        leading: Radio(
                          value: SingingCharacter.lafayette,
                          groupValue: _character,
                          onChanged: (SingingCharacter value) {
                            setState(() {
                              mcq = true;
                              trueAndFalse = false;
                              _character = value;
                            });
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListTile(
                        title: const Text(
                          'True&\nFalse',
                          style: TextStyle(color: Colors.white),
                        ),
                        leading: Radio(
                          value: SingingCharacter.jefferson,
                          groupValue: _character,
                          onChanged: (SingingCharacter value) {
                            setState(() {
                              trueAndFalse = true;
                              mcq = false;
                              _character = value;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                mcq == true ? theAnswerOfMCQ() : Container(),
                trueAndFalse == true ? trueAndFalseQuestion() : Container(),
                CheckboxListTile(
                  value: _value1,
                  checkColor: Colors.white,
                  onChanged: _value1Changed,
                  title: new Text(
                    AppLocalizations.of(context).tr('addToStudentBank'),
                    style: TextStyle(color: Colors.white),
                  ),
                  controlAffinity: ListTileControlAffinity.leading,
                ),
                Card(
                    color: Colors.blue,
                    child: Container(
                        width: MediaQuery.of(context).size.width / 2,
                        child: FlatButton(
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              if (mcq == true && trueAndFalse == false) {
                                addQuestionMCQ(
                                    question.text,
                                    subjectValue,
                                    numberValue,
                                    levelValue,
                                    answer1.text,
                                    answer2.text,
                                    answer3.text,
                                    answer4.text,
                                    MCQValue);
                              } else if (trueAndFalse == true && mcq == false) {
                                addQuestionTrueAndFalse(
                                    question.text,
                                    subjectValue,
                                    numberValue,
                                    trueAndFalseValue);
                              }
                            }
                          },
                          child: Text(
                              AppLocalizations.of(context).tr('addQuestion'),
                              style: TextStyle(color: Colors.white)),
                          color: Colors.blue,
                        ))),
              ],
            )),
      ),
    );
  }
}
