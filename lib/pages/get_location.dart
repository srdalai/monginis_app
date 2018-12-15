import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:geocoder/geocoder.dart';

class GetLocation extends StatefulWidget {
  @override
  _GetLocationState createState() => new _GetLocationState();
}

class _GetLocationState extends State<GetLocation> {
  Map<String, double> _startLocation;
  Map<String, double> _currentLocation;

  StreamSubscription<Map<String, double>> _locationSubscription;

  Location _location = new Location();
  String error;
  String apiKey = "AIzaSyDPg_A7QHdI6jKFsxnO7WuWaABy_SSZYrU";
  bool currentWidget = true;

  Image image1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initPlatformState();

    _locationSubscription =
        _location.onLocationChanged.listen((Map<String, double> result) {
      setState(() {
        _currentLocation = result;
      });
    });
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  initPlatformState() async {
    Map<String, double> location;

    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      location = await _location.getLocation;
      error = null;
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        error = 'Permission denied';
      } else if (e.code == 'PERMISSION_DENIED_NEVER_ASK') {
        error =
            'Permission denied - please ask the user to enable it from the app settings';
      }
      location = null;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    //if (!mounted) return;

    setState(() {
      _startLocation = location;
      getAddress();
    });
  }

  getAddress() async {
    final coordinates = new Coordinates(_currentLocation["latitude"], _currentLocation["longitude"]);
    var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    print("${first.featureName} : ${first.addressLine}");
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets;

    if (_currentLocation == null) {
      widgets = new List();
    } else {
      String lat = _currentLocation["latitude"].toString();
      String long = _currentLocation["longitude"].toString();
      widgets = [
        new Image.network(
            "https://maps.googleapis.com/maps/api/staticmap?center=$lat,$long&zoom=18&size=640x400&markers=color:red%7Clabel:C%7C$lat,$long&key=$apiKey")
      ];
    }

    widgets.add(new Center(
        child: new Text(_startLocation != null
            ? 'Start location: $_startLocation\n'
            : 'Error: $error\n')));

    widgets.add(new Center(
        child: new Text(_currentLocation != null
            ? 'Continuous location: $_currentLocation\n'
            : 'Error: $error\n')));

    return new Container(
      child: Column(
        children: widgets,
      ),
    );
  }
}
