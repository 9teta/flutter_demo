
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop_demo/bloc/NavigationEvent.dart';
import 'package:flutter_shop_demo/bloc/NavigationState.dart';

import '../components/TopBar.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(TabNavigationState.segm(TopBar.buttonSegms.length, null)) {

    on<HomeNavigationEvent>( (event, emit) => emit(HomeNavigationState()) );
    on<CartNavigationEvent>( (event, emit) => emit(CartNavigationState()) );
    on<PreferencesNavigationEvent>( (event, emit) => emit(PreferencesNavigationState()) );
    on<ContactsNavigationEvent>( (event, emit) => emit(ContactsNavigationState()) );
    on<ProfileNavigationEvent>( (event, emit) => emit(ProfileNavigationState()) );
    on<TabNavigationEvent>( (event, emit) => emit(TabNavigationState.segm(event.length, event.segmClicked)) );

  }
}