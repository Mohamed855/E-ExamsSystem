import 'dart:convert';
import 'package:easy_localization/easy_localization_delegate.dart';
import 'package:exam/data/globals.dart';
import 'package:exam/language/lang_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart' as Toast;
import 'package:http/http.dart' as http;

class StudentSignUp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return StudentSignUpPage();
  }
}

class StudentSignUpPage extends State<StudentSignUp> {
  final _formKey = GlobalKey<FormState>();
  final FocusNode studentIdNode = FocusNode();
  final FocusNode studentIdCardNode = FocusNode();
  final FocusNode studentNameNode = FocusNode();
  final FocusNode studentPasswordNode = FocusNode();
  TextEditingController studentId;
  TextEditingController studentIdCard;
  TextEditingController studentName;
  TextEditingController studentPassword;
  String studentIdSave, studentIdCardSave, studentNameSave, studentPasswordSave;
  String levelValue;
  List level = ["level 1", "level 2", "level 3", "level 4"];
  String departmentValue;
  List department = ["general"];
  List data1 = new List();
  GlobalState _store = GlobalState.instance;
  List _departmentList = ["general"];
  List dataDepartment = new List();
  //get the names of department
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

  @override
  void initState() {
    super.initState();
    studentId = new TextEditingController();
    studentIdCard = new TextEditingController();
    studentName = new TextEditingController();
    studentPassword = new TextEditingController();
  }

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  //create student account
  var request;
  signUp(String nationalId, String collageId, String name, String password,
      String level, String department) async {
    var url = "http://${_store.ipAddress}/app/student.php";
    request = await http.post(url, body: {
      "action": "signupstudent",
      "name": name,
      "nationalid": nationalId,
      "collageid": collageId,
      "password": password,
      "level": level,
      "department": department,
    }).catchError((e) {
      print(e);
    });
    print(request.body);
    if (request.body == "Nationalid used") {
      Toast.Toast.show(
          AppLocalizations.of(context).tr('thisNationalIdIsUsed'), context,
          duration: Toast.Toast.LENGTH_SHORT, gravity: Toast.Toast.BOTTOM);
    } else if (request.body == "collageid used") {
      Toast.Toast.show(
          AppLocalizations.of(context).tr('thisEmailIsUsed'), context,
          duration: Toast.Toast.LENGTH_SHORT, gravity: Toast.Toast.BOTTOM);
    } else if (request.body == "Doned") {
      Navigator.pop(context);
      Toast.Toast.show(
          AppLocalizations.of(context).tr('yourDataIsAdded'), context,
          duration: Toast.Toast.LENGTH_SHORT, gravity: Toast.Toast.BOTTOM);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF2E2E2E),
        body: SingleChildScrollView(
          child: Container(
              height: MediaQuery.of(context).size.height,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height / 15),
                      alignment: Alignment.topRight,
                      child: FlatButton(
                        child: Icon(
                          Icons.language,
                          color: Colors.blue,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => LanguageView(),
                                fullscreenDialog: true),
                          );
                        },
                      ),
                    ),
                    Expanded(
                      child: Image.asset('img/logo.png'),
                      flex: 1,
                    ),
                    Expanded(
                        flex: 2,
                        child: Form(
                            key: _formKey,
                            child: ListView(
                              padding: EdgeInsets.only(top: 0),
                              scrollDirection: Axis.vertical,
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(
                                      bottom:
                                          MediaQuery.of(context).size.height /
                                              55),
                                  width:
                                      MediaQuery.of(context).size.width / 1.2,
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    controller: studentId,
                                    focusNode: studentIdNode,
                                    textInputAction: TextInputAction.next,
                                    onSaved: (input) => studentIdSave = input,
                                    onFieldSubmitted: (term) {
                                      _fieldFocusChange(context, studentIdNode,
                                          studentIdCardNode);
                                    },
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.blue,
                                        ),
                                      ),
                                      labelText: AppLocalizations.of(context)
                                          .tr('yourID'),
                                      hintText: AppLocalizations.of(context)
                                          .tr('enterYourID'),
                                    ),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return AppLocalizations.of(context)
                                            .tr('enterYourID');
                                      } else if (value.length < 6) {
                                        return AppLocalizations.of(context).tr(
                                            'yourIDMustBeLongerThan6Numbers');
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      bottom:
                                          MediaQuery.of(context).size.height /
                                              55),
                                  width:
                                      MediaQuery.of(context).size.width / 1.2,
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    controller: studentIdCard,
                                    focusNode: studentIdCardNode,
                                    textInputAction: TextInputAction.next,
                                    onSaved: (input) =>
                                        studentIdCardSave = input,
                                    onFieldSubmitted: (term) {
                                      _fieldFocusChange(context,
                                          studentIdCardNode, studentNameNode);
                                    },
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.blue,
                                        ),
                                      ),
                                      labelText: AppLocalizations.of(context)
                                          .tr('yourCollegeId'),
                                      hintText: AppLocalizations.of(context)
                                          .tr('enterYourCollegeId'),
                                    ),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return AppLocalizations.of(context)
                                            .tr('enterYourCollegeId');
                                      } else if (value.length < 6) {
                                        return AppLocalizations.of(context).tr(
                                            'yourIDMustBeLongerThan6Numbers');
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      bottom:
                                          MediaQuery.of(context).size.height /
                                              55),
                                  width:
                                      MediaQuery.of(context).size.width / 1.2,
                                  child: TextFormField(
                                    keyboardType: TextInputType.text,
                                    controller: studentName,
                                    focusNode: studentNameNode,
                                    textInputAction: TextInputAction.next,
                                    onSaved: (input) => studentNameSave = input,
                                    onFieldSubmitted: (term) {
                                      _fieldFocusChange(context,
                                          studentNameNode, studentPasswordNode);
                                    },
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.blue,
                                        ),
                                      ),
                                      labelText: AppLocalizations.of(context)
                                          .tr('yourName'),
                                      hintText: AppLocalizations.of(context)
                                          .tr('enterYourName'),
                                    ),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return AppLocalizations.of(context)
                                            .tr('enterYourName');
                                      } else if (value.length < 6) {
                                        return AppLocalizations.of(context).tr(
                                            'yourIDMustBeLongerThan6Numbers');
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      bottom:
                                          MediaQuery.of(context).size.height /
                                              55),
                                  width:
                                      MediaQuery.of(context).size.width / 1.2,
                                  child: TextFormField(
                                    keyboardType: TextInputType.text,
                                    controller: studentPassword,
                                    focusNode: studentPasswordNode,
                                    textInputAction: TextInputAction.done,
                                    onSaved: (input) =>
                                        studentPasswordSave = input,
                                    onFieldSubmitted: (term) {
                                      studentPasswordNode.unfocus();
                                    },
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.blue,
                                        ),
                                      ),
                                      labelText: AppLocalizations.of(context)
                                          .tr('yourPassword'),
                                      hintText: AppLocalizations.of(context)
                                          .tr('enterYourPassword'),
                                    ),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return AppLocalizations.of(context)
                                            .tr('enterYourPassword');
                                      } else if (value.length < 6) {
                                        return AppLocalizations.of(context).tr(
                                            'yourPasswordMustBeLongerThan6Numbers');
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                ),
                                Container(
                                  color: Colors.white,
                                  margin: EdgeInsets.only(
                                      bottom:
                                          MediaQuery.of(context).size.height /
                                              55),
                                  width:
                                      MediaQuery.of(context).size.width / 1.2,
                                  child: DropdownButtonFormField<dynamic>(
                                    value: levelValue,
                                    validator: (value) {
                                      if (value == null) {
                                        return AppLocalizations.of(context)
                                            .tr('enterYourLevel');
                                      } else if (value == " ") {
                                        return AppLocalizations.of(context)
                                            .tr('enterYourLevel');
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
                                    hint: Text(AppLocalizations.of(context)
                                        .tr('Level')),
                                    onChanged: (value) {
                                      setState(() {
                                        nameOfDepartment(value);
                                        _departmentList.clear();

                                        levelValue = value;
                                      });
                                    },
                                  ),
                                ),
                                Container(
                                  color: Colors.white,
                                  margin: EdgeInsets.only(
                                      bottom:
                                          MediaQuery.of(context).size.height /
                                              55),
                                  width:
                                      MediaQuery.of(context).size.width / 1.2,
                                  child: DropdownButtonFormField<dynamic>(
                                    value: departmentValue,
                                    validator: (value) {
                                      if (value == null) {
                                        return AppLocalizations.of(context)
                                            .tr('enterTheSubject');
                                      } else if (value == " ") {
                                        return AppLocalizations.of(context)
                                            .tr('enterTheSubject');
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
                                    hint: Text(AppLocalizations.of(context)
                                        .tr('department')),
                                    onChanged: (value) {
                                      setState(() {
                                        departmentValue = value;
                                      });
                                    },
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      right: 15,
                                      bottom:
                                          MediaQuery.of(context).size.height /
                                              40),
                                  alignment: Alignment.centerRight,
                                  child: InkWell(
                                    child: Text(
                                      AppLocalizations.of(context)
                                          .tr('buttonLogin'),
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 20),
                                    ),
                                    onTap: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ),
                                Card(
                                    color: Colors.blue,
                                    child: Container(
                                      width:
                                          MediaQuery.of(context).size.width / 2,
                                      child: FlatButton(
                                        child: Text(
                                            AppLocalizations.of(context)
                                                .tr('pageSignUpAsStudent'),
                                            style:
                                                TextStyle(color: Colors.white)),
                                        onPressed: () {
                                          if (_formKey.currentState
                                              .validate()) {
                                            signUp(
                                                studentId.text,
                                                studentIdCard.text,
                                                studentName.text,
                                                studentPassword.text,
                                                levelValue,
                                                departmentValue);
                                          }
                                        },
                                      ),
                                    ))
                              ],
                            )))
                  ])),
        ));
  }
}
