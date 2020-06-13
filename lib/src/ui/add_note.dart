import 'package:flutter/material.dart';
import 'package:keak/src/custom_widget/alternative_button.dart';
import 'package:keak/src/custom_widget/date_time_picker.dart';
import 'package:keak/src/utils/global_translations.dart';

class AddNote extends StatefulWidget {
  final Map item;

  const AddNote({Key key, this.item}) : super(key: key);

  @override
  _AddNoteState createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  final controller = TextEditingController();
  DateTime date = DateTime.now();
  TimeOfDay timeOfDay = TimeOfDay.now();

  @override
  void initState() {
    if(widget.item["note"] != null){
      controller.text = "${widget.item["note"]}";
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.item["title"],
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: Column(
              children: <Widget>[
                Text(
                  lang.text("Add note for this week"),
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
                  maxLines: 5,
                  textInputAction: TextInputAction.newline,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    hintText: lang.text("write note"),
                  ),
                ),
                SizedBox(height: 16),
                AlternativeButton(
                  label: lang.text("Save"),
                  onPressed: (){
                    Navigator.of(context).pop();
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
