import 'package:flutter/material.dart';

Widget placeholderContainer() {
  return Padding(
    padding: const EdgeInsets.only(top: 0.0, left: 0.0),
    child: Container(
        decoration: BoxDecoration(
          color: Colors.black12,
        ),
        width: 100,
        height: 30,
      ),
  );
}

Widget section(
    {String title,
    String dead,
    String infected,
    String recovered,
    BuildContext context}) {
  double columnSize = (MediaQuery.of(context).size.width - 40) / 3;
  print(columnSize);
  return Container(
    width: MediaQuery.of(context).size.width - 28,
    child: Padding(
      padding:
          const EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0, bottom: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 10, bottom: 24.0),
            child: Text(
              title,
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.subhead,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 10,
                      width: 10,
                      decoration: BoxDecoration(
                        color: Colors.black38,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    infected == null
                        ? placeholderContainer()
                        : Container(
                            width: columnSize,
                            height: 33,
                            child: Text(infected, textAlign: TextAlign.center),
                          ),
                    SizedBox(
                      height: 5,
                    ),
                    Text("Confirmed",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.caption),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 10,
                      width: 10,
                      decoration: BoxDecoration(
                        color: Colors.black38,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    recovered == null
                        ? placeholderContainer()
                        : Container(
                            width: columnSize,
                            height: 33,
                            child: Text(recovered,
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.body1),
                          ),
                    SizedBox(
                      height: 5,
                    ),
                    Text("Recovered",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.caption),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 10,
                      width: 10,
                      decoration: BoxDecoration(
                        color: Colors.black38,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    dead == null
                        ? placeholderContainer()
                        : Container(
                            height: 33,
                            width: columnSize,
                            child: Text(dead,
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.body1),
                          ),
                    SizedBox(
                      height: 5,
                    ),
                    Text("Deaths",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.caption),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
