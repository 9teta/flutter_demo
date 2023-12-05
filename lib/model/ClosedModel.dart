
import 'package:flutter/cupertino.dart';

class Product {
  final int id;
  final String name;
  final double price;
  final List<String> description;
  String? group;
  AssetImage? assetImage;

  Product(this.id, this.name, this.price, this.description, {this.group, this.assetImage} );
}