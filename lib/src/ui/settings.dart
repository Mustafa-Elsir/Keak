import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:keak/src/custom_widget/language_radio.dart';
import 'package:keak/src/utils/global_translations.dart';
import 'package:keak/src/utils/pref_manager.dart';
import 'package:keak/src/utils/utils.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  String phone;
  final _prefManager =  PrefManager();

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  loadUserData() async {
    phone = await _prefManager.get("phone", "");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          lang.text("Settings"),
        ),
      ),
      body: Container(
        color: Colors.grey[200],
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                SizedBox(
                  height: 24,
                ),
                Text(
                  lang.text("Account data"),
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                phone == null? Container():
                Text(
                  "+${formatPhoneLabel("249${phone.substring(1)}")}",
                  textDirection: TextDirection.ltr,
                  style: TextStyle(
                    fontSize: 28,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                SizedBox(height: 8,),
              ],
            ),
            SizedBox(
              height: 16,
            ),
            Container(
              decoration: new BoxDecoration(
                color: Colors.white,
                borderRadius: new BorderRadius.all(
                  const Radius.circular(8.0),
                ),
              ),
              margin: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.g_translate),
                      ),
                      Expanded(
                        child: Text(lang.text("Language")),
                      ),
                    ],
                  ),
                  Divider(color: Colors.grey, height: 2,),
                  LanguageSelectorRadio(
                    onLanguageChange: (value){
//                      print("Language chagnes: $value");
                    },
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
