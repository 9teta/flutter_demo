import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop_demo/bloc/CartCubit.dart';
import 'package:flutter_shop_demo/bloc/NavigationBloc.dart';
import 'package:flutter_shop_demo/bloc/NavigationState.dart';
import 'package:flutter_shop_demo/components/BottomBar.dart';
import 'package:flutter_shop_demo/components/CartScreen.dart';
import 'package:flutter_shop_demo/components/TopBar.dart';
import 'package:flutter_shop_demo/model/ClosedModel.dart';
import 'package:flutter_shop_demo/repo/Repo.dart';
import 'dart:math' as math;

class FullScreen extends StatelessWidget {
  final Repo repo;
  FullScreen(this.repo);

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Container(
        color: Theme.of(context).colorScheme.background,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TopBar(),
            MainScreenWrapper(repo),
            BottomBar(),
          ],
        )

      ),
    );
  }
}

class MainScreenWrapper extends StatelessWidget {
  final Repo repo;
  MainScreenWrapper(this.repo);

  @override
  Widget build(BuildContext context) {
    return
    Container(
      child: BlocBuilder<NavigationBloc, NavigationState>(
        builder: (ctx, state) {
          log(state.toString());
          if (state is TabNavigationState) {
            if (state.segmentedIsSelected == null || state.segmentedIsSelected.isEmpty) {
              return Screen("Please, choose a category");
            } else {
              final category = state.segmentedIsSelected.first;
              if (repo.products.keys.contains(category)) {
                return Expanded(
                  child: HomeScreen(repo, category),
                );
              } else {
                return Screen("No products");
              }
            }
          } else if (state is CartNavigationState) {
            return CartScreenWrapper(repo);
          } else if (state is HomeNavigationState) {
            return Screen("Please, choose a category");
          }
          return Screen("No jet implemented");
        }


      )
    );
  }
}

class Screen extends StatelessWidget {
  final String text;

  Screen(this.text);

  @override
  Widget build(BuildContext context) {
    return
    Expanded(
      child: Center(
        child: Text(text)
      )
    );
  }
}

class HomeScreen extends StatelessWidget {
  final Repo repo;
  final String category;

  HomeScreen(this.repo, this.category);

  @override
  Widget build(BuildContext context) {
    return
    GridView.count(
      crossAxisCount: 3,
      children: List.generate(
        repo.products[category]!.length, (index) => ImageWidget(repo.products[category]!.elementAt(index)),
      ),

    );
  }
}

class ImageWidget extends StatelessWidget {
  final Product product;

  ImageWidget(this.product);

  @override
  Widget build(BuildContext context) {
    timeDilation = 5.0;
    return
    
    Material(
      child: InkWell(
        onTap: () => {
          showGeneralDialog(
            transitionDuration: Duration(milliseconds: 100),

              context: context,
              pageBuilder: (ctx, an, am) => Dialog.fullscreen(
                child: ProductDetailsWindow(product),
              ),
          )

        },
        child: Image(

          image: product.assetImage!,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class ProductDetailsWindow extends StatelessWidget {
  final Product product;

  ProductDetailsWindow(this.product);

  @override
  Widget build(BuildContext context) {
    return
    InkWell(
      onTap: () => Navigator.pop(context),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(product.name),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                      child: Center(
                          child: Text("Price: \$ " + product.price.toStringAsFixed(2))
                      )
                  ),
                  Expanded(
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        foregroundColor: Theme.of(context).colorScheme.onPrimary,

                      ),
                        onPressed: () {
                          context.read<CartCubit>().addToCart(product.id);
                        },
                        child: Text("To Cart"),
                    ),
                  )
                ],

              ),
              const SizedBox(height: 30),
              Image(

                image: product.assetImage!,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 30),
              Text(product.description.join(". ")),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

}