import 'dart:async';
import 'dart:convert';

import 'package:covidtrackerapp/api/fetches.dart';
import 'package:covidtrackerapp/models/country_details.model.dart';
import 'package:covidtrackerapp/screens/contry-details-page.dart';
import 'package:covidtrackerapp/screens/country-search-screen.dart';
import 'package:covidtrackerapp/screens/settings-screen.dart';
import 'package:covidtrackerapp/screens/world-screen.dart';
import 'package:covidtrackerapp/widget/details_section.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = "/home";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  Future<DataModel> _fetchSomeData(String country) {
    return fetchDataCountry(
        country: country,
        to: DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day),
        from: DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day - 1));
  }

  Animation<double> animation;
  AnimationController resizeController;
  bool canVibrate = false;
  String country;
  bool isFirstRender;
  @override
  void initState() {
    super.initState();
    country = "ukraine";
    _scrollBarOffset = 300.0;
    resizeController = AnimationController(
        duration: const Duration(milliseconds: 200), vsync: this);
    isFirstRender = true;
  }

  double _scrollBarOffset = 300.0;
  double _startScrollPoint = 0;

  Widget topOverflow() {
    return SizedBox(
        width: double.infinity,
        height: _scrollBarOffset,
        child: GestureDetector(
            onVerticalDragStart: (tapDetails) {
              print(tapDetails);
              setState(() {
                _startScrollPoint = tapDetails.globalPosition.dy;
              });
            },
            onVerticalDragUpdate: (tapDetails) {

              if (
                  tapDetails.globalPosition.dy -
                  MediaQuery.of(context).padding.top +
                  kToolbarHeight -
                  _startScrollPoint
              >
                  0) {

                setState(() => _scrollBarOffset = 300 +
                    tapDetails.globalPosition.dy -
                    MediaQuery.of(context).padding.top +
                    kToolbarHeight -
                    _startScrollPoint);
              }
            },
            onVerticalDragEnd: (tapDetails) {
              if (_scrollBarOffset > 350) {
                _startScrollPoint = 0.0;
                animation = Tween<double>(
                        begin: _scrollBarOffset,
                        end: MediaQuery.of(context).size.height)
                    .animate(resizeController)
                      ..addListener(() {
                        setState(() {
                          _scrollBarOffset = animation.value;
                        });
                      });
                resizeController.forward().then((f) {
                  Timer(Duration(milliseconds: 100), () {
                    Navigator.pushNamed(context, CountyDetails.routeName,
                            arguments: jsonEncode(
                                {"payload": "ukraine", "name": "Ukraine"}))
                        .then((_) {
                      setState(() {
                        _scrollBarOffset = 300;
                      });
                    });
                  });
                });
              } else {
                setState(() {
                  _scrollBarOffset = 300;
                });
              }
            },
            child: Container(
              color: Colors.transparent,
              width: double.infinity,
              height: _scrollBarOffset,
            )));
  }

  Widget buildTopSheet(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: _scrollBarOffset,
      child: Hero(
        tag: "topBar",
        child: Container(

          child: Padding( 
            padding:  EdgeInsets.only(
                top: 24.0, left: 24.0, right: 24.0, bottom: 5),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "In Ukraine:",
                      style: Theme.of(context).textTheme.headline,
                    ),
                  ),
                  Spacer(),
                  SizedBox(
                    height: 10,
                  ),
                  FutureBuilder<DataModel>(
                    future: _fetchSomeData(this.country),
                    builder: (BuildContext context,
                        AsyncSnapshot<DataModel> snapshot) {
                      Widget child;
                      if (snapshot.hasData) {
                        DataModel data = snapshot.data;
                        final String confirmed = data.confirmed;
                        final String recovered = data.recovered;
                        final String deaths = data.deaths;

                        child = Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 24.0, horizontal: 16.0),
                          child: Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "Confirmed:",
                                    style: Theme.of(context).textTheme.body1,
                                  ),
                                  Text("$confirmed",
                                      style: Theme.of(context).textTheme.body2)
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text("Recovered:",
                                      style: Theme.of(context).textTheme.body1),
                                  Text("$recovered",
                                      style: Theme.of(context).textTheme.body2)
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text("Deaths:",
                                      style: Theme.of(context).textTheme.body1),
                                  Text("$deaths",
                                      style: Theme.of(context).textTheme.body2)
                                ],
                              ),
                            ],
                          ),
                        );
                      } else if (snapshot.hasError) {
                        child = Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Oops, cannot get data",
                            style: Theme.of(context).textTheme.headline,
                          ),
                        );
                      } else {
                        child = Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 24.0, horizontal: 16.0),
                          child: Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "Confirmed:",
                                    style: Theme.of(context).textTheme.body1,
                                  ),
                                  placeholderContainer(),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text("Recovered:",
                                      style: Theme.of(context).textTheme.body1),
                                  placeholderContainer(),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text("Deaths:",
                                      style: Theme.of(context).textTheme.body1),
                                  placeholderContainer(),
                                ],
                              ),
                            ],
                          ),
                        );
                      }
                      return child;
                    },
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Spacer(),
                  Center(
                    child: Container(
                      height: 25,
                      color: Colors.transparent,
                      child: Center(
                        child: Container(
                          margin: EdgeInsets.only(top: 14, bottom: 4),
                          width: 75,
                          height: 5,
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(54, 54, 54, 1),
                              borderRadius: new BorderRadius.all(
                                Radius.circular(5.0),
                              )),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget bodyItem(String title, String hint, BuildContext context, onClick) {
    return new FlatButton(
      onPressed: () {
        onClick();
      },
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(
                  fontSize: 40, color: Theme.of(context).primaryColorLight),
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              hint,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                  fontWeight: FontWeight.w300),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          elevation: 0.0,
        ),
        body: Container(
          color: Theme.of(context).primaryColorDark,
          child: Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 230.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 70,
                      ),
                      Hero(
                        tag: "worldSeсtion",
                        child: bodyItem("Global",
                            "tap to see the world statistics", context, () {
                          Navigator.pushNamed(context, WorldScreen.routeName);
                        }),
                      ),
                      Divider(
                        height: 5,
                        color: Theme.of(context).primaryColorLight,
                        indent: 25,
                        endIndent: 25,
                      ),
                      
                      Hero(
                        tag: "county-search",
                        child:
                            bodyItem("Countries", "tap to search", context, () {
                          Navigator.pushNamed(
                              context, CountrySearchScreen.routeName);
                        }),
                      ),
                      Divider(
                        height: 5,
                        color: Theme.of(context).primaryColorLight,
                        indent: 25,
                        endIndent: 25,
                      ),
                      bodyItem("Settings", "",
                          context, () {
    Navigator.pushNamed(
    context, SettingsScreen.routeName);

                          }),
                    ],
                  ),
                ),
              ),
              Container(
                color: Colors.transparent,
                child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(50),
                        bottomLeft: Radius.circular(50)),
                    child: Container(
                        decoration: BoxDecoration(
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: Offset(0, 3),
                            )
                          ],
                          color: Theme.of(context).primaryColor,
                        ),

                        child: buildTopSheet(context))),
              ),
              topOverflow()
            ],
          ),
        ));
  }
}
