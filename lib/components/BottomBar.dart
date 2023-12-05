
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop_demo/bloc/NavigationBloc.dart';
import 'package:flutter_shop_demo/bloc/NavigationEvent.dart';

class BottomBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return
    SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: IconBar(),
      ),
    );
  }

}

class IconBar extends StatelessWidget {

  IconBar();

  @override
  Widget build(BuildContext ctx) {
    final bloc = ctx.read<NavigationBloc>();

    return
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Expanded(
          child: IconButton(
            icon: const Icon(Icons.shopping_cart),
            tooltip: 'Cart',
            onPressed: () => bloc.add( CartNavigationEvent() ),
          ),
        ),
        Expanded(
          child: IconButton(
            icon: const Icon(Icons.settings),
            tooltip: 'Settings',
            onPressed: () => bloc.add( PreferencesNavigationEvent() ),
          ),
        ),
        Expanded(
          child: IconButton(
            icon: const Icon(Icons.home),
            tooltip: 'Home screen',
            onPressed: () => bloc.add( HomeNavigationEvent() ),
          ),
        ),
        Expanded(
          child: IconButton(
            icon: const Icon(Icons.phone),
            tooltip: 'Contacts',
            onPressed: () => bloc.add( ContactsNavigationEvent() ),
          ),
        ),
        Expanded(
          child: IconButton(
            icon: const Icon(Icons.account_box),
            tooltip: 'My Profile screen',
            onPressed: () => bloc.add( ProfileNavigationEvent() ),
          ),
        ),
      ],
    );
  }

}