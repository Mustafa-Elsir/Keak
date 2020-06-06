import 'package:flutter/material.dart';

class MoreItem extends StatelessWidget{
  final icon;
  final String label;
  final onTap;
  final bool hasArrow;
  final color;
  MoreItem({
    @required this.label,
    @required this.onTap,
    this.icon = Icons.settings,
    this.hasArrow = true,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    var itemColor = color ?? Theme.of(context).primaryColorDark;
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(this.icon, color: itemColor,),
                SizedBox(width: 8,),
                Text(this.label, style: TextStyle(
                  color: itemColor
                ),)
              ],
            ),
            hasArrow? Icon(Icons.chevron_right, color: itemColor,): Container(),
          ],
        ),
      ),
      onTap: this.onTap,
    );
  }
}