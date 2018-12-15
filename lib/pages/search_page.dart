import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => new _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final textController = new TextEditingController();

  @override
  void dispose() {
    super.dispose();
    textController.dispose();
  }

  Widget _searchBar() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
          color: Colors.grey[200],
          //border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 10.0),
              child: TextField(
                controller: textController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      //suffixIcon: IconButton(icon: Icon(Icons.close), onPressed: (){},),
                      hintText: "Search Products",
                      border: InputBorder.none)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: RawMaterialButton(
              padding: EdgeInsets.all(4.0),
              constraints:
                  const BoxConstraints(maxHeight: 30.0, maxWidth: 30.0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
              fillColor: Colors.grey[850],
              elevation: 2.0,
              child: Icon(
                Icons.close,
                color: Colors.white,
                size: 18.0,
              ),
              onPressed: () {textController.clear();},
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(elevation: 0.0, title: _searchBar()),
    );
  }
}
