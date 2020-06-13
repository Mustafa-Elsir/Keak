import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:keak/src/custom_widget/alternative_button.dart';
import 'package:keak/src/custom_widget/date_time_picker.dart';
import 'package:keak/src/resources/repository.dart';
import 'package:keak/src/utils/dialog_utils.dart';
import 'package:keak/src/utils/global_translations.dart';
import 'package:keak/src/utils/pref_manager.dart';

class RegisterDead extends StatefulWidget {
  final Map ambergris;

  RegisterDead({Key key, this.ambergris}) : super(key: key);

  @override
  _RegisterDeadState createState() => _RegisterDeadState();
}

class _RegisterDeadState extends State<RegisterDead> {
  var f = new NumberFormat("#,###", lang.currentLanguage);
  final _repo = Repository();
  DateTime date = DateTime.now();
  TimeOfDay timeOfDay = TimeOfDay.now();
  final controller = TextEditingController();

  @override
  void dispose() {
    _repo.close();

    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          lang.text("Register dead"),
        ),
      ),
      body: getBody(),
    );
  }

  Widget getBody(){
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          children: <Widget>[

            Text(
              widget.ambergris["name"],
              style: TextStyle(
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "${lang.text("Current available")} (${f.format(int.parse("${widget.ambergris["available"]}"))})",
              style: TextStyle(
                fontSize: 18,
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 8),

            DateTimePicker(
              labelText: lang.text("Date time"),
              selectDate: (DateTime date){
                this.date = date;
              },
              selectedDate: date,
              selectedTime: timeOfDay,
              selectTime: (TimeOfDay time){
                timeOfDay = time;
              },
            ),

            SizedBox(height: 8),
            TextFormField(
              controller: controller,
              onChanged: (text){
                setState(() {});
              },
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: lang.text("Number of dead"),
              ),
            ),

            SizedBox(height: 24),
            AlternativeButton(
              onPressed: controller.text.isEmpty || controller.text == "0"? null : () async {
                showLoadingDialog(context);
                Map<String, dynamic> response = await _repo.registerDead(
                  widget.ambergris["id"],
                  DateFormat("yyyy-MM-dd").format(date)+" ${timeOfDay.hour}:${timeOfDay.minute}:00",
                  controller.text,
                );
                Navigator.of(context).pop();
                if(response.containsKey("success") && response["success"]){
                  bool close = await showCustomSuccessDialog(context,
                    title: lang.text("Successful"),
                    subtitle: lang.text("data added successfully"),
                    negative: lang.text("Add more"),
                    positive: lang.text("Close"),
                    isDismissible: true
                  );
                  await PrefManager().set("ambergris", json.encode(response["ambergris"]));
                  if(close is bool && close){
                    Navigator.of(context).pop();
                  } else {
                    setState(() {
                      date = DateTime.now();
                      timeOfDay = TimeOfDay.now();
                      controller.clear();
                    });
                  }
                } else {
                  showCustomSuccessDialog(context,
                    color: Colors.red,
                    title: lang.text("Fail"),
                    subtitle: response["message"] ?? lang.text("Fail to save data"),
                    negative: null,
                    positive: lang.text("OK"),
                    isDismissible: true
                  );
                }
              },
              label: lang.text("Save"),
            ),
          ],
        ),
      ),
    );
  }
}
