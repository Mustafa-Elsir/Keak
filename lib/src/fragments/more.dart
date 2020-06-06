import 'package:flutter/material.dart';
import 'package:keak/src/custom_widget/more_item.dart';
import 'package:keak/src/utils/global_translations.dart';
import 'package:keak/src/utils/pref_manager.dart';
import 'package:keak/src/utils/routes.dart';

class More extends StatefulWidget {
  @override
  _MoreState createState() => _MoreState();
}

class _MoreState extends State<More> {
  final _prefManager = PrefManager();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          lang.text("More"),
        ),
      ),
      body: SafeArea(
        child: Container(
          child: ListView(
            padding: EdgeInsets.only(top: 8),
            children: <Widget>[
              MoreItem(label: lang.text("Settings"), icon: Icons.settings, onTap: (){
                Navigator.of(context).pushNamed(settingsRoute);
              },),
//              Divider(color: Colors.grey, height: 2,),
//              MoreItem(label: lang.text("i18n_40"), icon: Icons.call, onTap: (){
////                Navigator.of(context).pushNamed(contactUsRoute);
//              },),
//              Divider(color: Colors.grey, height: 2,),
//              MoreItem(label: lang.text("About"), icon: Icons.info_outline, onTap: (){
//                Navigator.of(context).pushNamed(aboutUsRoute);
//              },),
              Divider(color: Colors.grey, height: 2,),
              MoreItem(label: lang.text("Logout"), icon: Icons.remove_circle_outline, onTap: () async {
//                bool logout = await showCustomErrorDialog(context,
//                    lang.text("i18n_43"),
//                    lang.text("i18n_44"),
//                    lang.text("i18n_42")
//                );
//                if(logout){
//                  await _prefManager.remove("user.data");
//                  await _prefManager.remove("phone");
//                  await _prefManager.remove("token");
//                  Navigator.of(context).pushNamedAndRemoveUntil(registerRoute, ModalRoute.withName("/no_name"));
//                }
              },),
            ],
          ),
        ),
      ),
    );
  }
}
