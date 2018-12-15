import 'package:flutter/material.dart';
import 'package:monginis_app/pages/cart_page.dart';
import 'package:monginis_app/pages/profile_page.dart';
import 'package:monginis_app/pages/search_page.dart';
import 'package:monginis_app/pages/home_page.dart';
import 'package:flutter/services.dart';

void main() {
  //SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  //SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  //routes
  final routes = <String, WidgetBuilder> {
    "home_page" : (BuildContext context) => HomePage(),
    "cart_page" : (BuildContext context) => CartPage(),
    "profile_page" : (BuildContext context) => ProfilePage(),
    "search_page" : (BuildContext context) => SearchPage()
  };

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Monginis',
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        //primarySwatch: MaterialColor(primary, swatch)
        primaryColor: Colors.white,
      ),
      home: new HomePage(),
      routes: routes,
    );
  }
}