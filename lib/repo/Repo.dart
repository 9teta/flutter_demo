
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_shop_demo/bloc/CartCubit.dart';
import 'package:flutter_shop_demo/model/ClosedModel.dart';
import 'package:flutter_shop_demo/repo/RepoInitializer.dart';

import '../model/OpenModel.dart';

class Repo {

  final RepoInitializer repoInitializer = RepoInitializer();

  // mapNameOfGroupToProducts
  late final Map<String, Set<Product>> products;

  Repo() {
    products = repoInitializer.generateAll();
  }

  Product? getProduct(int id) {
    Product? foundProduct = null;
    outerLoop:
    for (final Set<Product> productGroup in products.values) {
      for (final element in productGroup) {
        if (element.id == id) {
          foundProduct = element;
          break outerLoop;
        }
      }
    }
    return foundProduct;
  }

  Product? getProductFromBunch(Bunch bunch) {
    return getProduct(bunch.productId);
  }

}