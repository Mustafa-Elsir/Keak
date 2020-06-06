import 'package:flutter/material.dart';
import 'package:keak/src/fragments/main_menu.dart';
import 'package:keak/src/fragments/more.dart';
import 'package:keak/src/utils/dialog_utils.dart';
import 'package:keak/src/utils/global_translations.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
//        child: MainMenu(),
        child: [
//          Profile(),
          MainMenu(),
//          NotificationsList(),
          More(),
        ][_selectedIndex],
        onWillPop: onWillPop,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
//          BottomNavigationBarItem(
//            icon: Icon(Icons.person),
//            title: Text(lang.text("Profile")),
//          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text(lang.text("Home")),
          ),
//          BottomNavigationBarItem(
//            icon: Icon(Icons.notifications),
//            title: Text(lang.text("Notifications")),
//          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.more_horiz),
            title: Text(lang.text("More")),
          ),
        ],
        currentIndex: _selectedIndex,
//        selectedItemColor: Colors.amber[800],
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
  Future<bool> onWillPop() async {
    if(_selectedIndex != 0){
      setState(() {
        _selectedIndex = 0;
      });
      return false;
    } else {
      return showCustomErrorDialog(context);
    }
  }
}
