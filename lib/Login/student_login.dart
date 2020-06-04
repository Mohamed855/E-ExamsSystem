import 'dart:convert';
import 'package:easy_localization/easy_localization_delegate.dart';
import 'package:exam/data/globals.dart';
import 'package:exam/language/lang_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart' as Toast;
import 'package:shared_preferences/shared_preferences.dart';
import 'signupforstudent.dart';
import 'package:http/http.dart' as http;

class StudentLogin extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return StudentLoginPage();
  }
}

class StudentLoginPage extends State<StudentLogin> {
  final _formKey = GlobalKey<FormState>();
  final FocusNode studentIdNode = FocusNode();
  final FocusNode studentPasswordNode = FocusNode();
  TextEditingController studentId;
  TextEditingController studentPassword;
  String studentIdSave, studentPasswordSave;
  void initState() {
    super.initState();
    studentId = new TextEditingController();
    studentPassword = new TextEditingController();
  }

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  List data = new List();
  GlobalState _store = GlobalState.instance;
  final GlobalKey<ScaffoldState> scaffoldState = new GlobalKey<ScaffoldState>();
  //send http request and get the data from student table Dependent on email you entered
  login(String id, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      var url = "http://${_store.ipAddress}/app/student.php";
      final response = await http.post(url, body: {
        "action": "check_your_email_and_password",
        "email": "$id",
      });
      String content = response.body;
      print(response.body);
      setState(() {
        data = json.decode(content);
      });
      if (password == data[0]['password']) {
        prefs.setString('ID', "${data[0]['ID']}");
        prefs.setString('Nationalid', "${data[0]['Nationalid']}");
        prefs.setString('Collageid', "${data[0]['Collageid']}");
        prefs.setString('name', "${data[0]['name']}");
        prefs.setString('password', "${data[0]['password']}");
        prefs.setString('level', "${data[0]['level']}");
        prefs.setString('department', "${data[0]['department']}");
        prefs.setString('loginasstudent', "yes");

        Navigator.of(context).pushNamedAndRemoveUntil(
            '/mainstudent', (Route<dynamic> route) => false);
        Toast.Toast.show(
            AppLocalizations.of(context).tr('welcomeToOurApp'), context,
            duration: Toast.Toast.LENGTH_SHORT, gravity: Toast.Toast.BOTTOM);
        data.clear();
      } else {
        Toast.Toast.show(
            AppLocalizations.of(context).tr('checkYourPassword'), context,
            duration: Toast.Toast.LENGTH_SHORT, gravity: Toast.Toast.BOTTOM);
      }
    } catch (e) {
      Toast.Toast.show(
          AppLocalizations.of(context).tr('checkYourEmail'), context,
          duration: Toast.Toast.LENGTH_SHORT, gravity: Toast.Toast.BOTTOM);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      key: scaffoldState,
      backgroundColor: Color(0xFF2E2E2E),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin:
                  EdgeInsets.only(top: MediaQuery.of(context).size.height / 15),
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
                        builder: (_) => LanguageView(), fullscreenDialog: true),
                  );
                },
              ),
            ),
            Expanded(
              child: Image.asset('img/logo.png'),
              flex: 1,
            ),
            Expanded(
                flex: 1,
                child: Column(
                  children: <Widget>[
                    Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).size.height / 40),
                            width: MediaQuery.of(context).size.width / 1.2,
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              controller: studentId,
                              focusNode: studentIdNode,
                              textInputAction: TextInputAction.next,
                              onSaved: (input) => studentIdSave = input,
                              onFieldSubmitted: (term) {
                                _fieldFocusChange(context, studentIdNode,
                                    studentPasswordNode);
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
                                  return AppLocalizations.of(context)
                                      .tr('yourIDMustBeLongerThan6Numbers');
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.only(
                                  bottom:
                                      MediaQuery.of(context).size.height / 40),
                              width: MediaQuery.of(context).size.width / 1.2,
                              child: TextFormField(
                                keyboardType: TextInputType.text,
                                controller: studentPassword,
                                focusNode: studentPasswordNode,
                                textInputAction: TextInputAction.done,
                                onSaved: (input) => studentPasswordSave = input,
                                onFieldSubmitted: (value) {
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
                              ))
                        ],
                      ),
                    ),
                    Card(
                        color: Colors.blue,
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2,
                          child: FlatButton(
                            child: Text(
                                AppLocalizations.of(context)
                                    .tr('loginAsStudent'),
                                style: TextStyle(color: Colors.white)),
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                scaffoldState.currentState
                                    .showSnackBar(new SnackBar(
                                  content: Row(
                                    children: <Widget>[
                                      new CircularProgressIndicator(),
                                      new Text(
                                          "${AppLocalizations.of(context).tr('loading')} ...")
                                    ],
                                  ),
                                ));
                                login(studentId.text, studentPassword.text);
                              }
                            },
                          ),
                        )),
                    Container(
                      margin: EdgeInsets.only(
                          right: 15,
                          bottom: MediaQuery.of(context).size.height / 40),
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        child: Text(
                          AppLocalizations.of(context).tr('buttonSignUp'),
                          style: TextStyle(color: Colors.grey, fontSize: 20),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => StudentSignUp()));
                        },
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
