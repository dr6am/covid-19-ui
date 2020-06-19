import 'dart:async';
import 'dart:convert';

import 'package:covidtrackerapp/api/fetches.dart';
import 'package:covidtrackerapp/models/country_model.dart';
import 'package:covidtrackerapp/screens/contry-details-page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class CountrySearchScreen extends StatefulWidget {
  static String routeName = "/countries-search";

  @override
  _CountrySearchScreenState createState() => _CountrySearchScreenState();
}

class _CountrySearchScreenState extends State<CountrySearchScreen>
    with TickerProviderStateMixin {
  Animation<double> resizeAnimation;
  AnimationController resizeController;

  final _formKey = GlobalKey<FormState>();
  String _query = "";
  bool isFirstRender = true;
  @override
  void initState() {
    resizeController = AnimationController(
        duration: const Duration(milliseconds: 150), vsync: this);
    super.initState();
    resizeAnimation = Tween<double>(begin: 0.0, end: 150.0).animate(
        new CurvedAnimation(parent: resizeController, curve: Curves.easeInOut));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Theme.of(context).primaryColor,
      floatingActionButton: FloatingActionButton(
        child: Icon(CupertinoIcons.back),
        onPressed: () {
          resizeController.reverse(from: resizeController.value).then((_) {
            Navigator.of(context).pop();
          });
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SafeArea(
        bottom: false,
        child: Container(
          color: Theme.of(context).primaryColorDark,
          child: Hero(
            tag: "county-search",
            child: Stack(
              children: <Widget>[
                FutureBuilder<List<CountryModel>>(
                    future: fetchCountryNames(),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<CountryModel>> snapshot) {
                      Widget child;
                      if (snapshot.hasData) {
                        Timer(Duration(milliseconds: 100),
                            resizeController.forward);
                        child = Container(
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          child: SingleChildScrollView(
                            child: Column(children: [
                              SizedBox(
                                height: 160,
                              ),
                              ...snapshot.data
                                  .where((item) => item.country
                                      .toLowerCase()
                                      .contains(this._query.toLowerCase()))
                                  .map(
                                    (data) => ListCard(
                                        data, snapshot.data.indexOf(data),
                                        (payload) {
                                      resizeController.reverse();

                                      Navigator.of(context)
                                          .pushReplacementNamed(
                                              CountyDetails.routeName,
                                              arguments: payload);
                                    }),
                                  )
                                  .toList(),
                            ]),
                          ),
                        );
                      } else if (snapshot.hasError) {
                        child = Center(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                              Icon(
                                Icons.error_outline,
                                color: Colors.red,
                                size: 60,
                              ),
                              Text("${snapshot.error}")
                            ]));
                      } else {
                        child = SizedBox(
                          child: CircularProgressIndicator(),
                          width: 60,
                          height: 60,
                        );
                      }
                      return Center(
                        child: child,
                      );
                    }),
                AnimatedBuilder(
                  animation: resizeAnimation,
                  builder: (ctx, child) {
                    return Padding(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).size.height -
                                MediaQuery.of(context).padding.top -
                                resizeAnimation.value -
                                10), //
                        child: child);
                  },
                  child: Form(
                    key: _formKey,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20)),
                      ),
                      height: 150,
                      width: double.infinity,
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Spacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Container(
                                  width:
                                      (MediaQuery.of(context).size.width - 16) /
                                          3 *
                                          2,
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      fillColor:
                                          Theme.of(context).primaryColorDark,
                                      hoverColor:
                                          Theme.of(context).primaryColorDark,
                                      focusColor:
                                          Theme.of(context).primaryColorDark,
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Theme.of(context)
                                                  .primaryColorDark)),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                    ),
                                    style: TextStyle(
                                        fontStyle: FontStyle.normal,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w400,
                                        color:
                                            Theme.of(context).primaryColorDark),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please enter some text';
                                      }
                                      return null;
                                    },
                                    onChanged: (val) {
                                      setState(() {
                                        _query = val;
                                      });
                                    },
                                    onSaved: (String val) {
                                      setState(() {
                                        _query = val;
                                      });
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: 20.0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 16.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColorDark,
                                      borderRadius: BorderRadius.circular(
                                          MediaQuery.of(context).size.height /
                                              100 *
                                              3.5),
                                    ),
                                    height: MediaQuery.of(context).size.height /
                                        100 *
                                        7,
                                    width: MediaQuery.of(context).size.height /
                                        100 *
                                        7,
                                    child: FlatButton(
                                      highlightColor: Colors.transparent,
                                      splashColor: Colors.transparent,
                                      color: Theme.of(context).primaryColor,
                                      onPressed: () {
                                        if (_formKey.currentState.validate()) {
                                          _formKey.currentState.save();
                                        }
                                      },
                                      child: Icon(
                                        Icons.search,
                                        color:
                                            Theme.of(context).primaryColorDark,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


class ListCard extends StatelessWidget {

  final String isoCode;
  final String name;
  final String payload;
  final int idx;
  final onTapAnimation;
  ListCard(
    CountryModel model,
    this.idx,
    this.onTapAnimation,
  )   : this.isoCode = model.iso,
        this.name = model.country,
        this.payload = model.slug;
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.black.withOpacity(0.2), width: 1),
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 1.0,
      child: InkWell(
        onTap: () {
          onTapAnimation(
              jsonEncode({"payload": this.payload, "name": this.name}));
        },
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColorDark,
          ),
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                CircleAvatar(
                  backgroundColor: Theme.of(context).accentColor,
                  child: Text('$isoCode'),
                ),
                SizedBox(
                  width: 15,
                ),
                Container(
                  width: (MediaQuery.of(context).size.width - 16) / 3 * 2,
                  child: Text(
                    "$name",
                    softWrap: true,
                    style: Theme.of(context).textTheme.display2,
                    textAlign: TextAlign.left,
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
