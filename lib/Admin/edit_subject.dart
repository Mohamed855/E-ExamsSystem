import 'dart:convert';
import 'package:easy_localization/easy_localization_delegate.dart';
import 'package:exam/data/globals.dart';
import 'package:exam/language/lang_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart' as Toast;
import 'package:http/http.dart' as http;
import 'get_subject.dart';

class EditSubject extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return EditSubjectPage();
  }
}

class EditSubjectPage extends State<EditSubject> {
  final _formKey = GlobalKey<FormState>();
  String _semester, _level, _department, _professor;
  List _semesterList = ["semester 1", "semester 2"];
  List _levelList = ["level 1", "level 2", "level 3", "level 4"];
  List _departmentList = [];
  List _professorList = [];
  TextEditingController subjectName;
  String subjectNameSave;
  void initState() {
    super.initState();
    getData();
    subjectName = new TextEditingController();
  }

  GlobalState _store = GlobalState.instance;

  List data1 = new List<dynamic>();

  List dataDepartment = new List();
  // name of department
  void nameOfDepartment(String studentLevel) async {
    var url = "http://${_store.ipAddress}/app/admin.php";
    final response =
        await http.post(url, body: {"action": "getdepartmentdata"});
    String content = response.body;
    setState(() {
      data1 = json.decode(content);
    });
    for (int i = 0; i < data1.length; i++) {
      setState(() {
        dataDepartment.add(data1[i]['Name'].toString());
      });
    }
    _departmentList.add("general");
    for (int i = 0; i < data1.length; i++) {
      if (studentLevel == "level 3" || studentLevel == "level 4") {
        if (!_departmentList.contains(data1[i]['Name'])) {
          _departmentList.add(data1[i]['Name'].toString());
        }
      } else if (studentLevel == "level 1" || studentLevel == "level 2") {
        if (!_departmentList.contains(data1[i]['Name'])) {
          if (data1[i]['whenstart'] == "level 1" ||
              data1[i]['whenstart'] == "level 2") {
            _departmentList.add(data1[i]['Name'].toString());
          }
        }
      }
    }
  }

  List data = new List<dynamic>();
  //get names of professors
  Future<List> getData() async {
    var url = "http://${_store.ipAddress}/app/admin.php";
    final response = await http.post(url, body: {"action": "getprofessordata"});
    String content = response.body;
    setState(() {
      data = json.decode(content);
    });
    for (int i = 0; i < data.length; i++) {
      setState(() {
        _professorList.add(data[i]['realName']);
      });
    }
    setState(() {
      subjectName.text = _store.get('Name');
    });
    return json.decode(response.body);
  }

  //send the edit of subject to database
  Future<void> addSubject(String name, String department, String professor,
      var level, String semester, String id) async {
    Map<dynamic, dynamic> update = new Map();
    var url = "http://${_store.ipAddress}/app/admin.php";

    update["action"] = "updatesubject";
    update["id"] = "$id";

    if (name != null) {
      update["name"] = "$name";
    }
    if (semester != null) {
      update["semester"] = "$semester";
    }
    if (level != null) {
      update["level"] = "$level";
    }
    if (professor != null) {
      update["professor0000"] = "$professor";
    }
    if (department != null) {
      update["department"] = "$department";
    }

    await http.post(url, body: update);

    Toast.Toast.show(
        AppLocalizations.of(context).tr('thatSubjectIsEdited'), context,
        duration: Toast.Toast.LENGTH_SHORT, gravity: Toast.Toast.BOTTOM);
    Navigator.pop(context);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => GetSubject()));
  }

  String i;
  @override
  Widget build(BuildContext context) {
    String semester = _store.get('semester');
    String level = _store.get('level');
    String department = _store.get('department');
    String professor = _store.get('professor');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff254660),
        title: Text("Edit Subject"),
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
      backgroundColor: Color(0xff2e2e2e),
      body: Center(
        child: ListView(
          children: <Widget>[
            Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.height / 55),
                    width: MediaQuery.of(context).size.width / 1.2,
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      cursorColor: Colors.blue,
                      controller: subjectName,
                      onSaved: (input) => subjectNameSave = input,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.blue,
                          ),
                        ),
                        labelText:
                            "${AppLocalizations.of(context).tr('currentSubjectName')}:${_store.get('Name')}",
                        hintText:
                            AppLocalizations.of(context).tr('enterSubjectName'),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return AppLocalizations.of(context)
                              .tr('enterSubjectName');
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    margin: EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.height / 55),
                    width: MediaQuery.of(context).size.width / 1.2,
                    child: DropdownButtonFormField<dynamic>(
                      value: _semester,
                      decoration: InputDecoration(
                        labelText:
                            "${AppLocalizations.of(context).tr('currentSemester')} :$semester",
                      ),
                      validator: (value) {
                        if (value == " ") {
                          return AppLocalizations.of(context)
                              .tr('enterSemester');
                        } else {
                          _store.set('semester', _semester);

                          return null;
                        }
                      },
                      items: _semesterList
                          .map((label) => DropdownMenuItem(
                                child: Text(label.toString()),
                                value: label,
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _semester = value;
                        });
                      },
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    margin: EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.height / 55),
                    width: MediaQuery.of(context).size.width / 1.2,
                    child: DropdownButtonFormField<dynamic>(
                      value: _level,
                      decoration: InputDecoration(
                        labelText:
                            "${AppLocalizations.of(context).tr('currentLevel')} :$level",
                      ),
                      validator: (value) {
                        if (value == " ") {
                          return AppLocalizations.of(context).tr('enterLevel');
                        } else {
                          _store.set('level', _level);

                          return null;
                        }
                      },
                      items: _levelList
                          .map((label) => DropdownMenuItem(
                                child: Text(label.toString()),
                                value: label,
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          nameOfDepartment(value);

                          _departmentList.clear();
                          _level = value;
                        });
                      },
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    margin: EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.height / 55),
                    width: MediaQuery.of(context).size.width / 1.2,
                    child: DropdownButtonFormField<dynamic>(
                      value: _department,
                      decoration: InputDecoration(
                        labelText:
                            "${AppLocalizations.of(context).tr('currentDepartment')} :$department",
                      ),
                      validator: (value) {
                        if (value == " ") {
                          return AppLocalizations.of(context)
                              .tr('enterDepartment');
                        } else {
                          _store.set('department', _department);

                          return null;
                        }
                      },
                      items: _departmentList
                          .map((label) => DropdownMenuItem(
                                child: Text(label.toString()),
                                value: label,
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _department = value;
                        });
                      },
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    margin: EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.height / 55),
                    width: MediaQuery.of(context).size.width / 1.2,
                    child: DropdownButtonFormField<dynamic>(
                      value: _professor,
                      decoration: InputDecoration(
                        labelText:
                            "${AppLocalizations.of(context).tr('currentProfessor')} :$professor",
                      ),
                      validator: (value) {
                        if (value == " ") {
                          return AppLocalizations.of(context)
                              .tr('enterProfessor');
                        } else {
                          _store.set('professor', _professor);

                          return null;
                        }
                      },
                      items: _professorList
                          .map((label) => DropdownMenuItem(
                                child: Text(label.toString()),
                                value: label,
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _professor = value;
                        });
                      },
                    ),
                  ),
                  Card(
                    color: Colors.blue,
                    child: FlatButton.icon(
                      icon: Icon(
                        Icons.save,
                        color: Colors.white,
                      ),
                      label: Text(AppLocalizations.of(context).tr('edit'),
                          style: TextStyle(color: Colors.white)),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          addSubject(
                              subjectName.text,
                              _store.get('department'),
                              _store.get('professor'),
                              _store.get('level'),
                              _store.get('semester'),
                              _store.get('ID').toString());
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
