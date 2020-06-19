import 'dart:convert';
import 'dart:io';

import 'package:covidtrackerapp/api/fetches.dart';
import 'package:covidtrackerapp/api/local_storage.dart';
import 'package:covidtrackerapp/models/country_model.dart';
import 'package:covidtrackerapp/widget/color-selection.dart';
import 'package:covidtrackerapp/widget/country_settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';




class SettingsScreen extends StatefulWidget {
  static String routeName = "settings";

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  
  CountryModel selectedCountry =  new CountryModel.fromJson(jsonDecode("{\"Country\":\"United States of America\",\"Slug\":\"united-states\",\"ISO2\":\"US\"}"));  

  int colorIndex = 0;
  List<Color> colorsList = [
    Color.fromRGBO(255, 204, 153, 1),
    Color.fromRGBO(204, 204, 153, 1),
    Colors.indigo[300],
    Colors.grey[300],                         
    Color.fromRGBO(217, 168, 134, 1),
    Color.fromRGBO(254, 238, 218, 1), 
    Colors.green[300],      
    Colors.red[200]                   
  ];
  
  
  @override
  void initState() {
    super.initState();    
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0), // here the desired height
        child: AppBar(
          title: Text("Settings"),
        ),
      ),
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height,
          color: Theme.of(context).primaryColorDark,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 30,
              ),
              ColorSelectTile(colorsList: colorsList, colorIndex: colorIndex,callback:(int newColorIndex){
                  setState(
                      (){
                          LocalStorage.saveColor(newColorIndex);
                          colorIndex = newColorIndex;
                        }
                    );
                }),
              Divider(),
              CountrySettings(selectedCountry,(CountryModel newCountry){
                    setState(
                      (){
                          LocalStorage.saveCountry(newCountry);
                          selectedCountry = newCountry;
                        }
                    );
              }),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }
}





