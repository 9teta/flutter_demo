
import 'package:flutter/foundation.dart';

@immutable
sealed class NavigationState {}

final class HomeNavigationState extends NavigationState {}
final class CartNavigationState extends NavigationState {}
final class PreferencesNavigationState extends NavigationState {}
final class ContactsNavigationState extends NavigationState {}
final class ProfileNavigationState extends NavigationState {}

final class TabNavigationState extends NavigationState {
  late List<bool> updatedTabBarIsSelected;
  late Set<String> segmentedIsSelected;
  TabNavigationState(final int length, final int tabClicked) {
    updatedTabBarIsSelected = List.filled(length, false);
    if (tabClicked != -1) {
      updatedTabBarIsSelected[tabClicked] = true;
    }
  }

  TabNavigationState.segm(final int length, final String? tabClicked) {
    if (tabClicked == null) {
      segmentedIsSelected = <String>{};
    } else {
      segmentedIsSelected = <String>{tabClicked};
    }

  }
}
