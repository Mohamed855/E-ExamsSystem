import 'dart:convert';
import 'package:easy_localization/easy_localization_delegate.dart';
import 'package:exam/data/globals.dart';
import 'package:exam/language/lang_view.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:quiver/async.dart';

class GetExam extends StatefulWidget {
  GetExam({this.time});

  final int time;

  @override
  State<StatefulWidget> createState() {
    return GetExamPage();
  }
}

class GetExamPage extends State<GetExam> {
  List data = new List();

  List data1 = new List();
  GlobalState _store = GlobalState.instance;
  //send name of subject and id and get the question will be in exam
  void mcq() async {
    var url = "http://${_store.ipAddress}/app/student.php";
    final response = await http.post(url, body: {
      "action": "getExam",
      "subject": "${_store.get('examsubject')}",
      "id": "${_store.get('idexam')}"
    });
    String content = response.body;
    setState(() {
      data = json.decode(content);
    });
  }

  @override
  void initState() {
    super.initState();
    _current = widget.time;
    _start = widget.time;
    _current = _current * 60 * 60;
    _start = _start * 60 * 60;
    mcq();
    startTimer();
  }

  int i = 0;
  bool answer = false;
  String button1 = "null";
  String button2 = "null";
  String button3 = "null";
  String button4 = "null";
  //count of correct answer
  int count = 0;
  //the UI of questions
  Widget getMCQExam() {
    if (data.isNotEmpty) {
      return Container(
        child: data[i]['answer1'] != null
            ? Column(
                children: <Widget>[
                  Text(
                    "${i + 1}. ${data[i]['Question']}",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: MediaQuery.of(context).size.width / 20),
                  ),
                  data[i]['answer1'] != null
                      ? Container(
                          width: MediaQuery.of(context).size.width / 1.2,
                          child: RaisedButton(
                            child: new Text(data[i]['answer1']),
                            textColor: Colors.white,
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0),
                            ),
                            color: button1 == "null"
                                ? Colors.blue
                                : button1 == "correct"
                                    ? Colors.green
                                    : button1 == "false"
                                        ? Colors.red
                                        : Colors.blue,
                            onPressed: () {
                              if (answer == false) {
                                setState(() {
                                  answer = true;
                                });
                                if (data[i]['answer1'] ==
                                    data[i]['correctanswer']) {
                                  setState(() {
                                    button1 = "correct";
                                    count++;
                                  });
                                } else {
                                  setState(() {
                                    button1 = "false";
                                  });
                                }
                              }
                            },
                          ))
                      : Container(),
                  data[i]['answer2'] != null
                      ? Container(
                          width: MediaQuery.of(context).size.width / 1.2,
                          child: RaisedButton(
                            child: new Text(data[i]['answer2']),
                            textColor: Colors.white,
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0),
                            ),
                            color: button2 == "null"
                                ? Colors.blue
                                : button2 == "correct"
                                    ? Colors.green
                                    : button2 == "false"
                                        ? Colors.red
                                        : Colors.blue,
                            onPressed: () {
                              if (answer == false) {
                                setState(() {
                                  answer = true;
                                });

                                if (data[i]['answer2'] ==
                                    data[i]['correctanswer']) {
                                  setState(() {
                                    button2 = "correct";
                                    count++;
                                  });
                                } else {
                                  setState(() {
                                    button2 = "false";
                                  });
                                }
                              }
                            },
                          ))
                      : Container(),
                  data[i]['answer3'] != null
                      ? Container(
                          width: MediaQuery.of(context).size.width / 1.2,
                          child: RaisedButton(
                            child: new Text(data[i]['answer3']),
                            textColor: Colors.white,
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0),
                            ),
                            color: button3 == "null"
                                ? Colors.blue
                                : button3 == "correct"
                                    ? Colors.green
                                    : button3 == "false"
                                        ? Colors.red
                                        : Colors.blue,
                            onPressed: () {
                              if (answer == false) {
                                setState(() {
                                  answer = true;
                                });

                                if (data[i]['answer3'] ==
                                    data[i]['correctanswer']) {
                                  setState(() {
                                    button3 = "correct";
                                    count++;
                                  });
                                } else {
                                  setState(() {
                                    button3 = "false";
                                  });
                                }
                              }
                            },
                          ))
                      : Container(),
                  data[i]['answer4'] != null
                      ? Container(
                          width: MediaQuery.of(context).size.width / 1.2,
                          child: RaisedButton(
                            child: new Text(data[i]['answer4']),
                            textColor: Colors.white,
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0),
                            ),
                            color: button4 == "null"
                                ? Colors.blue
                                : button4 == "correct"
                                    ? Colors.green
                                    : button4 == "false"
                                        ? Colors.red
                                        : Colors.blue,
                            onPressed: () {
                              if (answer == false) {
                                setState(() {
                                  answer = true;
                                });

                                if (data[i]['answer4'] ==
                                    data[i]['correctanswer']) {
                                  setState(() {
                                    button4 = "correct";
                                    count++;
                                  });
                                } else {
                                  setState(() {
                                    button4 = "false";
                                  });
                                }
                              }
                            },
                          ))
                      : Container(),
                  /*Card(
                    child: Column(
                      children: <Widget>[
                        Text(data[i]['subject']),
                        Text(data[i]['numberofchapter']),
                        Text(data[i]['level']),
                        Text(data[i]['correctanswer']),
                      ],
                    ),
                  )*/
                ],
              )
            : Column(
                children: <Widget>[
                  Text("${i + 1}. ${data[i]['Question']}",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: MediaQuery.of(context).size.width / 20)),
                  Container(
                      width: MediaQuery.of(context).size.width / 1.2,
                      child: RaisedButton(
                        child: new Text("true"),
                        textColor: Colors.white,
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0),
                        ),
                        color: button1 == "null"
                            ? Colors.blue
                            : button1 == "correct"
                                ? Colors.green
                                : button1 == "false" ? Colors.red : Colors.blue,
                        onPressed: () {
                          if (answer == false) {
                            setState(() {
                              answer = true;
                            });

                            if (data[i]['correctanswer'] == "True") {
                              setState(() {
                                button1 = "correct";
                                count++;
                              });
                            } else {
                              setState(() {
                                button1 = "false";
                              });
                            }
                          }
                        },
                      )),
                  Container(
                      width: MediaQuery.of(context).size.width / 1.2,
                      child: RaisedButton(
                        child: new Text("false"),
                        textColor: Colors.white,
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0),
                        ),
                        color: button2 == "null"
                            ? Colors.blue
                            : button2 == "correct"
                                ? Colors.green
                                : button2 == "false" ? Colors.red : Colors.blue,
                        onPressed: () {
                          if (answer == false) {
                            setState(() {
                              answer = true;
                            });

                            if (data[i]['correctanswer'] == "False") {
                              setState(() {
                                button2 = "correct";
                                count++;
                              });
                            } else {
                              setState(() {
                                button2 = "false";
                              });
                            }
                          }
                        },
                      )),
                  /*Card(
                    child: Column(
                      children: <Widget>[
                        Text(data[i]['subject']),
                        Text(data[i]['numberofchapter']),
                        Text(data[i]['correctanswer']),
                      ],
                    ),
                  )*/
                ],
              ),
      );
    } else {
      return CircularProgressIndicator();
    }
  }

  //the result of exam
  _onAlertWithCustomImagePressed(
      context, String title, double result, String img) {
    Alert(
      context: context,
      title: "$title",
      desc: "${AppLocalizations.of(context).tr('Result')}:$result %",
      image: Image.asset("$img"),
      buttons: [
        DialogButton(
          child: Text(
            "${AppLocalizations.of(context).tr('Finish')}:$result",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            setState(() {
              Navigator.of(context).pop();
            });
            Navigator.pop(context);
          },
          width: 120,
        )
      ],
    ).show();
  }

  int _start = 10;
  int _current = 10;

  void startTimer() {
    CountdownTimer countDownTimer = new CountdownTimer(
      new Duration(seconds: _start),
      new Duration(seconds: 1),
    );

    var sub = countDownTimer.listen(null);
    sub.onData((duration) {
      setState(() {
        _current = _start - duration.elapsed.inSeconds;
      });
    });

    sub.onDone(() {
      String word, img;
      double final1 = count / data.length;
      double final2 = final1 * 100;
      double final3 = double.parse(final2.toStringAsFixed(2));
      if (final2 >= 50.0) {
        word = '${AppLocalizations.of(context).tr('Result')}';
        img = 'img/success.png';

        _onAlertWithCustomImagePressed(context, word, final3, img);
      } else {
        word = AppLocalizations.of(context).tr('Failed');
        // double final3 = double.parse(final2.toStringAsFixed(2));
        img = 'img/failed.png';
        _onAlertWithCustomImagePressed(context, word, final3, img);
      }

      print("Done");
      sub.cancel();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          Center(
            child: Text("$_current S"),
          ),
          //  Text("$_time"),
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
        title: Text(AppLocalizations.of(context).tr('exam')),
      ),
      backgroundColor: Color(0xff2e2e2e),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            if (i == data.length - 1 || _current == 0) {
              String word, img;
              double final1 = count / data.length;
              double final2 = final1 * 100;
              double final3 = double.parse(final2.toStringAsFixed(2));
              if (final2 >= 50.0) {
                word = '${AppLocalizations.of(context).tr('Result')}';
                img = 'img/success.png';

                _onAlertWithCustomImagePressed(context, word, final3, img);
              } else {
                word = AppLocalizations.of(context).tr('Failed');
                // double final3 = double.parse(final2.toStringAsFixed(2));
                img = 'img/failed.png';
                _onAlertWithCustomImagePressed(context, word, final3, img);
              }
            } else {
              i++;
              answer = false;
              button1 = "null";
              button2 = "null";
              button3 = "null";
              button4 = "null";
            }
          });
        },
        child: Icon(Icons.navigate_next),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            getMCQExam() /*, Text("$count")*/
          ],
        ),
      ),
    ));
  }
}
