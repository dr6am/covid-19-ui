
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ColorSelectTile extends StatefulWidget {
  const ColorSelectTile({
    Key key,
    @required this.colorsList,
    @required this.colorIndex,
    @required this.callback,
  }) : super(key: key);

  final List<Color> colorsList;
  final int colorIndex;
  final callback;

  @override
  _ColorSelectTileState createState() => _ColorSelectTileState(colorIndex,colorsList, callback);
}

class _ColorSelectTileState extends State<ColorSelectTile> {
  _ColorSelectTileState(this.colorIndex,this.colorsList,this.callback);
  final List<Color> colorsList;
  int colorIndex;
  final callback;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            'Сhange default color',
            style: Theme.of(context).textTheme.display2,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
              color: widget.colorsList[widget.colorIndex],
            ),
            height: 30,
            width: 30,
          )
        ],
      ),
      onTap: () {
        
                   void afterCloseColorPicker(int newColorIndex){
                     setState((){
                       print(colorIndex);
                       callback(newColorIndex);
                       colorIndex = newColorIndex;
                     });
                     final snackBar = SnackBar(content: Text('Saved!'));
                   Scaffold.of(context).showSnackBar(snackBar);
                   }
       showModalBottomSheet(
            context: context,
            builder: (_) => Container(
                color: Colors.transparent,
                child: Container(
                  height: 250,
                  decoration: new BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        new BorderRadius.all(Radius.circular(40.0)),
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
                              margin:
                                  EdgeInsets.only(top: 14, bottom: 4),
                              width: 75,
                              height: 5,
                              decoration: BoxDecoration(
                                  color:
                                      Color.fromRGBO(54, 54, 54, 1),
                                  borderRadius: new BorderRadius.all(
                                    Radius.circular(5.0),
                                  )),
                            ),
                          ),
                        ),
                      ),
                      //Spacer(),
                      Container(
                          margin: EdgeInsets.all(15),
                          child: Text(
                            "Choose new accent color:",
                            softWrap: true,
                            style: Theme.of(context).textTheme.body1,
                          )),
                ColorsGrid(widget.colorIndex,(int newIndex){
                  afterCloseColorPicker(newIndex);                  
                }
                ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ))).then((_){print("colors closed");});
      },
    );
  }
}


class ColorsGrid extends StatefulWidget {
  final onChoosedNewColor;
  final int colorIndex;
  ColorsGrid(this.colorIndex,this.onChoosedNewColor);
  @override
  _ColorsGridState createState() => _ColorsGridState(colorIndex,onChoosedNewColor);
}

class _ColorsGridState extends State<ColorsGrid> {

  final onChoosedNewColor;
  int checkedIdx;
  _ColorsGridState(this.checkedIdx,this.onChoosedNewColor);
  
    

  


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
  Widget build(BuildContext context) {
    return  Container(
                                  width: MediaQuery.of(context).size.width - 75,
                                  height: 150,
                                  child: Center(
                                    child: GridView.count(
                                      crossAxisCount: 4,
                                      shrinkWrap: true,
                                      childAspectRatio: 1,
                                      children: <Widget>[
                                        ...colorsList.map((item){return ColorElement(
                                          color: item,
                                          onTap:(){
                                            setState(() {
                                              Navigator.pop(context);
                                             
                                             

                                            });
                                           onChoosedNewColor(colorsList.indexOf(item));
                                          },
                                          checked: checkedIdx == colorsList.indexOf(item)? true:false,
                                        );},)
                                        
                                      ],
                                    ),
                                  ),
                                ) ;
  }
}

class ColorElement extends StatelessWidget {

  //TODO onTap animation 
  final Color color;
  final onTap;
  final bool checked;

  ColorElement({
    this.color,
    this.checked,
    this.onTap
  });
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 60,
        width: 60,
        child: InkWell(
          onTap: onTap,
          child:
          Container(
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(30),
              border: this.checked ? Border.all(width: 2,) : null
            ),
            child:  this.checked ? Icon(CupertinoIcons.check_mark, size: 50,) : null
            
          ),
        ),
      ),
    );
  }
}
