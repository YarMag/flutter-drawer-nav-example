
import 'package:flutter_drawer_nav_demo/screens/common/base_bloc.dart';
import 'package:flutter_drawer_nav_demo/screens/menu/bloc/menu_bloc_interface.dart';
import 'package:rxdart/rxdart.dart';

class MenuBloc extends IMenuBloc {

  final BehaviorSubject<String> _userNameSubject = BehaviorSubject<String>.seeded("User");

  MenuBloc() {
  }

  @override
  void onFirstOptionTap() {
    inUiEvents.add(BlocEvent(type: MenuBlocEvents.goToFirstScreen));
  }

  @override
  void onSecondOptionTap() {
    inUiEvents.add(BlocEvent(type: MenuBlocEvents.goToSecondScreen));
  }

  void onThirdOptionTap() {
    inUiEvents.add(BlocEvent(type: MenuBlocEvents.goToThirdScreen));
  }

  @override
  void dispose() {
    // IMPORTANT: don't close streams here
    // menu widget is opened multiple times so dispose will be called too
  }

  Sink<String> get _inUserName => _userNameSubject.sink;
  @override
  Stream<String> get outUserName => _userNameSubject.stream;

}