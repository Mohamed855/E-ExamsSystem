import 'dart:convert';
import 'package:easy_localization/easy_localization_delegate.dart';
import 'package:exam/data/globals.dart';
import 'package:exam/language/lang_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart' as Toast;
import 'package:http/http.dart' as http;

class AddDepartment extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AddDepartmentPage();
  }
}

class AddDepartmentPage extends State<AddDepartment> {
  final _formKey = GlobalKey<FormState>();
  final FocusNode departmentNameNode = FocusNode();
  TextEditingController departmentName;
  String departmentNameSave;

  String _ratingController;
  List _professors = [];
  GlobalState _store = GlobalState.instance;

  List data = new List<dynamic>();
  //get professor data
  Future<List> getData() async {
    var url = "http://${_store.ipAddress}/app/admin.php";
    final response = await http.post(url, body: {"action": "getprofessordata"});
    String content = response.body;
    setState(() {
      data = json.decode(content);
    });
    for (int i = 0; i < data.length; i++) {
      setState(() {
        _professors.add(data[i]['realName']);
      });
    }
    return json.decode(response.body);
  }

  String _ratingController1;
  List _start = ["level 1", "level 3"];

  void initState() {
    super.initState();
    getData();
    departmentName = new TextEditingController();
  }

  //send the department data
  void addDepartment(String name, String level, String leader) async {
    var url = "http://${_store.ipAddress}/app/admin.php";
    var request = await http.post(url, body: {
      "action": "add_department",
      "name": name,
      "whenstart": level,
      "leader": leader
    }).catchError((e) {
      print(e);
    });
    //.whenComplete(() {
    print(request.body);
    if (request.body == "name used") {
      Toast.Toast.show(
          AppLocalizations.of(context).tr('nameOfDepartmentIsUsed'), context,
          duration: Toast.Toast.LENGTH_SHORT, gravity: Toast.Toast.BOTTOM);
    } else {
      Toast.Toast.show(
          AppLocalizations.of(context).tr('thatDepartmentIsAdd'), context,
          duration: Toast.Toast.LENGTH_SHORT, gravity: Toast.Toast.BOTTOM);
      Navigator.pop(context);
    }
    //});
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
          title: Text("${AppLocalizations.of(context).tr('addDepartment')}"),
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
                          controller: departmentName,
                          focusNode: departmentNameNode,
                          textInputAction: TextInputAction.next,
                          onSaved: (input) => departmentNameSave = input,
                          decoration: InputDecoration(
                            labelText:
                                "${AppLocalizations.of(context).tr('departmentName')}",
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.blue,
                              ),
                            ),
                            hintText:
                                "${AppLocalizations.of(context).tr('enterDepartmentName')}",
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return '${AppLocalizations.of(context).tr('enterDepartmentName')}';
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
                            value: _ratingController,
                            validator: (value) {
                              if (value == null) {
                                return '${AppLocalizations.of(context).tr('enterTheTimeCanStudentJoin')}';
                              } else if (value == " ") {
                                return '${AppLocalizations.of(context).tr('enterTheTimeCanStudentJoin')}';
                              } else {
                                return null;
                              }
                            },
                            items: _start
                                .map((label) => DropdownMenuItem(
                                      child: Text(label.toString()),
                                      value: label,
                                    ))
                                .toList(),
                            hint: Text(
                                '${AppLocalizations.of(context).tr('studentCanEnterFrom')}:'),
                            onChanged: (value) {
                              setState(() {
                                _ratingController = value;
                              });
                            },
                          )),
                      Container(
                          color: Colors.white,
                          margin: EdgeInsets.only(
                              bottom: MediaQuery.of(context).size.height / 55),
                          width: MediaQuery.of(context).size.width / 1.2,
                          child: DropdownButtonFormField<dynamic>(
                            value: _ratingController1,
                            validator: (value) {
                              if (value == null) {
                                return '${AppLocalizations.of(context).tr('enterDepartmentLeader')}';
                              } else if (value == " ") {
                                return '${AppLocalizations.of(context).tr('enterDepartmentLeader')}';
                              } else {
                                return null;
                              }
                            },
                            items: _professors
                                .map((label) => DropdownMenuItem(
                                      child: Text(label.toString()),
                                      value: label,
                                    ))
                                .toList(),
                            hint: Text(
                                '${AppLocalizations.of(context).tr('leaderOfDepartment')} :'),
                            onChanged: (value) {
                              setState(() {
                                _ratingController1 = value;
                              });
                            },
                          )),
                      Card(
                        color: Colors.blue,
                        child: FlatButton.icon(
                          icon: Icon(
                            Icons.save,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              addDepartment(
                                departmentName.text,
                                _ratingController,
                                _ratingController1,
                              );
                            }
                          },
                          label: Text(
                              "${AppLocalizations.of(context).tr('addDepartment')}",
                              style: TextStyle(color: Colors.white)),
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
