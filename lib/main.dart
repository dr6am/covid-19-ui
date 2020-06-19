import 'package:covidtrackerapp/screens/HomeScreen.dart';
import 'package:covidtrackerapp/screens/contry-details-page.dart';
import 'package:covidtrackerapp/screens/country-search-screen.dart';
import 'package:covidtrackerapp/screens/settings-screen.dart';
import 'package:covidtrackerapp/screens/world-screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Covid-19',
      theme: ThemeData(
        canvasColor: Colors.transparent,
        //primaryColor: Color.fromRGBO(247, 247, 247, 1),
        primaryColor: Color.fromRGBO(255, 195, 130, 1),
        //primaryColor: Color.fromRGBO(255, 204, 153, 1),
        primaryColorLight: Color.fromRGBO(225, 224, 224, 1),
        primaryColorDark: Color.fromRGBO(54, 54, 54, 1),
        accentColor: Colors.deepPurple[300],
        brightness: Brightness.light,
//        fontFamily: "Open Sans",
        textTheme: TextTheme(
            headline: TextStyle(
              fontSize: 36.0,
              fontWeight: FontWeight.w800,
              color: Color.fromRGBO(54, 54, 54, 1),
              letterSpacing: 1.5
            ),
            subhead: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.w800,
              color: Color.fromRGBO(54, 54, 54, 1),
            ),
            body1: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.w600,
              color: Color.fromRGBO(54, 54, 54, 1),
            ),
            body2: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.w400,
              color: Color.fromRGBO(54, 54, 54, 1),
            ),
            display2: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.w600,
              color: Color.fromRGBO(245, 242, 240, 1),
            ),
            display4: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w600,
              color: Color.fromRGBO(54, 54, 54, 1),
            ),
            caption: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w300,
              color: Color.fromRGBO(54, 54, 54, 1),
              //color: Color.fromRGBO(38, 35, 192, 1),
            )),
      ),
      home: HomeScreen(),
      routes: {
        HomeScreen.routeName: (ctx) => HomeScreen(),
        CountyDetails.routeName: (ctx) => CountyDetails(),
        WorldScreen.routeName: (ctx) => WorldScreen(),
        CountrySearchScreen.routeName: (ctx) => CountrySearchScreen(),
        SettingsScreen.routeName: (ctx) => SettingsScreen(),
      },
    );
  }
}
