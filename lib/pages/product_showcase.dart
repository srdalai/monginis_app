import 'package:flutter/material.dart';
import 'package:monginis_app/widgets/custom_widgets.dart';
import 'package:simple_coverflow/simple_coverflow.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:progress_hud/progress_hud.dart';

class ProductShowcase extends StatefulWidget {
  final String collection;
  final String catImage;

  ProductShowcase({this.collection, this.catImage});

  @override
  _ProductShowcaseState createState() => new _ProductShowcaseState();
}

class _ProductShowcaseState extends State<ProductShowcase> {
  String collection;

  List itemData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.collection == null) {
      collection = "cakes";
    } else {
      collection = widget.collection;
    }
  }

  @override
  Widget build(BuildContext context) {

    Widget dataQuery() {
      return new StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance.collection(collection).snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              try {
                itemData = snapshot.data.documents;
              } catch (e) {}

              if (!snapshot.hasData) {
                return ProgressHUD();
              }
              return CoverFlow(
                dismissibleItems: false,
                itemBuilder: (context, int index) {
                  var doc = itemData[index];
                  String name = doc['name'];
                  String image = doc['image'];
                  String weight = doc['weight'];
                  String flavor = doc['flavor'];
                  String price = doc['price'];
                  return ItemCard(
                    name: name,
                    image: image,
                    weight: weight,
                    flavor: flavor,
                    price: price,
                  );
                },
                itemCount: itemData.length,
              );
            });
    }
    
    return new Scaffold(
      appBar: NewAppBar(
        context: context,
        autoLeading: false,
        bgColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton.extended(
        elevation: 6.0,
        icon: const Icon(Icons.shopping_basket),
        label: const Text('View Cart'),
        onPressed: () {Navigator.pushNamed(context, "cart_page");},
      ),
      bottomNavigationBar: NewBottomBar(context: context,),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(widget.catImage),
            fit: BoxFit.cover
          )
        ),
        child: dataQuery()
      ),
    );
  }
}

class ItemCard extends StatefulWidget {
  final String image, name, weight, flavor, price, desc;

  ItemCard(
      {this.image, this.name, this.weight, this.flavor, this.price, this.desc});

  @override
  _ItemCardState createState() => new _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  final String rs = '\u{20B9}';
  bool isFav = true;

  @override
  void initState() {
    super.initState();
    isFav = true;
  }

  Widget _top() {
    return Expanded(
      child: Stack(
        alignment: Alignment.topLeft,
        children: <Widget>[
          CachedNetworkImage(
            imageUrl: widget.image,
            fit: BoxFit.cover,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(5.0),
            child: Container(
                padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 5.0),
                color: Colors.purple.withOpacity(0.6),
                child: Text(
                  "$rs${widget.price}",
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 26.0, color: Colors.white),
                )),
          )
        ],
      ),
    );
  }

  Widget _title() {
    return Row(
      children: <Widget>[
        Expanded(
          child: Text(
            widget.name,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 30.0),
          ),
        ),
        // IconButton(
        //   padding: EdgeInsets.symmetric(horizontal: 5.0),
        //   icon: Icon(
        //     Icons.favorite,
        //     color: isFav ? Colors.green : Colors.red,
        //   ),
        //   onPressed: () {
        //     setState(() {
        //       if (isFav) {
        //         isFav = false;
        //       } else {
        //         isFav = true;
        //       }
        //     });
        //   },
        // )
      ],
    );
  }

  Widget _showLable() {
    bool hasWeight = true, hasFlavour = true;

    if (widget.weight.trim().isEmpty) {
      hasWeight = false;
    }

    if (widget.flavor.trim().isEmpty) {
      hasFlavour = false;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          hasWeight
              ? Expanded(
                  child: Chip(
                    backgroundColor: Colors.blueAccent,
                    avatar: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Text("W",
                            style: TextStyle(color: Colors.blueAccent))),
                    label: Center(
                        child: Text(
                      "${widget.weight} gm",
                      style: TextStyle(color: Colors.white),
                    )),
                  ),
                )
              : Container(),
          SizedBox(
            width: 10.0,
          ),
          hasFlavour
              ? Expanded(
                  child: Chip(
                    backgroundColor: Colors.redAccent,
                    avatar: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Text("F",
                            style: TextStyle(color: Colors.redAccent))),
                    label: Center(
                        child: Text(
                      widget.flavor,
                      style: TextStyle(color: Colors.white),
                    )),
                  ),
                )
              : Container()
        ],
      ),
    );
  }

  Widget _showButton() {
    return Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
      // FlatButton(
      //   color: Colors.green,
      //   padding: EdgeInsets.symmetric(vertical: 7.5, horizontal: 5.0),
      //   child: Icon(
      //     Icons.favorite,
      //     size: 30.0,
      //     color: Colors.white,
      //   ),
      //   onPressed: () {},
      // ),
      Expanded(
          child: FlatButton(
              padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
              color: Colors.green,
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Icon(
                  Icons.add_box,
                  size: 34.0,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 10.0,
                ),
                Text(
                  "$rs${widget.price}",
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 26.0, color: Colors.white),
                )
              ]),
              onPressed: () {
                print(widget.flavor);
                print(widget.weight);
              })),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10.0,
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _top(),
            _title(),
            SizedBox(height: 20.0),
            _showLable(),
            SizedBox(height: 20.0),
            _showButton()
          ],
        ),
      ),
    );
  }
}
