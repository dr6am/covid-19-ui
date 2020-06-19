import 'package:covidtrackerapp/models/country_model.dart';

class CountryDetailsData {
  DataModel today;
  DataModel week;
  DataModel month;

  CountryDetailsData({this.month, this.today, this.week});
}

class DataModel {
  final int _confirmed;
  final int _recovered;
  final int _deaths;
  String get confirmed {
    String finString = _confirmed.toString();
    if (_confirmed >= 10000) {
      var dotIndex = (_confirmed / 1000).toString().indexOf(".");
      finString =
          (_confirmed / 1000).toString().substring(0, dotIndex + 2) + "K";
    }
    return finString;
  }

  String get recovered {
    String finString = _recovered.toString();
    if (_recovered >= 10000) {
      var dotIndex = (_recovered / 1000).toString().indexOf(".");
      finString =
          (_recovered / 1000).toString().substring(0, dotIndex + 2) + "K";
    }
    return finString;
  }

  String get deaths {
    String finString = _deaths.toString();
    if (_deaths >= 10000) {
      var dotIndex = (_deaths / 1000).toString().indexOf(".");
      finString = (_deaths / 1000).toString().substring(0, dotIndex + 2) + "K";
    }
    return finString;
  }

  DataModel(this._confirmed, this._recovered, this._deaths);
  DataModel.fromJson(Map<String, dynamic> raw)
      : this._confirmed = int.parse(raw['Confirmed'].toString()),
        this._recovered = int.parse(raw['Recovered'].toString()),
        this._deaths = int.parse(raw['Deaths'].toString());
}

class FullDataModel {
  int _confirmed;
  String get confirmed {
    return _confirmed
        .toString()
        .split('')
        .reversed
        .join()
        .replaceAllMapped(RegExp(r".{3}"), (match) => "${match.group(0)} ")
        .split('')
        .reversed
        .join()
        .trim();
  }

  int _newConfirmed;
  String get newConfirmed {
    return _newConfirmed
        .toString()
        .split('')
        .reversed
        .join()
        .replaceAllMapped(RegExp(r".{3}"), (match) => "${match.group(0)} ")
        .split('')
        .reversed
        .join()
        .trim();
  }

  int _recovered;
  String get recovered {
    return _recovered
        .toString()
        .split('')
        .reversed
        .join()
        .replaceAllMapped(RegExp(r".{3}"), (match) => "${match.group(0)} ")
        .split('')
        .reversed
        .join()
        .trim();
  }

  int _newRecovered;
  String get newRecovered {
    return _newRecovered
        .toString()
        .split('')
        .reversed
        .join()
        .replaceAllMapped(RegExp(r".{3}"), (match) => "${match.group(0)} ")
        .split('')
        .reversed
        .join()
        .trim();
  }

  int _deaths;
  String get deaths {
    return _deaths
        .toString()
        .split('')
        .reversed
        .join()
        .replaceAllMapped(RegExp(r".{3}"), (match) => "${match.group(0)} ")
        .split('')
        .reversed
        .join()
        .trim();
  }

  int _newDeaths;
  String get newDeaths {
    return _newDeaths
        .toString()
        .split('')
        .reversed
        .join()
        .replaceAllMapped(RegExp(r".{3}"), (match) => "${match.group(0)} ")
        .split('')
        .reversed
        .join()
        .trim();
  }

  CountryModel country;

  FullDataModel(Map<String, dynamic> raw, bool isCountry) {
    this._confirmed = int.parse(raw['TotalConfirmed'].toString());
    this._recovered = int.parse(raw['TotalRecovered'].toString());
    this._deaths = int.parse(raw['TotalDeaths'].toString());
    this._newConfirmed = int.parse(raw['NewConfirmed'].toString());
    this._newRecovered = int.parse(raw['NewRecovered'].toString());
    this._newDeaths = int.parse(raw['NewDeaths'].toString());
    if (isCountry) {
      this.country = new CountryModel(
          country: raw['Country'], slug: raw["Slug"], iso: raw["CountryCode"]);
    }
  }
}

class GlobalDataModel {
  FullDataModel global;
  List<FullDataModel> listOfCountries;

  static List<FullDataModel> _makeList(List<dynamic> data) {
    List<FullDataModel> a = [];
    data.forEach((item) {
      a.add(new FullDataModel(item, true));
    });
    a.sort((x, b) => b._confirmed.compareTo(x._confirmed));
    a = a.sublist(0, 10);
    print(a.length);
    return a;
  }

  GlobalDataModel(Map<String, dynamic> raw)
      : this.global = new FullDataModel(raw["Global"], false),
        this.listOfCountries = _makeList(raw["Countries"]);
}
