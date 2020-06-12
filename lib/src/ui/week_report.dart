import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:keak/src/custom_widget/key_value.dart';
import 'package:keak/src/ui/add_note.dart';
import 'package:keak/src/ui/add_weight.dart';
import 'package:keak/src/utils/global_translations.dart';

class WeekReport extends StatefulWidget {
  final Map item;

  WeekReport({Key key, this.item}) : super(key: key);

  @override
  _WeekReportState createState() => _WeekReportState();
}

class _WeekReportState extends State<WeekReport> {
  var f = new NumberFormat("#,###", lang.currentLanguage);
  List list = [
    {
      "title": "24-May",
      "morning_dead": 6,
      "evening_dead": 3,
      "init_count": 16000,
      "day_weight": 34,
    },
    {
      "title": "25-May",
      "morning_dead": 9,
      "evening_dead": 7,
      "init_count": 15991,
      "day_weight": 0,
    },
    {
      "title": "26-May",
      "morning_dead": 6,
      "evening_dead": 3,
      "init_count": 15975,
      "day_weight": 36,
    },
    {
      "title": "27-May",
      "morning_dead": 6,
      "evening_dead": 3,
      "init_count": 15966,
      "day_weight": 0,
    },
    {
      "title": "28-May",
      "morning_dead": 6,
      "evening_dead": 3,
      "init_count": 15957,
      "day_weight": 36,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.item["title"]),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.note_add),
            tooltip: lang.text("Add note"),
            onPressed: (){
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) {
                    return AddNote(
                      item: widget.item,
                    );
                  })
              );
            },
          ),
        ],
      ),
      body: Container(
        child: ListView.builder(
          padding: EdgeInsets.all(8),
          itemCount: list.length,
          itemBuilder: (context, index){
            var item = list[index];
            var allDayDead = item["morning_dead"] + item["evening_dead"];
            var finalCount = item["init_count"] - allDayDead;
            return Card(
              margin: EdgeInsets.symmetric(vertical: 4),
              child: InkWell(
                onTap: (){
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) {
                        return AddWeight(
                          item: item,
                        );
                      })
                  );
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
                        label: lang.text("Init count"),
                        value: "${f.format(item["init_count"])}",
                      ),
                      SizedBox(height: 8),
                      KeyValue(
                        label: lang.text("Morning dead"),
                        value: "${f.format(item["morning_dead"])}",
                      ),
                      SizedBox(height: 8),
                      KeyValue(
                        label: lang.text("Evening dead"),
                        value: "${f.format(item["evening_dead"])}",
                      ),
                      SizedBox(height: 8),
                      KeyValue(
                        label: lang.text("All day dead"),
                        value: "${f.format(allDayDead)}",
                      ),
                      SizedBox(height: 8),
                      KeyValue(
                        label: lang.text("Day weight"),
                        value: item["day_weight"] == 0? lang.text("Add day weight"): "${item["day_weight"]}",
                      ),
                      Divider(
                        height: 16,
                      ),
                      KeyValue(
                        label: lang.text("Final count"),
                        value: "${f.format(finalCount)}",
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
