import 'package:flutter/material.dart';
import 'package:keak/src/custom_widget/key_value.dart';
import 'package:keak/src/utils/global_translations.dart';

class Ambergris extends StatefulWidget {
  final Map item;

  Ambergris({Key key, this.item}) : super(key: key);

  @override
  _AmbergrisState createState() => _AmbergrisState();
}

class _AmbergrisState extends State<Ambergris> {
  List list = [
    {
      "title": lang.text("Week(1)"),
      "total": "13,000",
      "strain": "Neo casle",
      "dead_recived": "100",
      "weight_on_receive": "39 Kgm"
    },
    {
      "title": lang.text("Week(2)"),
      "total": "13,000",
      "strain": "Neo casle",
      "dead_recived": "100",
      "weight_on_receive": "39 Kgm"
    },
    {
      "title": lang.text("Week(3)"),
      "total": "13,000",
      "strain": "Neo casle",
      "dead_recived": "100",
      "weight_on_receive": "39 Kgm"
    },
    {
      "title": lang.text("Week(4)"),
      "total": "13,000",
      "strain": "Neo casle",
      "dead_recived": "100",
      "weight_on_receive": "39 Kgm"
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
                      KeyValue(
                        label: lang.text("Strain"),
                        value: item["strain"],
                      ),
                      KeyValue(
                        label: lang.text("Dead received"),
                        value: item["dead_recived"],
                      ),
                      KeyValue(
                        label: lang.text("Weight on receive"),
                        value: item["weight_on_receive"],
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
