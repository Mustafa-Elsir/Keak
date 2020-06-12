import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimePicker extends StatefulWidget {

  DateTimePicker({
    Key key,
    @required this.labelText,
    @required this.selectedDate,
    @required this.selectedTime,
    @required this.selectDate,
    @required this.selectTime
  }):super(key: key);

  final String labelText;
  final DateTime selectedDate;
  final TimeOfDay selectedTime;
  final ValueChanged<DateTime> selectDate;
  final ValueChanged<TimeOfDay> selectTime;

  @override
  _DateTimePickerState createState() => _DateTimePickerState(selectedDate, selectedTime);
}

class _DateTimePickerState extends State<DateTimePicker> {
  DateTime selectedDate;
  TimeOfDay selectedTime;

  _DateTimePickerState(this.selectedDate, this.selectedTime);

  Future<void> _selectDate (BuildContext context) async {

    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: widget.selectedDate,
      firstDate:new DateTime(1970, 8),
      lastDate:new DateTime(2101)
    );

    if (picked != null && picked != widget.selectedDate){
      setState(() {
        selectedDate = picked;
      });
      widget.selectDate(picked);
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: widget.selectedTime
    );
    if (picked != null && picked != widget.selectedTime) {
      setState(() {
        selectedTime = picked;
      });
      widget.selectTime(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle valueStyle = Theme.of(context).textTheme.bodyText2;
    return new Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[

        new Expanded(
          flex: 4,
          child: new _InputDropdown(
            labelText: widget.labelText,
            valueText: new DateFormat.yMMMd().format(selectedDate),
            valueStyle: valueStyle,
            onPressed: () {
              _selectDate(context);
            },
          ),
        ),
        const SizedBox(width: 12.0),
        new Expanded(
          flex: 3,
          child: new _InputDropdown(
            valueText: selectedTime.format(context),
            valueStyle: valueStyle,
            onPressed: () {
              _selectTime(context);
            },
          ),
        ),
      ],
    );
  }
}

class _InputDropdown extends StatelessWidget {
  const _InputDropdown({
    Key key,
    this.child,
    this.labelText,
    this.valueText,
    this.valueStyle,
    this.onPressed
  }) : super(key: key);

  final String labelText;
  final String valueText;
  final TextStyle valueStyle;
  final VoidCallback onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return new InkWell(
      onTap: onPressed,
      child:
      new InputDecorator(
        decoration: InputDecoration(
          labelText: labelText,
        ),
        baseStyle: valueStyle,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new Text(valueText, style: valueStyle),
            new Icon(Icons.arrow_drop_down,
              color: Theme.of(context).brightness == Brightness.light ?
                Colors.grey.shade700 : Colors.white70,
            ),
          ],
        ),
      ),
    );
  }
}