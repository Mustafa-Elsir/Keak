import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:keak/src/utils/app_builder.dart';
import 'package:keak/src/utils/global_translations.dart';
import 'package:keak/src/utils/routes.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppBuilder(builder: (context) {
      return MaterialApp(
        locale: lang.locale,
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        // Tells the system which are the supported languages
        supportedLocales: lang.supportedLocales(),
        theme: ThemeData(
          fontFamily: lang.currentLanguage == "ar" ? "Tajawal" : "GoogleSans",
          primaryColorBrightness: Brightness.dark,
          primaryColor: Color(0xFF4CAF50),
          primaryColorDark: Color(0xFF388E3C),
          primaryColorLight: Color(0xFFC8E6C9),
          accentColor: Color(0xFF03A9F4),
          textSelectionColor: Color(0xFF757575),
//            primary_text:
          iconTheme: IconThemeData(
            color: Color(0xFFFFFFFF),
          ),
          dividerColor: Color(0xFFBDBDBD),
        ),
        routes: routes,
        debugShowCheckedModeBanner: false,
      );
    });
  }
}
