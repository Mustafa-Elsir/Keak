import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:keak/src/custom_widget/empty_widget.dart';
import 'package:keak/src/custom_widget/key_value.dart';
import 'package:keak/src/custom_widget/loading_widget.dart';
import 'package:keak/src/custom_widget/ul.dart';
import 'package:keak/src/resources/repository.dart';
import 'package:keak/src/ui/add_note.dart';
import 'package:keak/src/ui/add_weight.dart';
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
    Map<String, dynamic> response = await _repo.weeks(widget.item["id"]);
    isLoading = false;
    if (response.containsKey("success") && response["success"]) {
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
        title: Text(widget.item["name"]),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: buildBody(),
      ),
      floatingActionButton: SpeedDial(
        // both default to 16
        marginRight: 18,
        marginBottom: 20,
        animatedIcon: AnimatedIcons.menu_close,
        animatedIconTheme: IconThemeData(size: 22.0),
        // this is ignored if animatedIcon is non null
        // child: Icon(Icons.add),
//        visible: _dialVisible,
        // If true user is forced to close dial manually
        // by tapping main button and overlay is not rendered.
        closeManually: false,
        curve: Curves.bounceIn,
        overlayColor: Colors.black,
        overlayOpacity: 0.5,
        tooltip: lang.text("Register data"),
//        backgroundColor: Colors.white,
//        foregroundColor: Colors.black,
        elevation: 8.0,
        shape: CircleBorder(),
        children: [
          SpeedDialChild(
              child: SvgPicture.asset(
                "assets/icons/skull.svg",
                width: 12,
                color: Colors.white,
              ),
              backgroundColor: Colors.red,
              label: lang.text("Register Dead"),
              labelStyle: TextStyle(fontSize: 18.0),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) {
                    return RegisterDead(
                        ambergris: widget.item,
                    );
                  }),
                );
              }),
          SpeedDialChild(
            child: SvgPicture.asset(
              "assets/icons/weight.svg",
              width: 12,
              color: Colors.white,
            ),
            backgroundColor: Colors.blue,
            label: lang.text("Register weight"),
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return AddWeight(
                  item: widget.item,
                );
              }));
            },
          ),
          SpeedDialChild(
            child: SvgPicture.asset(
              "assets/icons/note.svg",
              width: 12,
              color: Colors.white,
            ),
            backgroundColor: Colors.green,
            label: lang.text("Register note"),
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return AddNote(
                  item: widget.item,
                );
              }));
            },
          ),
        ],
      ),
    );
  }

  Widget buildBody() {
    if (isLoading) {
      return LoadingWidget(
        size: 84.0,
        useLoader: true,
      );
    } else {
      if (list.isEmpty) {
        return EmptyWidget(
          size: 128,
          message: lang.text("No data yet"),
          subMessage: lang.text("Register your dead"),
        );
      } else {
        return getBody();
      }
    }
  }

  Widget getBody() {
    return Container(
      child: ListView.builder(
        padding: EdgeInsets.all(8),
        itemCount: list.length,
        itemBuilder: (context, index) {
          var item = list[index];
          var deadPercent = customRound(
              (int.parse("${item["total_dead"]}") /
                      int.parse("${item["init_count"]}")) *
                  100,
              2);
          return Card(
            margin: EdgeInsets.symmetric(vertical: 4),
            child: InkWell(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return WeekReport(
                    item: item,
                  );
                }));
              },
              child: Container(
                padding: EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "${lang.text("Week")}(${item["id"]}) ${item["week_year"]}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Divider(),
                    SizedBox(height: 8),
                    KeyValue(
                      label: lang.text("Total"),
                      value: f.format(int.parse("${item["init_count"]}")),
                    ),
                    KeyValue(
                      label: lang.text("Dead received"),
                      value: f.format(int.parse("${item["received_dead"]}")),
                    ),
                    KeyValue(
                      label: lang.text("Weight on receive"),
                      value:
                          "${customRound(double.parse("${item["weight_on_receive"]}"), 2)} ${lang.text("Kgm")}",
                    ),
                    Divider(height: 8),
                    KeyValue(
                      label: lang.text("Week dead"),
                      value: f.format(int.parse("${item["total_dead"]}")),
                    ),
                    KeyValue(
                      label: lang.text("Week dead percent"),
                      value: "$deadPercent %",
                    ),
                    KeyValue(
                      label: lang.text("Weight on end"),
                      value:
                          "${customRound(double.parse("${item["weight_avg"]}"), 2)} ${lang.text("Kgm")}",
                    ),
                    KeyValue(
                      label: lang.text("Final count"),
                      value: f.format(int.parse("${item["final_count"]}")),
                    ),
                    item["notes"].isEmpty ? Container() : Divider(height: 8),
                    item["notes"].isEmpty
                        ? Container()
                        : Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              border: Border(
                                  left: BorderSide(
                                color: Theme.of(context).primaryColor,
                                width: 4,
                              )),
                            ),
                            child: Ul(
                              list:
                                  List.generate(item["notes"].length, (index) {
                                return item["notes"][index]["note"];
                              }),
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
