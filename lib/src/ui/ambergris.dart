import 'package:flutter/material.dart';

class Ambergris extends StatefulWidget {
  final Map item;

  Ambergris({Key key, this.item}) : super(key: key);

  @override
  _AmbergrisState createState() => _AmbergrisState();
}

class _AmbergrisState extends State<Ambergris> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.item["title"]
        ),
      ),
      body: Container(
        child: Center(
          child: Text(
            "${widget.item}"
          ),
        ),
      ),
    );
  }
}
