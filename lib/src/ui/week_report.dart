import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:keak/src/custom_widget/empty_widget.dart';
import 'package:keak/src/custom_widget/key_value.dart';
import 'package:keak/src/custom_widget/loading_widget.dart';
import 'package:keak/src/resources/repository.dart';
import 'package:keak/src/utils/global_translations.dart';
import 'package:keak/src/utils/utils.dart';

class WeekReport extends StatefulWidget {
  final Map item;

  WeekReport({Key key, this.item}) : super(key: key);

  @override
  _WeekReportState createState() => _WeekReportState();
}

class _WeekReportState extends State<WeekReport> {
  var f = new NumberFormat("#,###", lang.currentLanguage);
  final _repo = Repository();
  bool isLoading = true;
  List list = [];

  @override
  void initState() {
    init();
    super.initState();
  }

  init() async {
    setState(() {
      isLoading = true;
      list = [];
    });
    Map<String, dynamic> response = await _repo.days(
      widget.item["ambergris_id"],
      widget.item["init_count"],
      widget.item["begin_date"],
      widget.item["end_date"]
    );
    isLoading = false;
    if(response.containsKey("success") && response["success"]){
      list = response["list"];
    }
    setState(() {});
  }

  @override
  void dispose() {
    _repo.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${lang.text("Week")}(${widget.item["id"]}) ${widget.item["week_year"]}",
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: getBody(),
      ),
    );
  }

  Widget getBody(){
    if(isLoading){
      return LoadingWidget(
        size: 84,
        useLoader: true,
      );
    } else {
      if(list.isEmpty){
        return EmptyWidget(
          size: 128,
        );
      }
    }
    return buildBody();
  }

  Widget buildBody(){
    return Container(
      child: ListView.builder(
        padding: EdgeInsets.all(8),
        itemCount: list.length,
        itemBuilder: (context, index){
          var item = list[index];
          return Card(
            margin: EdgeInsets.symmetric(vertical: 4),
            child: Container(
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    DateFormat("dd MMM yyyy").format(DateFormat("yyyy-MM-dd").parse(item["day"], true)),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Divider(),
                  SizedBox(height: 8),
                  KeyValue(
                    label: lang.text("Init count"),
                    value: "${f.format(int.parse("${item["init_count"]}"))}",
                  ),
                  SizedBox(height: 8),
                  KeyValue(
                    label: lang.text("Morning dead"),
                    value: "${f.format(int.parse("${item["morning_dead"]}"))}",
                  ),
                  SizedBox(height: 8),
                  KeyValue(
                    label: lang.text("Evening dead"),
                    value: "${f.format(int.parse("${item["evening_dead"]}"))}",
                  ),
                  SizedBox(height: 8),
                  KeyValue(
                    label: lang.text("All day dead"),
                    value: "${f.format(int.parse("${item["total_dead"]}"))}",
                  ),
                  SizedBox(height: 8),
                  KeyValue(
                    label: lang.text("Day weight"),
                    value: double.parse("${item["weight_avg"]}") == 0.0?
                    lang.text("Add day weight"):
                    "${customRound(double.parse("${item["weight_avg"]}"), 2)}",
                  ),
                  Divider(
                    height: 16,
                  ),
                  KeyValue(
                    label: lang.text("Final count"),
                    value: "${f.format(int.parse("${item["final_count"]}"))}",
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
