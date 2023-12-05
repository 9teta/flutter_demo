

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop_demo/model/OpenModel.dart';

class CartCubit extends Cubit<CartModel> {

  CartCubit() : super(CartModel.empty());

  void addToCart(int productId) {
    final newState = state.copyWithAddProduct(productId);
    emit(newState);
  }

  void removeFromCart(int productId) {
    final newState = state.copyWithRemoveProductEntirely(productId);
    emit(newState);
  }



}

