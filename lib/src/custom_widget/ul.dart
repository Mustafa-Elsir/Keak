import 'package:flutter/material.dart';

class Ul extends StatelessWidget {
  final List<String> list;

  const Ul({Key key, this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      subtitle: Column(
        children: this.list.map((o) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("• "),
              Expanded(
                child: Text(
                  o,
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              )
            ],
          );
        }).toList(),
      ),
    );
  }
}
