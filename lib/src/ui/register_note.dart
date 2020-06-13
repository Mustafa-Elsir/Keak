import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:keak/src/custom_widget/alternative_button.dart';
import 'package:keak/src/custom_widget/date_time_picker.dart';
import 'package:keak/src/resources/repository.dart';
import 'package:keak/src/utils/dialog_utils.dart';
import 'package:keak/src/utils/global_translations.dart';

class RegisterNote extends StatefulWidget {
  final Map item;

  const RegisterNote({Key key, this.item}) : super(key: key);

  @override
  _RegisterNoteState createState() => _RegisterNoteState();
}

class _RegisterNoteState extends State<RegisterNote> {
  final _repo = Repository();
  final controller = TextEditingController();
  DateTime date = DateTime.now();
  TimeOfDay timeOfDay = TimeOfDay.now();

  @override
  void initState() {
    super.initState();
  }

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
          widget.item["name"],
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: Column(
              children: <Widget>[
                Text(
                  lang.text("Add notes by days"),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                SizedBox(height: 24),
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
                  maxLines: 5,
                  onChanged: (text){
                    setState(() {});
                  },
                  textInputAction: TextInputAction.newline,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    hintText: lang.text("write note"),
                  ),
                ),
                SizedBox(height: 16),
                AlternativeButton(
                  label: lang.text("Save"),
                  onPressed: controller.text.isEmpty? null : () async {
                    showLoadingDialog(context);
                    Map<String, dynamic> response = await _repo.registerNote(
                      "${widget.item["id"]}",
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
