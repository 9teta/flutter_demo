
import 'package:flutter/foundation.dart';

@immutable
sealed class NavigationEvent {}

final class HomeNavigationEvent extends NavigationEvent {}
final class CartNavigationEvent extends NavigationEvent {}
final class PreferencesNavigationEvent extends NavigationEvent {}
final class ContactsNavigationEvent extends NavigationEvent {}
final class ProfileNavigationEvent extends NavigationEvent {}

final class TabNavigationEvent extends NavigationEvent {
  final int length;
  // late final int tabClicked;
  late final String segmClicked;
  // TabNavigationEvent(this.length, this.tabClicked);

  TabNavigationEvent.segm(this.length, this.segmClicked);
}
