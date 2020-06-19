import 'dart:convert';

class CountryModel {
  final String country;
  final String slug;
  final String iso;

  @override
  String toString (){
    return jsonEncode({
      "country":this.country,
    "slug":this.slug,
    "iso":this.iso,
    });
  }
  CountryModel({
    this.country,
    this.slug,
    this.iso,
  });
  CountryModel.fromJson(Map<String, dynamic> json)
      : assert(json["Country"] != null),
        assert(json["Slug"] != null),
        assert(json["ISO2"] != null),
        this.country = json["Country"],
        this.slug = json["Slug"],
        this.iso = json["ISO2"];
}
