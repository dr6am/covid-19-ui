import 'dart:convert';

import 'package:covidtrackerapp/api/fetches.dart';
import 'package:covidtrackerapp/models/country_details.model.dart';
import 'package:covidtrackerapp/widget/details_section.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CountyDetails extends StatelessWidget {
  static final String routeName = "detail";

  final Color mainColor = Color.fromRGBO(255, 195, 130, 1);

  @override
  Widget build(BuildContext context) {
    String country =
        jsonDecode(ModalRoute.of(context).settings.arguments)["name"];
    String slug =
        jsonDecode(ModalRoute.of(context).settings.arguments)["payload"];
    print(ModalRoute.of(context).settings.arguments);
    print(slug);
    return Hero(
      tag: "topBar",
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
                "In $country",
                style: Theme.of(context).textTheme.headline,
                textAlign: TextAlign.left,
              ),
            ),
          )),
      body: AnimatedContainer(
          duration: Duration(milliseconds: 500),
          child: FutureBuilder<CountryDetailsData>(
            future: getCountryDetailsData(slug),
            builder: (BuildContext context,
                AsyncSnapshot<CountryDetailsData> snapshot) {
              Widget children;
              if (snapshot.hasData) {
                children = Container(
                  color: this.mainColor,
                  child: Center(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          section(
                              title: "Today:",
                              infected: snapshot.data.today.confirmed,
                              recovered: snapshot.data.today.recovered,
                              dead: snapshot.data.today.deaths,
                              context: context),
                          Divider(
                            height: 10,
                            color: Colors.black87,
                            indent: 48,
                            endIndent: 48,
                          ),
                          section(
                              title: "Week ago:",
                              infected: snapshot.data.week.confirmed,
                              recovered: snapshot.data.week.recovered,
                              dead: snapshot.data.week.deaths,
                              context: context),
                          Divider(
                            height: 10,
                            color: Colors.black87,
                            indent: 48,
                            endIndent: 48,
                          ),
                          section(
                              title: "Month ago:",
                              infected: snapshot.data.month.confirmed,
                              recovered: snapshot.data.month.recovered,
                              dead: snapshot.data.month.deaths,
                              context: context),
                        ],
                      ),
                    ),
                  ),
                );
              } else if (snapshot.hasError) {
                children = Container(
                    height: double.infinity,
                    color: this.mainColor,
                    child: Center(
                        child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                          Spacer(),
                          Icon(
                            Icons.error_outline,
                            color: Colors.red,
                            size: 60,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: Text(
                              'Oops',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.headline,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: Text(
                              'Something went wrong, maybe in this country does not exist COVID-19',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.body1,
                            ),
                          ),
                          Spacer(),
                        ])));
              } else {
                children = Container(
                  color: this.mainColor,
                  child: Center(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          section(
                              title: "Today:",
                              infected: null,
                              recovered: null,
                              dead: null,
                              context: context),
                          Divider(
                            height: 10,
                            color: Colors.black87,
                            indent: 48,
                            endIndent: 48,
                          ),
                          section(
                              title: "This week:",
                              infected: null,
                              recovered: null,
                              dead: null,
                              context: context),
                          Divider(
                            height: 10,
                            color: Colors.black87,
                            indent: 48,
                            endIndent: 48,
                          ),
                          section(
                              title: "This month:",
                              infected: null,
                              recovered: null,
                              dead: null,
                              context: context),
                        ],
                      ),
                    ),
                  ),
                );
              }
              return children;
            },
          ),
        ),
      ),
    );
  }
}
