import 'package:flutter/material.dart';
import 'package:keak/src/custom_widget/alternative_button.dart';
import 'package:keak/src/utils/global_translations.dart';

class AddWeight extends StatefulWidget {
  final Map item;

  const AddWeight({Key key, this.item}) : super(key: key);

  @override
  _AddWeightState createState() => _AddWeightState();
}

class _AddWeightState extends State<AddWeight> {
  final controller = TextEditingController();

  @override
  void initState() {
    if(widget.item["day_weight"] != 0){
      controller.text = "${widget.item["day_weight"]}";
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          lang.text("Day 24-May"),
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
                TextFormField(
                  controller: controller,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    labelText: lang.text("Weight on this day"),
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
