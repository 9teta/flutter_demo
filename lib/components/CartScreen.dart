
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop_demo/bloc/CartCubit.dart';
import 'package:flutter_shop_demo/model/ClosedModel.dart';
import 'package:flutter_shop_demo/model/OpenModel.dart';
import 'package:flutter_shop_demo/repo/Repo.dart';

class CartScreenWrapper extends StatelessWidget {
  final Repo repo;
  CartScreenWrapper(this.repo);


  @override
  Widget build(BuildContext context) {
    return
    BlocBuilder<CartCubit, CartModel>(
      builder: (BuildContext context, CartModel state) {
        return Expanded(
            child: CartScreen(repo, state)
        );
      },
    );
  }

}

class CartScreen extends StatelessWidget {
  final Repo repo;
  final CartModel cart;


  CartScreen(this.repo, this.cart);

  @override
  Widget build(BuildContext context) {
    return
    ListView(
      children: cart.items
          .map((bunch) => CartScreenListTile(bunch, repo.getProductFromBunch(bunch)))
          .toList()
    );
  }
}

class CartScreenListTile extends StatelessWidget {
  final Bunch bunch;
  final Product? product;

  CartScreenListTile(this.bunch, this.product);
  @override
  Widget build(BuildContext context) {
    if (product == null) {
      return Card(
        child: ListTile(
            title: Text("Unknown product with id: ${bunch.productId}")
        ),
      );
    } else {
      return
      Dismissible(
        key: ValueKey<int>(product!.id),
        onDismissed: (direction) {
          context.read<CartCubit>().removeFromCart(product!.id);
        },
        child: Card(
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: product!.assetImage,
            ),
            title: Text("${product!.name}"),
            subtitle: Text("Amount: ${bunch.productAmount}"),
            trailing: Text("\$ ${product!.price.toStringAsFixed(2)}"),
          ),
        ),
      );
    }


  }
  
}