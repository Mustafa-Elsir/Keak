import 'package:flutter/material.dart';
import 'package:keak/src/custom_widget/alternative_button.dart';
import 'package:keak/src/custom_widget/date_time_picker.dart';
import 'package:keak/src/utils/dialog_utils.dart';
import 'package:keak/src/utils/global_translations.dart';

class RegisterDead extends StatefulWidget {
  final Map ambergris;

  RegisterDead({Key key, this.ambergris}) : super(key: key);

  @override
  _RegisterDeadState createState() => _RegisterDeadState();
}

class _RegisterDeadState extends State<RegisterDead> {
  DateTime date = DateTime.now();
  TimeOfDay timeOfDay = TimeOfDay.now();
  final controller = TextEditingController();

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
              widget.ambergris["title"],
              style: TextStyle(
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "${lang.text("Current available")} (13,160)",
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
                print("date: $date");
              },
              selectedDate: date,
              selectedTime: timeOfDay,
              selectTime: (TimeOfDay time){
                print("time: $time");
              },
            ),

            SizedBox(height: 8),
            TextFormField(
              controller: controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: lang.text("Number of dead"),
              ),
            ),

            SizedBox(height: 24),
            AlternativeButton(
              onPressed: () async {
                showLoadingDialog(context);
                await Future.delayed(Duration(seconds: 1));
                Navigator.of(context).pop();
                bool done = await showCustomSuccessDialog(context,
                  title: "Success",
                  subtitle: "data added successfully",
                  negative: null,
                  isDismissible: true
                );
                print("done: $done");
                Navigator.of(context).pop();
              },
              label: lang.text("Save"),
            ),
          ],
        ),
      ),
    );
  }
}
