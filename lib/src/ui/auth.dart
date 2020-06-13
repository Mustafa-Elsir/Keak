import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:keak/src/custom_widget/alternative_button.dart';
import 'package:keak/src/resources/repository.dart';
import 'package:keak/src/utils/dialog_utils.dart';
import 'package:keak/src/utils/global_translations.dart';
import 'package:keak/src/utils/pref_manager.dart';
import 'package:keak/src/utils/routes.dart';

class Auth extends StatefulWidget {
  @override
  _AuthState createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  final _controller = TextEditingController();
  final _repo = Repository();
  final _prefManager = PrefManager();

  @override
  void dispose() {
    _repo.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Card(
          elevation: 8,
          margin: EdgeInsets.symmetric(vertical: 40, horizontal: 32),
          child: Container(
            child: ListView(
              padding: EdgeInsets.symmetric(vertical: 40, horizontal: 32),
              children: <Widget>[
                Text(
                  lang.text("Keak"),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 64,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  lang.text("Type your number manage your farm"),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 24),
                TextFormField(
                  controller: _controller,
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: lang.text("Phone number"),
                  ),
                ),
                SizedBox(height: 8),
                AlternativeButton(
                  onPressed: () async {
                    showLoadingDialog(context);
                    Map<String, dynamic> response = await _repo.auth(_controller.text);
                    Navigator.of(context).pop();
                    print("response: $response");
                    if(response.containsKey("success") && response["success"]){
                      await _prefManager.set("phone", _controller.text);
                      await _prefManager.set("token", response["token"]);
                      await _prefManager.set("ambergris", json.encode(response["ambergris"]));
                      Navigator.of(context).pushNamedAndRemoveUntil(homeRoute, ModalRoute.withName("/no_route"));
                    } else {
                      showCustomSuccessDialog(context,
                        color: Colors.red,
                        title: lang.text("Fail"),
                        subtitle: response["message"] ?? lang.text("Fail to login"),
                        negative: null,
                        positive: lang.text("OK"),
                        isDismissible: true
                      );
                    }

                  },
                  label: lang.text("Login"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
