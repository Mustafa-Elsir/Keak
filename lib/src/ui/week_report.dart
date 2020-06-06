import 'package:flutter/material.dart';
import 'package:keak/src/custom_widget/key_value.dart';
import 'package:keak/src/utils/global_translations.dart';

class WeekReport extends StatefulWidget {
  final Map item;

  WeekReport({Key key, this.item}) : super(key: key);

  @override
  _WeekReportState createState() => _WeekReportState();
}

class _WeekReportState extends State<WeekReport> {
  @override
  Widget build(BuildContext context) {
    List list = [
      {
        "day": "24-May",

      }
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.item["title"]),
      ),
      body: Container(
        child: ListView.builder(
          padding: EdgeInsets.all(8),
          itemCount: list.length,
          itemBuilder: (context, index){
            var item = list[index];
            return Card(
              margin: EdgeInsets.symmetric(vertical: 4),
              child: InkWell(
                onTap: (){

                },
                child: Container(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        item["title"],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Divider(),
                      SizedBox(height: 8),
                      KeyValue(
                        label: lang.text("Total"),
                        value: item["total"],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
