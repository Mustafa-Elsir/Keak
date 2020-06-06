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
  Map user = {};
  final _prefManager =  PrefManager();

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  loadUserData() async {
    String userJson = await _prefManager.get("user.data", "{}");
    setState(() {
      user = json.decode(userJson);
    });
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
                    fontFamily: "Montserrat-Bold",
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                user['phone'] == null? Container():
                Text(
                  "+${formatPhoneLabel("249${user['phone']}")}",
                  textDirection: TextDirection.ltr,
                  style: TextStyle(
                    fontSize: 28,
                    fontFamily: "Montserrat-Bold",
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                (user['email'] == null) || (user['email'] is bool) ? Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    lang.text("You can enter your email to use full features of the system"),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                ) : Text(
                  "${user['email']}",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8,),
              ],
            ),
            SizedBox(
              height: 16,
            ),
//            SettingItem(
//              onTap: () async {
//                var result = await Navigator.of(context).push(
//                  MaterialPageRoute(builder: (context) {
//                    return EmailPage(update: true);
//                  }),
//                );
//                if(result != null && result is bool){
//                  loadUserData();
//                }
//              },
//              label: lang.text("i18n_90"),
//              leadingIcon: Icon(Icons.email),
//              nextIcon: Icon(Icons.navigate_next),
//            ),
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
