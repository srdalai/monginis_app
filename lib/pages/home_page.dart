import 'package:flutter/material.dart';
import 'package:monginis_app/pages/product_showcase.dart';
import 'package:monginis_app/widgets/custom_widgets.dart';
import 'package:monginis_app/utilities/database.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new NewAppBar(
        bgColor: Theme.of(context).scaffoldBackgroundColor,
        context: context,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton.extended(
        elevation: 6.0,
        icon: const Icon(Icons.shopping_basket),
        label: const Text('View Cart'),
        onPressed: () {
          Navigator.pushNamed(context, "cart_page");
        },
      ),
      bottomNavigationBar: NewBottomBar(
        context: context,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 100.0,
            ),
            CatSlider(),
            StoreLocator(),
            NewMapWidget()
          ],
        ),
      ),
    );
  }
}

//Category slider Widget
class CatSlider extends StatefulWidget {
  @override
  _CatSliderState createState() => new _CatSliderState();
}

class _CatSliderState extends State<CatSlider> {
  
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 20.0, bottom: 10.0),
          child: Text(
            "Categories",
            style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic),
          ),
        ),
        Container(
            height: 160.0,
            child: new ListView(
              scrollDirection: Axis.horizontal,
              children: categories.map((i) => _buildTile(i)).toList(),
            )),
      ],
    );
  }

  Widget _buildTile(Category cat) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 24.0),
      child: GestureDetector(
        onTap: () {
          print(cat.name.toLowerCase());
          var route = new MaterialPageRoute(
              builder: (BuildContext context) => new ProductShowcase(
                    collection: cat.name.toLowerCase(),
                    catImage: cat.image,
                  ));
          Navigator.push(context, route);
        },
        child: Material(
          elevation: 12.0,
          borderRadius: BorderRadius.circular(12.0),
          child: Stack(
            children: <Widget>[
              Container(
                width: 300.0,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                          cat.image,
                        ),
                        fit: BoxFit.cover)),
              ),
              Container(
                width: 300.0,
                color: Colors.black.withOpacity(0.3),
              ),
              Container(
                  alignment: AlignmentDirectional.bottomStart,
                  padding: EdgeInsets.only(left: 15.0, bottom: 20.0),
                  child: Text(
                    cat.name,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 4.0),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

//Store Locator widget
class StoreLocator extends StatefulWidget {
  @override
  _StoreLocatorState createState() => new _StoreLocatorState();
}

class _StoreLocatorState extends State<StoreLocator> {
  
  double lat, long;

  @override
  void initState() {
    super.initState();
    setState(() {
      lat = 20.307214;
      long = 85.8548353;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Text(
            "Store Locator",
            style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 300.0,
          child: MapWidget(
            lat: lat,
            long: long,
            lable: 1,
          ),
        ),
        Column(
          children: shops.map((shop) => buildList(shop)).toList(),
        )
      ],
    );
  }

  Widget buildList(ShopData shop) {

    return GestureDetector(
      onTap: () {
        print("${shop.lat} , ${shop.long} - ${shop.name}");
        setState(() {
          lat = shop.lat;
          long = shop.long;
        });
      },
      child: Column(
        children: <Widget>[
          ListTile(
            leading: IconButton(
              icon: Icon(
                Icons.directions,
                color: Colors.blue[900],
              ),
              onPressed: () {
                _launchMap(shop.lat, shop.long);
              },
            ),
            title: Text(shop.name),
            trailing: IconButton(
              icon: Icon(Icons.call, color: Colors.blue[900]),
              onPressed: () {
                _call(shop.phone.toString());
              },
            ),
          ),
          Divider()
        ],
      ),
    );
  }

  _call(String phone) async {
    var url = 'tel:$phone';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchMap(double lat, double long) async {
    String url ='https://www.google.com/maps/dir/?api=1&destination=${lat},${long}&travelmode=driving';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

class NewMapWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container();
  }
}