//sweet theme for the app
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
//import google fonts
import 'package:google_fonts/google_fonts.dart';

//winter theme
const MaterialColor winterColor = MaterialColor(
  0xff091a31,
  <int, Color>{
    50: Color(0xff091a31),
    100: Color.fromARGB(225, 9, 26, 49),
    200: Color.fromARGB(200, 9, 26, 49),
    300: Color.fromARGB(175, 9, 26, 49),
    400: Color.fromARGB(150, 9, 26, 49),
    500: Color.fromARGB(125, 9, 26, 49),
    600: Color.fromARGB(100, 9, 26, 49),
    700: Color.fromARGB(75, 9, 26, 49),
    800: Color.fromARGB(50, 9, 26, 49),
    900: Color.fromARGB(25, 9, 26, 49),
  },
);
ThemeData winterTheme(Brightness brightness) {
  return ThemeData(
    brightness: brightness,
    primarySwatch: winterColor,
    //set button color to be blue
    buttonTheme: const ButtonThemeData(
      buttonColor: Colors.blue,
      textTheme: ButtonTextTheme.primary,
      //button round rectangle
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
    ),
    //elevated button blue
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blueAccent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ),
    //how to make drop down field seperate by lines

    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(10),
      border: UnderlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      //set the color of the input text
      filled: true,
      fillColor: //cardthem color
          brightness == Brightness.light ? Colors.grey[200] : Colors.grey[800],
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,

    //set the color of the text

    textTheme: const TextTheme(
      //cỡ chữ của title/ appbar là headline1
      headline1: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
      //cỡ chữ của Text là headline6
      headline6: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
      //cỡ chữ của text trong button
      button: TextStyle(fontSize: 14.0),

      bodyText2: TextStyle(fontSize: 16.0),
      //cỡ chữ của textformfield, cỡ chữ to để bác sĩ vào điền cho dễ nhìn
      subtitle1: TextStyle(fontSize: 18.0),
      //cỡ chữ label
      subtitle2: TextStyle(fontSize: 18.0),
      //cỡ chữ error
      caption: TextStyle(fontSize: 12.0),
    ),
  );
}

//summer theme

ThemeData summerTheme(Brightness brightness) {
  return ThemeData(
    brightness: brightness,
    primarySwatch: Colors.lightBlue,
    backgroundColor: Colors.white,
    scaffoldBackgroundColor: Colors.white,
    textTheme: const TextTheme(
      headline1: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
      headline6: TextStyle(
        fontSize: 18.0,
      ),
      bodyText2: TextStyle(fontSize: 20.0, fontFamily: 'Raleway'),
    ),
  );
}

//autumn theme
ThemeData autumnTheme(Brightness brightness) {
  return ThemeData(
    primarySwatch: Colors.orange,
    backgroundColor: Colors.white,
    scaffoldBackgroundColor: Colors.white,
    textTheme: const TextTheme(
      headline1: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
      headline6: TextStyle(
        fontSize: 18.0,
      ),
      bodyText2: TextStyle(
        fontSize: 20.0,
        fontFamily: 'Hind',
      ),
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: Colors.orange,
      textTheme: ButtonTextTheme.primary,
    ),
  );
}

//spring theme
ThemeData springTheme(Brightness brightness) {
  return ThemeData(
    primarySwatch: Colors.green,
    backgroundColor: Colors.white,
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    textTheme: const TextTheme(
      headline1: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
      headline6: TextStyle(fontSize: 18.0),
      bodyText2: TextStyle(fontSize: 20.0, fontFamily: 'Hind'),
    ),
  );
}
