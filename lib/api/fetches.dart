import 'dart:convert';

import 'package:covidtrackerapp/models/country_details.model.dart';
import 'package:covidtrackerapp/models/country_model.dart';
import 'package:http/http.dart' as http;

Future<DataModel> fetchDataCountry({from, to, String country}) async {
  final response = await http.get(
      'https://api.covid19api.com/total/country/$country?from=$from&to=$to');
  if (response.statusCode == 200) {
    return DataModel.fromJson(jsonDecode(response.body.toString())[
        jsonDecode(response.body.toString()).length - 1]);
  } else {
    throw Exception('Failed to load data');
  }
}

Future<List<DataModel>> fetchAllWorldData() async {
  final response = await http.get('https://api.covid19api.com/world');
  if (response.statusCode == 200) {
    var data = jsonDecode(response.body.toString());
    List<DataModel> resp = [];
    resp.add(DataModel(
        data["TotalConfirmed"], data["TotalRecovered"], data["TotalDeaths"]));
    return resp;
  } else {
    throw Exception('Failed to load data');
  }
}

Future<List<CountryModel>> fetchCountryNames() async {
  final response = await http.get('https://api.covid19api.com/countries');
  if (response.statusCode == 200) {
    var data = jsonDecode(response.body.toString());
    List<CountryModel> resp = [];
    await data.forEach((item) {
      resp.add(CountryModel.fromJson(item));
    });
    resp.sort((a, b) => a.country.compareTo(b.country));
    return resp;
  } else {
    throw Exception('Failed to load data');
  }
}

Future<GlobalDataModel> fetchDataWorldTotal() async {
  final response = await http.get('https://api.covid19api.com/summary');
  if (response.statusCode == 200) {
    Map<String, dynamic> data = await jsonDecode(response.body.toString());
    return GlobalDataModel(data);
  } else {
    throw Exception('Failed to load data');
  }
}

Future<CountryDetailsData> getCountryDetailsData(String country) async {
  var today = new DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day);
  var yesterday = new DateTime(today.year, today.month, today.day - 1);
  DataModel todayData;
  await fetchDataCountry(from: yesterday, to: today, country: country)
      .then((d) {
    todayData = d;
  });
  var weekAgo = new DateTime(today.year, today.month, today.day - 8);
  var weekAgoNextDay = new DateTime(today.year, today.month, today.day - 7);
  DataModel weekAgoData;
  await fetchDataCountry(from: weekAgo, to: weekAgoNextDay, country: country)
      .then((d) {
    weekAgoData = d;
  });
  var monthAgo = new DateTime(today.year, today.month - 1, today.day - 1);
  var monthAgoNextDay = new DateTime(today.year, today.month - 1, today.day);
  DataModel monthAgoData;
  await fetchDataCountry(from: monthAgo, to: monthAgoNextDay, country: country)
      .then((d) {
    monthAgoData = d;
  });

  return Future.value(CountryDetailsData(
      today: todayData, week: weekAgoData, month: monthAgoData));
}
