
import 'package:flutter_drawer_nav_demo/screens/common/base_bloc.dart';

enum MenuBlocEvents {
  goToFirstScreen,
  goToSecondScreen,
  goToThirdScreen
}

abstract class IMenuBloc extends BlocBase<MenuBlocEvents> {
  Stream<String> get outUserName;

  void onFirstOptionTap();
  void onSecondOptionTap();
  void onThirdOptionTap();
}