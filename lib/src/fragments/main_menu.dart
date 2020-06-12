import 'package:flutter/material.dart';
import 'package:keak/src/ui/ambergris.dart';
import 'package:keak/src/utils/global_translations.dart';
import 'package:keak/src/utils/hex_color.dart';

class MainMenu extends StatefulWidget {
  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  var top = 0.0;
  List list = [
    {
      "title": lang.text("Ambergris (A)"),
      "subtitle": "${lang.text("Available")} 12,000",
      "color": "#00a5af",
      "image": "assets/images/bg-1.jpg"
    },
    {
      "title": lang.text("Ambergris (B)"),
      "subtitle": "${lang.text("Available")} 22,000",
      "color": "#af9019",
      "image": "assets/images/bg-2.jpg"
    },
    {
      "title": lang.text("Ambergris (C)"),
      "subtitle": "${lang.text("Available")} 10,000",
      "color": "#000000",
      "image": "assets/images/bg-3.jpg"
    },
    {
      "title": lang.text("Ambergris (D)"),
      "subtitle": "${lang.text("Available")} 32,000",
      "color": "#aa9a00",
      "image": "assets/images/bg-1.jpg"
    },
  ];
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
      body: getBodyContent(),
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
                        image: AssetImage(item["image"]),
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
                            item["title"],
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            item["subtitle"],
                            style: TextStyle(
                              color: Colors.white,
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
