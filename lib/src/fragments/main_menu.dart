import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:keak/src/custom_widget/empty_widget.dart';
import 'package:keak/src/custom_widget/loading_widget.dart';
import 'package:keak/src/ui/ambergris.dart';
import 'package:keak/src/utils/global_translations.dart';
import 'package:keak/src/utils/hex_color.dart';
import 'package:keak/src/utils/pref_manager.dart';

class MainMenu extends StatefulWidget {
  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  var f = new NumberFormat("#,###", lang.currentLanguage);
  var top = 0.0;
  final _prefManager = PrefManager();
  bool isLoading = true;
  List list = [];

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    setState(() {
      isLoading = true;
      list = [];
    });

    list = json.decode(await _prefManager.get("ambergris", "{}"));
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
//    return buildBody();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          lang.text("Dashboard"),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: getBodyContent(),
      ),
    );
  }

  Widget buildBody(){
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            getCustomSliverAppBar(),
          ];
        },
        body: getBodyContent(),
      ),
    );
  }

  Widget getCustomSliverAppBar(){
    return SliverAppBar(
      expandedHeight: 280.0,
      floating: true,
      pinned: true,
      stretch: true,
      elevation: 0.0,
      flexibleSpace: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          top = constraints.biggest.height;
          return FlexibleSpaceBar(
            collapseMode: CollapseMode.pin,
//            titlePadding: EdgeInsets.zero,
            centerTitle: true,
            title: AnimatedOpacity(
              duration: Duration(milliseconds: 100),
              opacity: top <= (AppBar().preferredSize.height+24) &&
                  top >= 0 ? 1.0 : 0.0,
              child: Container(
                margin: EdgeInsets.only(top: 16),
                child: Text(
                  lang.text("Dashboard"),
                ),
              ),
            ),
            background: Container(
              color: Colors.grey[50],
              padding: EdgeInsets.zero,
              margin: EdgeInsets.zero,
              child: Stack(
                overflow: Overflow.visible,
                children: [
                  Image(
                    image: AssetImage("assets/images/bg.png"),
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width,
                    height: 280,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 280,
                    color: Colors.black38,
                  ),
                  Positioned(
                    bottom: 64,
                    left: 16,
                    right: 16,
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            lang.text("Welcome to Keak"),
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 16),
                          Text(
                            lang.text("You can manage your farm here"),
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget getBodyContent(){
    if(isLoading){
      return LoadingWidget(
        size: 84,
        useLoader: true,
      );
    } else {
      if(list.isEmpty){
        return EmptyWidget(
          size: 128,
          message: lang.text("Fail to load ambergris"),
          subMessage: lang.text("Try to reopen the app"),
        );
      }
      return getBody();
    }
  }

  Widget getBody(){
    return Container(
      child: ListView.builder(
        padding: EdgeInsets.all(8),
        itemCount: list.length,
        itemBuilder: (context, index){
          var item = list[index];
          return Container(
            margin: EdgeInsets.all(8),
            child: InkWell(
              onTap: (){
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) {
                      return Ambergris(
                        item: item,
                      );
                    })
                );
              },
              child: Container(
                height: 160,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8)
                ),
                child: Stack(
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: new BorderRadius.circular(8.0),
                      child: Image(
                        image: CachedNetworkImageProvider(item["image"]),
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width,
                      ),
                    ),
                    Container(
                      height: 220,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: HexColor(item["color"], "44"),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      bottom: 0,
                      right: 0,
                      left: 0,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            item["name"],
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "${lang.text("Available")} ${f.format(int.parse("${item["available"]}"))}",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700
                            ),
                          ),
                        ],
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
