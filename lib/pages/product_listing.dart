import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:progress_hud/progress_hud.dart';

class ProductListing extends StatefulWidget {
  final String catname;

  ProductListing(this.catname);

  @override
  _ProductListingState createState() => new _ProductListingState();
}

class _ProductListingState extends State<ProductListing> {
  Color gradientStart =
      Colors.black.withOpacity(0.8); //Change start gradient color here
  Color gradientEnd =
      Colors.black.withOpacity(0.0); //Change end gradient color here

  Widget tile(DocumentSnapshot document) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Stack(
          alignment: AlignmentDirectional.bottomEnd,
          children: <Widget>[
            new Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: CachedNetworkImageProvider(document['image']))),
            ),
            new Container(
              decoration: new BoxDecoration(
                gradient: new LinearGradient(
                  colors: [gradientStart, gradientEnd],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  stops: [0.0, 1.0],
                ),
              ),
              //color: Colors.black.withOpacity(0.5),
              alignment: Alignment.bottomCenter,
              padding: EdgeInsets.only(bottom: 10.0),
              height: 80.0,
              child: new Text(
                document['name'],
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontStyle: FontStyle.italic),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String collection = widget.catname;
    return Scaffold(
      appBar: new AppBar(title: Text("Monginis"),elevation: 0.0, backgroundColor: Theme.of(context).scaffoldBackgroundColor,),
      body: new StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection(collection).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return ProgressHUD();
          }
          return OrientationBuilder(
            builder: (contex, orientation) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: new GridView.count(
                  crossAxisCount: orientation == Orientation.portrait ? 2 : 4,
                  children: snapshot.data.documents
                      .map((document) => tile(document))
                      .toList(),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
