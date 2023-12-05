import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop_demo/bloc/NavigationBloc.dart';
import 'package:flutter_shop_demo/bloc/NavigationEvent.dart';
import 'package:flutter_shop_demo/bloc/NavigationState.dart';
import 'dart:developer';
import 'dart:math' as math;

class TopBar extends StatelessWidget {
  static final toggleButtons = <Widget>[
    MyTab("1"),
    MyTab("2"),
    MyTab("3"),
    MyTab("4"),
  ];

  static final newTabs = <Tab>[
    Tab(text: "11"),
    Tab(text: "12"),
    Tab(text: "13"),
    Tab(text: "14"),
  ];

  static final buttonSegms = <ButtonSegment<String>>[
    const ButtonSegment(value: "shirt", label: Text("Shirts")),
    const ButtonSegment(value: "hat", label: Text("Hats")),
    const ButtonSegment(value: "trouser", label: Text("Trousers")),
    const ButtonSegment(value: "shoe", label: Text("Shoes")),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationBloc, NavigationState>(
      // buildWhen: (prev, curr) => curr is TabNavigationState,
      builder: (ctx, state) => NewTabBar(state, buttonSegms),
    );
  }
}

class MyTabBar extends StatelessWidget {
  final NavigationState state;
  final List<Widget> toggleButtons;
  final double horizontalBorderWidth = 2;
  late final int horizontalBordersAmount;
  late final double horizontalBordersWidth;

  MyTabBar(this.state, this.toggleButtons) : super() {
    horizontalBordersAmount = toggleButtons.length + 1;
    horizontalBordersWidth = horizontalBordersAmount * horizontalBorderWidth;
  }

  @override
  Widget build(BuildContext ctx) {
    return LayoutBuilder(
      builder: (BuildContext ctx, BoxConstraints constraints) {
        return ToggleButtons(
          borderWidth: horizontalBorderWidth,
          fillColor: Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
              .withOpacity(1.0),
          isSelected: (state as TabNavigationState).updatedTabBarIsSelected,
          onPressed: (int i) {
            final bloc = ctx.read<NavigationBloc>();
            // bloc.add(TabNavigationEvent(toggleButtons.length, i));
          },
          constraints: BoxConstraints.expand(
            width: constraints.maxWidth / toggleButtons.length - horizontalBordersWidth,
            height: 80,
          ),
          children: toggleButtons,
        );
      },
    );
  }
}

class MyTab extends StatelessWidget {
  final String text;

  MyTab(this.text);

  @override
  Widget build(BuildContext context) {
    return Text("$text");
  }
}

class NewTabBar extends StatelessWidget {
  final NavigationState state;
  final List<ButtonSegment<String>> buttonSegms;

  NewTabBar(this.state, this.buttonSegms);

  @override
  Widget build(BuildContext ctx) {


    return SizedBox(
      width: double.infinity,
      child: SegmentedButton(
        style: const ButtonStyle(
          padding: MaterialStatePropertyAll(
            EdgeInsets.all(30)
          ),
          
          // backgroundColor: MaterialStateProperty.resolveWith<Color>(
          //     (states) => states.contains(MaterialState.selected) ? Colors.amber : Colors.amberAccent
          // ),
          shape: MaterialStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.zero
            )
          )
        ),
        emptySelectionAllowed: true,
        showSelectedIcon: false,
        segments: buttonSegms,
        selected: state is TabNavigationState ? (state as TabNavigationState).segmentedIsSelected : const <String>{},
        onSelectionChanged: (Set<String> newSelection) {
          // stupid!!! Return empty set if selection is same
          if (newSelection.isEmpty) return;
          final bloc = ctx.read<NavigationBloc>();
          bloc.add(TabNavigationEvent.segm(buttonSegms.length, newSelection.first));
        },

      ),
    );


  }
  
}




