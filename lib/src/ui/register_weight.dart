import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:keak/src/custom_widget/alternative_button.dart';
import 'package:keak/src/custom_widget/date_time_picker.dart';
import 'package:keak/src/resources/repository.dart';
import 'package:keak/src/utils/dialog_utils.dart';
import 'package:keak/src/utils/global_translations.dart';

class RegisterWeight extends StatefulWidget {
  final Map item;

  const RegisterWeight({Key key, this.item}) : super(key: key);

  @override
  _RegisterWeightState createState() => _RegisterWeightState();
}

class _RegisterWeightState extends State<RegisterWeight> {
  final _repo = Repository();
  final controller = TextEditingController();
  DateTime date = DateTime.now();
  TimeOfDay timeOfDay = TimeOfDay.now();

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
                  lang.text("Enter day weight"),
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
                TextFormField(
                  controller: controller,
                  onChanged: (text){
                    setState(() {});
                  },
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    labelText: lang.text("Weight on this day"),
                  ),
                ),
                SizedBox(height: 16),
                AlternativeButton(
                  label: lang.text("Save"),
                  onPressed: controller.text.isEmpty? null : () async {
                    showLoadingDialog(context);
                    Map<String, dynamic> response = await _repo.registerWeight(
                      widget.item["id"],
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
