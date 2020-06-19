import 'package:covidtrackerapp/models/country_details.model.dart';
import 'package:flutter/material.dart';

Widget _ListItem(FullDataModel data, context) {
  return Card(
    shape: RoundedRectangleBorder(
      side: BorderSide(color: Colors.black.withOpacity(0.2), width: 1),
      borderRadius: BorderRadius.circular(12),
    ),
    elevation: 1.0,
    child: InkWell(
      onTap: () {
        showModalBottomSheet(
            context: context,
            builder: (_) => Container(
                color: Colors.transparent,
                child: Container(
                  height: 250,
                  decoration: new BoxDecoration(
                    color: Colors.white,
                    borderRadius: new BorderRadius.only(
                        topLeft:  Radius.circular(40.0),
                        topRight:  Radius.circular(40.0)),
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
                      Spacer(),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          CircleAvatar(
                            backgroundColor: Theme.of(context).accentColor,
                            child: Text(data.country.iso),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(data.country.country),
                        ],
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.0),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Chip(
                                    label: Text(data.confirmed),
                                  ),
                                  Text(
                                    "confirmed",
                                    style: Theme.of(context).textTheme.caption,
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Column(
                                children: <Widget>[
                                  Chip(
                                    label: Text(data.recovered),
                                  ),
                                  Text(
                                    "recovered",
                                    style: Theme.of(context).textTheme.caption,
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Column(
                                children: <Widget>[
                                  Chip(
                                    label: Text(data.deaths),
                                  ),
                                  Text(
                                    "deaths",
                                    style: Theme.of(context).textTheme.caption,
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 5,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
                )));
      },
      child: Container(
        color: Colors.lightGreen[300],
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width / 3 * 1.2,
                child: Text(
                  "${data.country.country}",
                  softWrap: true,
                ),
              ),
              Text("${data.confirmed}"),
            ],
          ),
        ),
      ),
    ),
  );
}

@override
Widget CoutriesCardsList(List<FullDataModel> data, BuildContext context) {
  return Container(
      child: SingleChildScrollView(
    child: Column(
      children: <Widget>[
        ...data.map((item) => _ListItem(item, context)),
      ],
    ),
  ));
}
