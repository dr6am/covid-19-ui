import 'package:covidtrackerapp/api/fetches.dart';
import 'package:covidtrackerapp/models/country_details.model.dart';
import 'package:covidtrackerapp/widget/details_section.dart';
import 'package:covidtrackerapp/widget/global-country-card.dart';
import 'package:flutter/material.dart';

class WorldScreen extends StatelessWidget {
  static final String routeName = "/world";

  final Color mainColor = Colors.lightGreen[300];

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "worldSeсtion",
      child: Scaffold(
      appBar: AppBar(
          backgroundColor: mainColor,
          title: Text(""),
          centerTitle: true,
          elevation: 0.0,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: Container(
              width: MediaQuery.of(context).size.width - 36,
              margin: EdgeInsets.symmetric(horizontal: 18),
              child: Text(
                "Global",
                style: Theme.of(context).textTheme.headline,
                textAlign: TextAlign.left,
              ),
            ),
          )),
      body: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        child: Container(
          color: this.mainColor,
          height: double.infinity,
          child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  FutureBuilder<GlobalDataModel>(
                        future: fetchDataWorldTotal(),
                        builder: (BuildContext context,
                            AsyncSnapshot<GlobalDataModel> snapshot) {
                          if (snapshot.hasData) {
                            return Center(
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "\"Today\"",
                                      style: Theme.of(context).textTheme.body1,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 7.5,
                                  ),
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Card(
                                          shape: RoundedRectangleBorder(
                                            side: BorderSide(
                                                color: Colors.black
                                                    .withOpacity(0.2),
                                                width: 1),
                                            borderRadius:
                                                BorderRadius.circular(18),
                                          ),
                                          elevation: 0.0,
                                          color: mainColor,
                                          child: Container(
                                            height: 80,
                                            width: 80,
                                            margin: EdgeInsets.all(10.0),
                                            color: mainColor,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Text(
                                                  "+${snapshot.data.global.newConfirmed}",
                                                  textAlign: TextAlign.center,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .display4,
                                                ),
                                                Text(
                                                  "Confirmed",
                                                  textAlign: TextAlign.center,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .caption,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Card(
                                          shape: RoundedRectangleBorder(
                                            side: BorderSide(
                                                color: Colors.black
                                                    .withOpacity(0.2),
                                                width: 1),
                                            borderRadius:
                                                BorderRadius.circular(18),
                                          ),
                                          elevation: 0.0,
                                          color: mainColor,
                                          child: Container(
                                            height: 80,
                                            width: 80,
                                            margin: EdgeInsets.all(10.0),
                                            color: mainColor,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Text(
                                                  "+${snapshot.data.global.newRecovered}",
                                                  textAlign: TextAlign.center,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .display4,
                                                ),
                                                Text(
                                                  "Recovered",
                                                  textAlign: TextAlign.center,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .caption,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Card(
                                          shape: RoundedRectangleBorder(
                                            side: BorderSide(
                                                color: Colors.black
                                                    .withOpacity(0.2),
                                                width: 1),
                                            borderRadius:
                                                BorderRadius.circular(18),
                                          ),
                                          elevation: 0.0,
                                          color: mainColor,
                                          child: Container(
                                            height: 80,
                                            width: 80,
                                            margin: EdgeInsets.all(10.0),
                                            color: mainColor,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Text(
                                                  "+${snapshot.data.global.newDeaths}",
                                                  textAlign: TextAlign.center,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .display4,
                                                ),
                                                Text(
                                                  "Deaths",
                                                  textAlign: TextAlign.center,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .caption,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Divider(
                                    height: 10,
                                    color: Colors.black87,
                                    indent: 48,
                                    endIndent: 48,
                                  ),
                                  SizedBox(
                                    height: 7.5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "\"Total\"",
                                      style: Theme.of(context).textTheme.body1,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 7.5,
                                  ),
                                  Padding(
                                    padding:EdgeInsets.symmetric(horizontal: 30),
                                    child: Row( 
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          "Confirmed:",
                                          style:
                                              Theme.of(context).textTheme.body1,
                                        ),
                                        Text(
                                          snapshot.data.global.confirmed
                                              .toString(),
                                          style:
                                              Theme.of(context).textTheme.body2,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                 Padding(
                                      padding:EdgeInsets.symmetric(horizontal: 30),
                                      child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          "Recovered:",
                                          style:
                                              Theme.of(context).textTheme.body1,
                                        ),
                                        Text(
                                          snapshot.data.global.recovered
                                              .toString(),
                                          style:
                                              Theme.of(context).textTheme.body2,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Padding(
                                    padding:EdgeInsets.symmetric(horizontal: 30),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          "Deaths:",
                                          style:
                                              Theme.of(context).textTheme.body1,
                                        ),
                                        Text(
                                          snapshot.data.global.deaths.toString(),
                                          style:
                                              Theme.of(context).textTheme.body2,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Divider(
                                    height: 10,
                                    color: Colors.black87,
                                    indent: 48,
                                    endIndent: 48,
                                  ),
                                  SizedBox(
                                    height: 7.5,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      "\"Top countries\"",
                                      style: Theme.of(context).textTheme.body1,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 7.5,
                                  ),
                                  Padding(
                                    padding:EdgeInsets.symmetric(horizontal: 30),
                                    child: CoutriesCardsList(
                                        snapshot.data.listOfCountries, context),
                                  ),
                                ],
                              ),
                            );
                          } else if (snapshot.hasError) {
                            return Container(
                                color: this.mainColor,
                                child: Center(
                                    child: Column(children: <Widget>[
                                  Icon(
                                    Icons.error_outline,
                                    color: Colors.red,
                                    size: 60,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 16),
                                    child: Text('Error: ${snapshot.error}'),
                                  )
                                ])));
                          } else {
                           
                            return Center(
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Card(
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                              color:
                                                  Colors.black.withOpacity(0.2),
                                              width: 1),
                                          borderRadius:
                                              BorderRadius.circular(18),
                                        ),
                                        elevation: 0.0,
                                        color: mainColor,
                                        child: Container(
                                          height: 80,
                                          width: 80,
                                          margin: EdgeInsets.all(10.0),
                                          color: mainColor,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              CircularProgressIndicator(),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Card(
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                              color:
                                                  Colors.black.withOpacity(0.2),
                                              width: 1),
                                          borderRadius:
                                              BorderRadius.circular(18),
                                        ),
                                        elevation: 0.0,
                                        color: mainColor,
                                        child: Container(
                                          height: 80,
                                          width: 80,
                                          margin: EdgeInsets.all(10.0),
                                          color: mainColor,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              CircularProgressIndicator(),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Card(
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                              color:
                                                  Colors.black.withOpacity(0.2),
                                              width: 1),
                                          borderRadius:
                                              BorderRadius.circular(18),
                                        ),
                                        elevation: 0.0,
                                        color: mainColor,
                                        child: Container(
                                          height: 80,
                                          width: 80,
                                          margin: EdgeInsets.all(10.0),
                                          color: mainColor,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              CircularProgressIndicator(),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Divider(),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        "Confirmed:",
                                        style:
                                            Theme.of(context).textTheme.body1,
                                      ),
                                      placeholderContainer(),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        "Recovered:",
                                        style:
                                            Theme.of(context).textTheme.body1,
                                      ),
                                      placeholderContainer(),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        "Deaths:",
                                        style:
                                            Theme.of(context).textTheme.body1,
                                      ),
                                      placeholderContainer(),
                                    ],
                                  )
                                ],
                              ),
                            );
                          }
                        }),
                                    //ChartsComponent.withSampleData(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
