import 'dart:convert';

import 'package:easy_localization/easy_localization_delegate.dart';
import 'package:exam/data/globals.dart';
import 'package:exam/language/lang_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart' as Toast;
import 'package:http/http.dart' as http;

class AddSubject extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AddSubjectPage();
  }
}

class AddSubjectPage extends State<AddSubject> {
  final _formKey = GlobalKey<FormState>();
  String _semester, _level, _department, _professor;
  List _semesterList = ["semester 1", "semester 2"];
  List _levelList = ["level 1", "level 2", "level 3", "level 4"];
  List _departmentList = ["general"];
  List _professorList = [];
  TextEditingController subjectName;
  String subjectNameSave;

  void initState() {
    super.initState();
    getData();
    subjectName = new TextEditingController();
  }

  GlobalState _store = GlobalState.instance;

  List data = new List<dynamic>();
  //get the names of professors
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
    return json.decode(response.body);
  }

  List data1 = new List<dynamic>();

  List dataDepartment = new List();
  //get the department data and add them to DropdownButtonFormField
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

  //send subject data to database
  Future<void> addSubject(String name, String department, String professor,
      String level, String semester) async {
    var url = "http://${_store.ipAddress}/app/admin.php";
    var request = await http.post(url, body: {
      "action": "addsubject",
      "name": name,
      "department": department,
      "professor": professor,
      "level": level,
      "semester": semester,
    }).catchError((e) {
      print(e);
    });
    print(request.body);
    if (request.body == "name used") {
      Toast.Toast.show(
          AppLocalizations.of(context).tr('nameOfDepartmentIsUsed'), context,
          duration: Toast.Toast.LENGTH_SHORT, gravity: Toast.Toast.BOTTOM);
    } else {
      Toast.Toast.show(
          AppLocalizations.of(context).tr('thatSubjectIsAdd'), context,
          duration: Toast.Toast.LENGTH_SHORT, gravity: Toast.Toast.BOTTOM);
      Navigator.pop(context);
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
        title: Text(AppLocalizations.of(context).tr('addSubject')),
      ),
      backgroundColor: Color(0xff2e2e2e),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Form(
                key: _formKey,
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(
                            bottom: MediaQuery.of(context).size.height / 55),
                        width: MediaQuery.of(context).size.width / 1.2,
                        child: TextFormField(
                          cursorColor: Colors.blue,
                          keyboardType: TextInputType.text,
                          controller: subjectName,
                          onSaved: (input) => subjectNameSave = input,
                          decoration: InputDecoration(
                            labelText:
                                AppLocalizations.of(context).tr('subjectName'),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.blue,
                              ),
                            ),
                            hintText: AppLocalizations.of(context)
                                .tr('enterSubjectName'),
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
                          validator: (value) {
                            if (value == null) {
                              return AppLocalizations.of(context)
                                  .tr('enterSemester');
                            } else if (value == " ") {
                              return AppLocalizations.of(context)
                                  .tr('enterSemester');
                            } else {
                              return null;
                            }
                          },
                          items: _semesterList
                              .map((label) => DropdownMenuItem(
                                    child: Text(label.toString()),
                                    value: label,
                                  ))
                              .toList(),
                          hint: Text(
                              '${AppLocalizations.of(context).tr('Semester')} :'),
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
                          validator: (value) {
                            if (value == null) {
                              return AppLocalizations.of(context)
                                  .tr('enterLevel');
                            } else if (value == " ") {
                              return AppLocalizations.of(context)
                                  .tr('enterLevel');
                            } else {
                              return null;
                            }
                          },
                          items: _levelList
                              .map((label) => DropdownMenuItem(
                                    child: Text(label.toString()),
                                    value: label,
                                  ))
                              .toList(),
                          hint: Text(
                              '${AppLocalizations.of(context).tr('level')} :'),
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
                          validator: (value) {
                            if (value == null) {
                              return AppLocalizations.of(context)
                                  .tr('enterDepartment');
                            } else if (value == " ") {
                              return AppLocalizations.of(context)
                                  .tr('enterDepartment');
                            } else {
                              return null;
                            }
                          },
                          items: _departmentList
                              .map((label) => DropdownMenuItem(
                                    child: Text(label.toString()),
                                    value: label,
                                  ))
                              .toList(),
                          hint: Text(
                              '${AppLocalizations.of(context).tr('Department')} :'),
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
                          validator: (value) {
                            if (value == null) {
                              return AppLocalizations.of(context)
                                  .tr('enterProfessor');
                            } else if (value == " ") {
                              return AppLocalizations.of(context)
                                  .tr('enterProfessor');
                            } else {
                              return null;
                            }
                          },
                          items: _professorList
                              .map((label) => DropdownMenuItem(
                                    child: Text(label.toString()),
                                    value: label,
                                  ))
                              .toList(),
                          hint: Text(
                              '${AppLocalizations.of(context).tr('Professor')} :'),
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
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              addSubject(subjectName.text, _department,
                                  _professor, _level, _semester);
                            }
                          },
                          label: Text(
                              AppLocalizations.of(context).tr('addSubject'),
                              style: TextStyle(color: Colors.white)),
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ))
          ],
        ),
      ),
    ));
  }
}
