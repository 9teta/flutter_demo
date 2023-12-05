
import 'package:bloc/bloc.dart';

class CartObserver extends BlocObserver {
  const CartObserver();

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    // simple print
  }

}