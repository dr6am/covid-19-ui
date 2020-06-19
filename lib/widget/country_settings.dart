import 'dart:io';

import 'package:covidtrackerapp/api/fetches.dart';
import 'package:covidtrackerapp/api/local_storage.dart';
import 'package:covidtrackerapp/models/country_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CountrySettings extends StatelessWidget {
  final CountryModel selectedCountry;
  final callback;
  const CountrySettings(this.selectedCountry, this.callback);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            'Сhange your country',
            style: Theme.of(context).textTheme.display2,
          ),
          Container(
            width: MediaQuery.of(context).size.width/3,
            child: Text(
              selectedCountry.country,
              textAlign: TextAlign.right,
              style: TextStyle(
                  color: Colors.white60,
                  fontSize: 20,
                  fontWeight: FontWeight.w400),
            ),
          ),
        ],
      ),
      onTap: () {
        _showModalCounties(selectedCountry, context,this.callback);
      },
    );
  }
}

void _showModalCounties(selectedCountry, BuildContext context,callback) {
  Future<void> future = showModalBottomSheet<void>(
      context: context,
      builder: (context) => Container(
          color: Colors.transparent,
          child: Container(
            height: 350,
            decoration: new BoxDecoration(
              color: Colors.white,
              borderRadius: new BorderRadius.all(Radius.circular(40.0)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
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
                ),
                Container(
                    margin: EdgeInsets.all(15),
                    child: Text(
                      "Choose your country:",
                      softWrap: true,
                      style: Theme.of(context).textTheme.body1,
                    )),
                Container(
                  width: MediaQuery.of(context).size.width - 75,
                  height: 250,
                  child: Center(
                    child: FutureBuilder<List<CountryModel>>(
                      future:
                          fetchCountryNames(), // a previously-obtained Future<String> or null
                      builder: (BuildContext context,
                          AsyncSnapshot<List<CountryModel>> snapshot) {
                        Widget child;
                        if (snapshot.hasData) {
                          var data = snapshot.data;
                          if (Platform.isAndroid) {
                            //TODO  Android-specific picker
                          } else if (Platform.isIOS) {
                            child = CupertinoPicker(
                              magnification: 1,
                              itemExtent: 30, //height of each item
                              looping: false,
                              backgroundColor: Colors.white,
                              onSelectedItemChanged: (int index) {
                                selectedCountry = data[index];
                              },

                              children: data
                                  .map((item) => Text(
                                        item.country,
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 20),
                                      ))
                                  .toList(),
                            );
                          }
                        } else if (snapshot.hasError) {
                          child = Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.error_outline,
                                  color: Colors.red,
                                  size: 60,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 16),
                                  child: Text('Error: ${snapshot.error}'),
                                )
                              ]);
                        } else {
                          child = SizedBox(
                            child: CircularProgressIndicator(),
                            width: 60,
                            height: 60,
                          );
                        }
                        return Center(child: child);
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          )));

  future.then((void value) {
    print(selectedCountry.toString());
    callback(selectedCountry);
    
    final snackBar = SnackBar(content: Text('Saved!'));
                   Scaffold.of(context).showSnackBar(snackBar);
  });
}
