import 'package:flutter/material.dart';
import 'dart:async';

import 'package:monginis_app/pages/get_location.dart';

class NewBottomBar extends BottomAppBar implements StatefulWidget {

  NewBottomBar({bool hasTrailing = true, bool hasLeading = true, BuildContext context}) : super(
    hasNotch: false,
    color: Colors.white,
    elevation: 8.0,
    child: new Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        hasLeading ?  IconButton(icon: Icon(Icons.menu), onPressed: () {},) : Container(height: 0.0, width: 0.0,),
        hasTrailing ? IconButton(icon: Icon(Icons.search), onPressed: (){Navigator.pushNamed(context, "search_page");},) : Container(height: 0.0, width: 0.0,),
      ],
    ),
  );
}

class NewAppBar extends AppBar implements StatefulWidget {

  NewAppBar({Key key, Widget title, BuildContext context, Color bgColor, bool autoLeading = true, bool cntrTtl = false, bool showSearch = true, bool notif = true}) : super(
    key: key,
    //title: title,
    elevation: 0.0,
    backgroundColor: bgColor,
    centerTitle: cntrTtl,
    automaticallyImplyLeading: autoLeading,
    title: new InkWell(
      onTap: (){askUser(context, bgColor);},
      onDoubleTap: (){_showAlert(context);},
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Text("Location not set"),
          new Icon(Icons.location_on)
        ],
      ),
    ),
    leading: autoLeading ? Padding(
      padding: const EdgeInsets.only(top: 10.0, left: 20.0),
      child: new Image.asset("assets/icon.png", fit: BoxFit.cover,),
    ) : new IconButton(icon: new Icon(Icons.arrow_back_ios), onPressed: (){Navigator.pop(context);},),
    actions: <Widget>[
      new Container(
        padding: const EdgeInsets.only(top: 7.5, bottom: 7.5, right: 10.0, left: 10.0),
        child: new InkWell(
          onTap: (){Navigator.pushNamed(context, "profile_page");},
          child: new Hero(
            tag: "user",
            child: new Stack(
              alignment: AlignmentDirectional.bottomEnd,
              children: <Widget>[
                new CircleAvatar(
                  backgroundImage: new AssetImage("assets/account_pictures/user_1.jpg"),
                  backgroundColor: Colors.white,
                ),
                notif ? new CircleAvatar(
                  child: new CircleAvatar(backgroundColor: Colors.red, radius: 6.0,),
                  radius: 8.0,
                  backgroundColor: Colors.white,
                ) : new Container()
              ],
            )
          ),
        ),
      )
    ]
  );


  static void _showAlert(BuildContext context) {

    SimpleDialog alertDialog = new SimpleDialog(
      title: new Text("Your Current Location is Set"),
      children: <Widget>[
        new FlatButton(
          onPressed: (){},
          child: new Text("OK"),
        ),
        new MaterialButton(
          onPressed: (){},
          child: new Text("Change"),
        )
      ],

    );

    showDialog(context: context, child: alertDialog);
  }

  static Future<Null> askUser(BuildContext context, Color color) async {
    switch (
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return new SimpleDialog(
            //contentPadding: const EdgeInsets.fromLTRB(0.0, 52.0, 0.0, 16.0),
            title: const Text("Current Location is set to:-", textAlign: TextAlign.center,),
            children: <Widget>[
              //new Icon(Icons.my_location, color: color, size: 50.0,),
              new Text("Mahadev Nagar, Jharpada, Bhubaneswar", textAlign: TextAlign.center, style: const TextStyle(fontSize: 20.0),),
              new ButtonBar(
                alignment: MainAxisAlignment.center,
                children: <Widget>[
                  new RaisedButton(
                    color: Colors.grey,
                    textColor: Colors.white,
                    onPressed: (){Navigator.pop(context, DialogActions.ok);},
                    child: new Text("Ok"),
                  ),
                  new Container(width: 50.0,),
                  new RaisedButton(
                    color: Colors.grey,
                    textColor: Colors.white,
                    onPressed: (){
                      var route = MaterialPageRoute(
                        builder: (BuildContext context) => GetLocation()
                      );
                      Navigator.pop(context, DialogActions.change);
                      Navigator.push(context, route);
                    },
                    child: new Text("Change"),
                  )
                ],
              ),
            ],
          );
        }
      )
    ) {
      case DialogActions.ok:
        
        break;
      case DialogActions.change:

        break;
      default:
    }
  }

}

class NewFAB extends FloatingActionButton implements StatefulWidget {

  NewFAB() : super(
    onPressed: (){},
    child: Stack(
      alignment: AlignmentDirectional.topEnd,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(Icons.shopping_basket),
        ),
        //Text("9+")
      ],
    ),
  );
}

class MapWidget extends StatelessWidget {
  final String apiKey = "AIzaSyDPg_A7QHdI6jKFsxnO7WuWaABy_SSZYrU";
  final double lat , long;
  final int lable;

  MapWidget({this.lat, this.long, this.lable});

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Image.network(
            "https://maps.googleapis.com/maps/api/staticmap?center=$lat,$long&zoom=19&size=640x400&markers=color:red%7Clabel:$lable%7C$lat,$long&key=$apiKey")
    );
  }
}

enum DialogActions {ok, change, locate }