import 'package:flutter/material.dart';
import 'package:monginis_app/widgets/custom_widgets.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => new _CartPageState();
}

class _CartPageState extends State<CartPage> {
  var rs = '\u{20B9}';

  List<CartProduct> prods;

  @override
  void initState() {
      // TODO: implement initState
      super.initState();
      prods = [
        CartProduct("Product 1", 2, 200.00),
        CartProduct("Product 2", 1, 300.00),
        CartProduct("Product 3", 4, 250.00),
        CartProduct("Product 4", 3, 142.00),
        CartProduct("Product 5", 2, 857.00),
        CartProduct("Product 6", 4, 245.00),
        CartProduct("Product 7", 2, 847.00),
        CartProduct("Product 8", 1, 125.00),
        CartProduct("Product 9", 2, 754.00),
      ];
    }

  @override
  Widget build(BuildContext context) {
    
    Widget cartItem(int i) {
      CartProduct prod = prods[i];
      return Dismissible(
        key: new Key(prods[i].name.toString()),
        background: Container(
          color: Colors.red,
          child: Padding(
            padding: const EdgeInsets.only(left: 30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(Icons.delete_forever, color: Colors.white, size: 40.0,),
                Text("Remove", style: new TextStyle(color: Colors.white),)
              ],
            ),
          ),
        ),
        secondaryBackground: Container(
          color: Colors.green,
          child: Padding(
            padding: const EdgeInsets.only(right: 30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Icon(Icons.archive, color: Colors.white, size: 40.0,),
                Text("Archive", style: new TextStyle(color: Colors.white),)
              ],
            ),
          ),
        ),
        onDismissed: (direction) {
          if(direction == DismissDirection.startToEnd) {
            prods.removeAt(i);
            setState(() {});
          }
          else {
            prods.removeAt(i);
            setState(() {});
          }
        },
        child: new Container(
          color: Colors.transparent,
          padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Card(
                margin: EdgeInsets.all(0.0),
                elevation: 8.0,
                  child: ClipRRect(
                  borderRadius: BorderRadius.circular(5.0),
                  child: new Image.asset(
                    "assets/products/1.jpg",
                    height: 100.0,
                  ),
                ),
              ),
              Flexible(
                  child: Padding(
                padding: EdgeInsets.fromLTRB(10.0, 0.0, 5.0, 0.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      prod.name,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                      style: const TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.w500),
                    ),
                    new SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      "QUANTITY: ${prod.qty}",
                      style: const TextStyle(
                          fontSize: 12.0, color: Colors.blueGrey),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        new Text(
                          "$rs${prod.price}",
                          style: const TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 30.0,),
                        // ClipRRect(
                        //   borderRadius: BorderRadius.circular(12.5),
                        //   child: new MaterialButton(
                        //     height: 25.0,
                        //     child: new Text(
                        //       "remove",
                        //       style: new TextStyle(color: Colors.white),
                        //     ),
                        //     color: Colors.redAccent,
                        //     onPressed: () {},
                        //   ),
                        // ),
                        //new SizedBox(width: 20.0,),
                        new RawMaterialButton(
                          constraints: const BoxConstraints(
                              maxHeight: 25.0, maxWidth: 25.0),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.5)),
                          fillColor: Colors.grey.shade300,
                          elevation: 0.0,
                          child: Icon(
                            Icons.remove,
                            color: Colors.black54,
                          ),
                          onPressed: () {removeQuantity(prod);},
                        ),
                        new SizedBox(
                            width: 40.0,
                            child: new Center(
                              child: new Text(prod.qty.toString()),
                            )),
                        new RawMaterialButton(
                          constraints: const BoxConstraints(
                              maxHeight: 25.0, maxWidth: 25.0),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.5)),
                          fillColor: Colors.grey.shade300,
                          elevation: 0.0,
                          child: Icon(
                            Icons.add,
                            color: Colors.black54,
                          ),
                          onPressed: () {addQuantity(prod);},
                        ),
                      ],
                    )
                  ],
                ),
              )),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: NewAppBar(
        context: context,
        autoLeading: false,
        bgColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      bottomNavigationBar: NewBottomBar(hasTrailing: false,),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton.extended(
        elevation: 6.0,
        icon: const Icon(Icons.playlist_add_check),
        label: const Text('Checkout'),
        onPressed: () {/*Navigator.pushNamed(context, "checkout_page");*/},
      ),
      body: new Container(
        child: new SingleChildScrollView(
          child: new Column(
            children: prods.map((k) => cartItem(prods.indexOf(k))).toList(),
          ),
        )
      ),
    );

    // return new ListView.builder(
    //   itemCount: prods.length,
    //   itemBuilder: (context, int index) {cartItem(index);},
    // );
  }

  removeQuantity(CartProduct produ) {
    if(produ.qty > 1) {
      setState(() {
          produ.qty--;
        });
    }
  }

  addQuantity(CartProduct produ) {
    setState(() {
          produ.qty++;
        });
  }
}

class CartProduct {
  int id;
  String name;
  int qty;
  double price;
  CartProduct(this.name, this.qty, this.price);
}
