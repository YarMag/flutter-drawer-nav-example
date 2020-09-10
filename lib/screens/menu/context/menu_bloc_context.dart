import 'package:flutter/material.dart';
import 'package:flutter_drawer_nav_demo/di/builders.dart';
import 'package:flutter_drawer_nav_demo/screens/common/base_bloc_context.dart';
import 'package:flutter_drawer_nav_demo/screens/menu/bloc/menu_bloc_interface.dart';

class MenuBlocContext extends BlocContextBase<IMenuBloc> {
  Sink<Widget> _inContent;

  final FirstScreenBuilder _firstScreenBuilder;
  final SecondScreenBuilder _secondScreenBuilder;
  final ThirdScreenBuilder _thirdScreenBuilder;

  bool _isInit = false;
  BuildContext _currentContext;

  MenuBlocContext(
      {@required FirstScreenBuilder firstScreenBuilder,
      @required SecondScreenBuilder secondScreenBuilder,
      @required ThirdScreenBuilder thirdScreenBuilder})
      : _firstScreenBuilder = firstScreenBuilder,
        _secondScreenBuilder = secondScreenBuilder,
        _thirdScreenBuilder = thirdScreenBuilder;

  void setContentStream(Sink<Widget> contentStream) {
    _inContent = contentStream;
    // push initial content
    // will be more elegant if make bloc's inUiEvent BehaviorSubject and manipulate with it
    _inContent.add(_firstScreenBuilder());
  }

  @override
  void subscribe(IMenuBloc bloc, BuildContext context) {
    // IMPORTANT: must subscribe each time subscribe is called on menu
    // each call will have new BuildContext which should be used with navigator/alerts/etc.
    _currentContext = context;
    if (!_isInit) {
      _isInit = true;

      bloc.outUiEvents.listen((event) {
        switch (event.type) {
          case MenuBlocEvents.goToFirstScreen:
            Navigator.of(_currentContext).pop();
            _inContent.add(_firstScreenBuilder());
            break;
          case MenuBlocEvents.goToSecondScreen:
            Navigator.of(_currentContext).pop();
            _inContent.add(_secondScreenBuilder());
            break;
          case MenuBlocEvents.goToThirdScreen:
            Navigator.of(_currentContext).pop();
            _inContent.add(_thirdScreenBuilder());
            break;
          default:
            break;
        }
      });
    }
  }
}
