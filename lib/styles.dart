import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTheme {
  /* final Color primaryColor = Color(0xff005b96);
  final Color backgroundColor = Color(0xffffffff);
  final Color accentColor = Color(0xff03396c);
  final Color buttonColor = Color(0xff011f4b);
  final Color textColor = Colors.black;*/

  final Color primaryColor = Color(0xff5b6dcf);
  final Color backgroundColor = Color(0xffffffff);
  final Color accentColor = Color(0xff3F51B5);
  final Color buttonColor = Color(0xff26316D);
  final Color textColor = Colors.black;

  ///Dark Theme
  final Color dprimaryColor = Color(0xff5b6dcf);
  final Color dbackgroundColor = Color(0xff000000);
  final Color daccentColor = Color(0xff3F51B5);
  final Color dbuttonColor = Color(0xff26316D);
  final Color dtextColor = Colors.white;

  //  Color(0xff3425AF),
  //  Color(0xffC56CD6),

  ///Jayanth
  ThemeData themeData() {
    return ThemeData(
      fontFamily: 'Roboto',

      ///accentColor to focusColor
      // accentColor: accentColor,
      focusColor: accentColor,
      primaryColor: primaryColor,
      canvasColor: backgroundColor,

      ///buttonColor to cardColor
      // buttonColor: buttonColor,
      cardColor: buttonColor,
      textTheme: TextTheme(bodyLarge: TextStyle(color: Colors.black)),
      appBarTheme: AppBarTheme(
        color: primaryColor,
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      hintColor: Colors.black,
      buttonTheme: ButtonThemeData(buttonColor: accentColor),
      visualDensity: VisualDensity.comfortable,
      // colorScheme: ColorScheme(background: backgroundColor)
    );
  }

  ThemeData darkThemeData() {
    return ThemeData(
      fontFamily: 'Roboto',

      ///accentColor to focusColor
      // accentColor: accentColor,
      focusColor: daccentColor,
      primaryColor: dprimaryColor,
      canvasColor: dbackgroundColor,

      ///buttonColor to cardColor
      // buttonColor: buttonColor,
      cardColor: dbuttonColor,
      textTheme: TextTheme(bodyLarge: TextStyle(color: Colors.white)),
      appBarTheme: AppBarTheme(
        color: dprimaryColor,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      hintColor: Colors.white,
      buttonTheme: ButtonThemeData(buttonColor: daccentColor),
      visualDensity: VisualDensity.comfortable,
      // colorScheme: ColorScheme(background: dbackgroundColor));
      // colorScheme: ColorScheme(background: dbackgroundColor)
    );
  }
}
