import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:keak/src/custom_widget/key_value.dart';
import 'package:keak/src/ui/register_dead.dart';
import 'package:keak/src/ui/week_report.dart';
import 'package:keak/src/utils/global_translations.dart';
import 'package:keak/src/utils/utils.dart';

class Ambergris extends StatefulWidget {
  final Map item;

  Ambergris({Key key, this.item}) : super(key: key);

  @override
  _AmbergrisState createState() => _AmbergrisState();
}

class _AmbergrisState extends State<Ambergris> {
  var f = new NumberFormat("#,###", lang.currentLanguage);
  List list = [
    {
      "title": lang.text("Week(1)"),
      "total": 13000,
      "strain": "Neo casle",
      "dead_recived": 100,
      "weight_on_receive": 39,
      "week_dead": 365,
      "weight_on_end": 40, //  ${lang.text("Kgm")}
      "note": ""
    },
    {
      "title": lang.text("Week(2)"),
      "total": 13000,
      "strain": "Neo casle",
      "dead_recived": 100,
      "weight_on_receive": 39,
      "week_dead": 365,
      "weight_on_end": 40, //  ${lang.text("Kgm")}
      "note": ""
    },
    {
      "title": lang.text("Week(3)"),
      "total": 13000,
      "strain": "Neo casle",
      "dead_recived": 100,
      "weight_on_receive": 39,
      "week_dead": 365,
      "weight_on_end": 40, //  ${lang.text("Kgm")}
      "note": ""
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.item["title"]
        ),
      ),
      body: getBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) {
              return RegisterDead(
                  ambergris: widget.item,
              );
            }),
          );
        },
        child: Icon(Icons.add, color: Colors.white,),
      ),
    );
  }

  Widget getBody(){
    return Container(
      child: ListView.builder(
        padding: EdgeInsets.all(8),
        itemCount: list.length,
        itemBuilder: (context, index){
          var item = list[index];
          var finalCount = item["total"] - item["week_dead"];
          var deadPercent = customRound((item["week_dead"] / item["total"]) * 100, 2);

          return Card(
            margin: EdgeInsets.symmetric(vertical: 4),
            child: InkWell(
              onTap: (){
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) {
                      return WeekReport(
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
                      label: lang.text("Total"),
                      value: f.format(item["total"]),
                    ),
                    KeyValue(
                      label: lang.text("Strain"),
                      value: item["strain"],
                    ),
                    KeyValue(
                      label: lang.text("Dead received"),
                      value: f.format(item["dead_recived"]),
                    ),
                    KeyValue(
                      label: lang.text("Weight on receive"),
                      value: "${item["weight_on_receive"]} ${lang.text("Kgm")}",
                    ),
                    Divider(height: 8),

                    KeyValue(
                      label: lang.text("Week dead"),
                      value: f.format(item["week_dead"]),
                    ),
                    KeyValue(
                      label: lang.text("Week dead"),
                      value: "$deadPercent %",
                    ),
                    KeyValue(
                      label: lang.text("Weight on end"),
                      value: "${item["weight_on_end"]} ${lang.text("Kgm")}",
                    ),
                    KeyValue(
                      label: lang.text("Final count"),
                      value: f.format(finalCount),
                    ),
                    item["note"].toString().isEmpty? Container():
                    Divider(height: 8),
                    item["note"].toString().isEmpty? Container():
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: Border(
                          left: BorderSide(
                            color: Theme.of(context).primaryColor,
                            width: 4,
                          )
                        ),
                      ),
                      child: Text(
                        item["note"],
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

}
