import 'package:flutter/material.dart';
import 'package:keak/src/utils/app_builder.dart';
import 'package:keak/src/utils/global_translations.dart';

class LanguageSelectorRadio extends StatefulWidget {
  final Function(String) onLanguageChange;

  const LanguageSelectorRadio({Key key, this.onLanguageChange}) : super(key: key);

  @override
  _LanguageRadioState createState() => _LanguageRadioState();
}

class _LanguageRadioState extends State<LanguageSelectorRadio> {
  String _language;
  @override
  void initState() {
    super.initState();
    _language = lang.currentLanguage;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      primary: false,
      shrinkWrap: true,
      children: _languageItems(),
    );
  }
  List<Widget> _languageItems() {
    List<Widget> list = [];

    lang.supportedLocales().forEach((language) {
      list.add(
          Container(
            child: Row(
              children: <Widget>[
                Radio<String>(
                  value: language.languageCode,
                  groupValue: _language,
                  onChanged: _handleLanguageChange,
//                  activeColor: Theme.of(context).primaryColor,
                ),
                SizedBox(width: 8,),
                Expanded(
                  child: GestureDetector(
                    onTap: (){
                      _handleLanguageChange(language.languageCode);
                    },
                    child: Text(
                      lang.text("i18n_${language.languageCode}"),
                      style: new TextStyle(fontSize: 16.0),
                    ),
                  ),
                ),
              ],
            ),
          )
      );
    });

    return list;
  }
  void _handleLanguageChange(String value) async {
    var oldLanguage = _language;
    setState(() {
      _language = value;
    });
    bool agree = await _agreeChangeLanguage();
    if(agree){

      await lang.setNewLanguage(value, true);
      AppBuilder.of(context).rebuild();
      widget.onLanguageChange(value);
    } else {
      setState(() {
        _language = oldLanguage;
      });
    }
  }

  Future<bool> _agreeChangeLanguage() async {
    // flutter defined function
    var status = await showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
            content: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(lang.text("Change Settings"),
                    style: TextStyle(
                      fontSize: 18,
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16,),
                  Text(
                    lang.text("Change language may change alignment direction, Are you sure you want to do that?"),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 16,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      RaisedButton(
                          child: new Text(
                            lang.text("Agree"),
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () async {
                            Navigator.of(context).pop(true);
                          },
                          color: Theme.of(context).primaryColor,
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0))
                      ),
                      RaisedButton(
                          child: new Text(
                            lang.text("Not agree"),
                            style: TextStyle(color: Colors.black),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop(false);
                          },
                          color: Color(0xFFe6e6e6),
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0))
                      ),
                    ],
                  ),
                ],
              ),
            ),
            contentPadding: EdgeInsets.only(
                top: 32, bottom: 8, left: 16, right: 16),
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(16.0))
        );
      },
    );
    return status ?? false;
  }

}
