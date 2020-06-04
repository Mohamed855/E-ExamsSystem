import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Admin/mainpageforadmin.dart';
import 'Login/choose_Login.dart';
import 'Student/mainpageforstudent.dart';
import 'professor/mainofprofessor.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.getString('loginasadmin') == "yes") {
    runApp(EasyLocalization(child: Admin()));
  } else if (prefs.getString('loginasprofessor') == "yes") {
    runApp(EasyLocalization(child: Professor()));
  } else if (prefs.getString('loginasstudent') == "yes") {
    runApp(EasyLocalization(child: Student()));
  } else {
    runApp(EasyLocalization(
      child: MyApp(),
    ));
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var data = EasyLocalizationProvider.of(context).data;

    return EasyLocalizationProvider(
      data: data,
      child: MaterialApp(
        title: 'E-exam',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'Bellota',
        ),
        routes: <String, WidgetBuilder>{
          '/mainstudent': (BuildContext context) => new MainStudent(),
          '/mainforadmin': (BuildContext context) => new MainAdmin(),
          '/chooselogin': (BuildContext context) => new ChooseLogin(),
          '/mainprofessor': (BuildContext context) => new MainProfessor(),
        },
        home: ChooseLogin(),
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          EasylocaLizationDelegate(locale: data.locale, path: 'language')
        ],
        supportedLocales: [Locale('en', 'US'), Locale('ar', 'EG')],
        locale: data.savedLocale,
      ),
    );
  }
}

class Admin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var data = EasyLocalizationProvider.of(context).data;
    return EasyLocalizationProvider(
      data: data,
      child: MaterialApp(
        title: 'E-exam',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'Bellota',
        ),
        routes: <String, WidgetBuilder>{
          '/chooselogin': (BuildContext context) => new ChooseLogin(),
          '/mainstudent': (BuildContext context) => new MainStudent(),
          '/mainforadmin': (BuildContext context) => new MainAdmin(),
          '/mainprofessor': (BuildContext context) => new MainProfessor(),
        },
        home: MainAdmin(),
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          EasylocaLizationDelegate(locale: data.locale, path: 'language')
        ],
        supportedLocales: [Locale('en', 'US'), Locale('ar', 'EG')],
        locale: data.savedLocale,
      ),
    );
  }
}

class Professor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var data = EasyLocalizationProvider.of(context).data;

    return EasyLocalizationProvider(
        data: data,
        child: MaterialApp(
          title: 'E-exam',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
            fontFamily: 'Bellota',
          ),
          routes: <String, WidgetBuilder>{
            '/chooselogin': (BuildContext context) => new ChooseLogin(),
            '/mainstudent': (BuildContext context) => new MainStudent(),
            '/mainforadmin': (BuildContext context) => new MainAdmin(),
            '/mainprofessor': (BuildContext context) => new MainProfessor(),
          },
          home: MainProfessor(),
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            EasylocaLizationDelegate(locale: data.locale, path: 'language')
          ],
          supportedLocales: [Locale('en', 'US'), Locale('ar', 'EG')],
          locale: data.savedLocale,
        ));
  }
}

class Student extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var data = EasyLocalizationProvider.of(context).data;

    return EasyLocalizationProvider(
        data: data,
        child: MaterialApp(
          title: 'E-exam',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
            fontFamily: 'Bellota',
          ),
          routes: <String, WidgetBuilder>{
            '/chooselogin': (BuildContext context) => new ChooseLogin(),
            '/mainstudent': (BuildContext context) => new MainStudent(),
            '/mainforadmin': (BuildContext context) => new MainAdmin(),
            '/mainprofessor': (BuildContext context) => new MainProfessor(),
          },
          home: MainStudent(),
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            EasylocaLizationDelegate(locale: data.locale, path: 'language')
          ],
          supportedLocales: [Locale('en', 'US'), Locale('ar', 'EG')],
          locale: data.savedLocale,
        ));
  }
}
