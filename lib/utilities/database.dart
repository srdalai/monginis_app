import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class CartDatabase {

  static final CartDatabase _cartDatabase = new CartDatabase._internal();
  factory CartDatabase() => _cartDatabase;
  static Database db;

  static CartDatabase get() {
    return _cartDatabase;
  }

  CartDatabase._internal();



  Future init() async {
    // Get a location using path_provider
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "wishlist.db");
    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
            // When creating the db, create the table
            await db.execute("CREATE TABLE Cart (id INTEGER PRIMARY KEY, name STRING, imageUrl STRING, price INTEGER)");
        });
  }

  /// Get a book by its id, if there is not entry for that ID, returns null.
  Future<CartProduct> getProduct(int id) async {
    var result = await db.rawQuery('SELECT FROM Cart WHERE id = "${id}""');
    if (result.length == 0) {
      return null;
    }
    return new CartProduct.fromMap(result[0]);
  }

}

class Category {
  String name, image;

  Category(this.name, this.image);
}

List<Category> categories = [
  Category("Cakes", "assets/category-images/cakes-1.jpg"),
  Category("Chocolates", "assets/category-images/chocolates.jpg"),
  Category("Cookies", "assets/category-images/cookies-1.jpg"),
  Category("Savouries", "assets/category-images/savouries.jpg"),
  Category("Drinks", "assets/category-images/drinks-4.jpg")
];

class CartProduct {
  int id;
  String name, image;
  int qty;
  double price;
  CartProduct({this.name, this.image, this.qty, this.price});

  CartProduct.map(dynamic obj) {
    this.name = obj['name'];
    this.image = obj['image'];
    this.qty = obj['qty'];
    this.price = obj['price'];
  }

  //getter methods
  String get prodName => name;
  String get prodImage => image;
  int get prodQty => qty;
  double get prodPrice => price;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["name"] = this.name;
    map["image"] = this.image;
    map["qty"] = this.qty;
    map["price"] = this.price;

    return map;
  }

  CartProduct.fromMap(Map<String, dynamic> map) : this(
    name : map['name'],
    image : map["image"],
    qty : map["qty"],
    price : map["price"]
  );

}

class ProductData {
  String name, flavor, desc, price, weight;
  String image;

  ProductData(this.name, this.flavor, this.desc, this.price, this.weight, this.image);

  //ProductData.fromMap(dynamic data) : this(name : data['name'], flavor : data['flavor'], desc : data['desc'], price : data['price'], weight : data['weight'], image : data['image']);
}

class ShopData {
  double lat, long;
  String name, address;
  int phone;

  ShopData(this.lat, this.long, this.name, this.phone);
}

List<ShopData> shops = [
  ShopData(20.2914954, 85.8429619, "Saheed Nagar", 7978586878),
  ShopData(20.263676, 85.845183, "Old Station Bazar", 7978586878),
  ShopData(20.3535665, 85.8071309, "KIIT Road", 7978586878)
];