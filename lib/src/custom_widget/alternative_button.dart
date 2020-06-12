import 'package:flutter/material.dart';

class AlternativeButton extends StatelessWidget {
  final label;
  final VoidCallback onPressed;
  final Color color;
  final Color textColor;

  const AlternativeButton({Key key, @required this.label, this.onPressed, this.color, this.textColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: RaisedButton(
        color: color ?? Theme.of(context).primaryColor,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: label is String? Text(label): label,
        ),
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        textColor: textColor ?? Colors.white,
        onPressed: onPressed,
      ),
    );
  }
}
