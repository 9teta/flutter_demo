

import 'dart:developer';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';

class CartModel {
  ISet<Bunch> items;

  CartModel.empty() : items = ISet();
  CartModel(this.items);

  CartModel copyWithAddProduct(int productId) {
    final filtered = items.where( (bunch) => bunch.productId == productId );
    // is in cart
    if (filtered.isNotEmpty) {
      log("is not empty");
      final Bunch matchedItem = filtered.first;
      final otherBunches = items.remove(matchedItem);
      final amount = matchedItem.productAmount;
      final updatedItem = matchedItem.copyWith(productAmount: amount + 1);
      log(updatedItem.productAmount.toString());
      ISet<Bunch> newItems = ISet({...otherBunches, updatedItem });
      return CartModel(newItems);
    // absent in cart
    } else {
      final newBunch = Bunch.a(productId: productId);
      ISet<Bunch> newItems = ISet({ ...items, newBunch });
      return CartModel(newItems);
    }
  }

  CartModel copyWithRemoveProductEntirely(int productId) {
    final filtered = items.where( (bunch) => bunch.productId == productId );
    // is in cart
    if (filtered.isNotEmpty) {
      final matchedItem = filtered.first;
      final otherBunches = items.remove(matchedItem);
      return CartModel(otherBunches);
    // absent in cart
    } else {
      return this;
      // just ignore
    }
  }

  CartModel copyWithRemoveProductByOne(int productId) {
    final filtered = items.where( (bunch) => bunch.productId == productId );
    // is in cart
    if (filtered.isNotEmpty) {
      final matchedItem = filtered.first;
      final otherBunches = items.remove(matchedItem);
      final newAmount = matchedItem.productAmount - 1;
      // amount of product is 0
      if (newAmount < 1) {
        ISet<Bunch> newItems = items.remove( Bunch.a(productId: productId) );
        return CartModel(newItems);
        // amount is at least 1
      } else {
        final updatedItem = matchedItem.copyWith(productAmount: newAmount);
        ISet<Bunch> newItems = ISet({ ...otherBunches, updatedItem });
        return CartModel(newItems);
      }
      // absent in cart
    } else {
      return this;
      // just ignore
    }
  }

}

class Bunch {
  final int productId;
  final int productAmount;

  Bunch({ required this.productId, required this.productAmount });
  // :/
  Bunch.a({ required int productId }) : this( productId: productId, productAmount: 1 );

  Bunch copyWith({ int? productId, int? productAmount }){
    return Bunch(
      productId: productId ?? this.productId,
      productAmount: productAmount ?? this.productAmount,
    );
  }

  // equals if product id is equal
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Bunch &&
              runtimeType == other.runtimeType &&
              productId == other.productId;

  @override
  int get hashCode => productId.hashCode;

}



