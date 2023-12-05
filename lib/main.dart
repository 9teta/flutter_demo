import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop_demo/bloc/CartCubit.dart';
import 'package:flutter_shop_demo/bloc/NavigationBloc.dart';
import 'package:flutter_shop_demo/components/Screens.dart';
import 'package:flutter_shop_demo/repo/Repo.dart';

void main() {

  runApp(MultiBlocProvider(
      providers: [
    BlocProvider<NavigationBloc>(create: (ctx) => NavigationBloc()),
    BlocProvider<CartCubit>(create: (ctx) => CartCubit()),
  ],
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  final Repo repo = Repo();
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple,
            brightness: Brightness.dark
          )),
      home: FullScreen(repo),
    );
  }
}
