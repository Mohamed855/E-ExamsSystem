import 'dart:developer';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class LanguageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var data = EasyLocalizationProvider.of(context).data;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(top: 26),
              margin: EdgeInsets.symmetric(
                horizontal: 24,
              ),
              child: Text(
                'Choose language',
                style: TextStyle(
                  color: Colors.blue,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
              ),
            ),
            ListTile(
                dense: true,
                // isThreeLine: true,
                title: Text(
                  'عربي',
                ),
                subtitle: Text(
                  'عربي',
                ),
                onTap: () {
                  /*log(locale.toString(), name: toString());
                  EasyLocalization.of(context).locale = locale;*/
                  data.changeLocale(Locale('ar', 'EG'));
                  Navigator.pop(context);
                }),
            buildDivider(),
            ListTile(
                dense: true,
                title: Text(
                  'English',
                ),
                subtitle: Text(
                  'English',
                ),
                onTap: () {
                  data.changeLocale(Locale('en', 'US'));
                  Navigator.pop(context);
                }),
            buildDivider(),
          ],
        ),
      ),
    );
  }

  Container buildDivider() => Container(
        margin: EdgeInsets.symmetric(
          horizontal: 24,
        ),
        child: Divider(
          color: Colors.grey,
        ),
      );
}
