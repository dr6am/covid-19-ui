import 'package:covidtrackerapp/models/country_model.dart';
import 'package:flutter/material.dart';

class LocalStorage {
  List<dynamic> _listeners = [];

  static List<Color> colorsList = [
    Color.fromRGBO(255, 204, 153, 1),
    Color.fromRGBO(204, 204, 153, 1),
    Colors.indigo[300],
    Colors.grey[300],
    Color.fromRGBO(217, 168, 134, 1),
    Color.fromRGBO(254, 238, 218, 1),
    Colors.green[300],
    Colors.red[200]
  ];

  notifyListeners() {
    _listeners.forEach((item) {
      item();
    });
  }

  addListener(value) {
    _listeners.add(value);
  }

  static saveCountry(CountryModel country) {
    print("saved $country");
  }

  static CountryModel loadCountry() {
    return new CountryModel();
  }

  static saveColor(int colorIndex){
    print("savind: $colorIndex");
  }

  static loadColor() {
    return colorsList[0];
  }

}
