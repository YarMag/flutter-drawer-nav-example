import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_drawer_nav_demo/di/builders.dart';
import 'package:flutter_drawer_nav_demo/screens/app_container/app_container_screen.dart';
import 'package:flutter_drawer_nav_demo/screens/common/bloc_provider.dart';
import 'package:flutter_drawer_nav_demo/screens/first/bloc/first_bloc.dart';
import 'package:flutter_drawer_nav_demo/screens/first/bloc/first_bloc_interface.dart';
import 'package:flutter_drawer_nav_demo/screens/first/context/first_bloc_context.dart';
import 'package:flutter_drawer_nav_demo/screens/first/ui/first_screen.dart';
import 'package:flutter_drawer_nav_demo/screens/menu/bloc/menu_bloc.dart';
import 'package:flutter_drawer_nav_demo/screens/menu/bloc/menu_bloc_interface.dart';
import 'package:flutter_drawer_nav_demo/screens/menu/context/menu_bloc_context.dart';
import 'package:flutter_drawer_nav_demo/screens/menu/ui/menu_widget.dart';
import 'package:flutter_drawer_nav_demo/screens/second/bloc/second_bloc.dart';
import 'package:flutter_drawer_nav_demo/screens/second/bloc/second_bloc_interface.dart';
import 'package:flutter_drawer_nav_demo/screens/second/context/second_bloc_context.dart';
import 'package:flutter_drawer_nav_demo/screens/second/ui/second_screen.dart';
import 'package:flutter_drawer_nav_demo/screens/third/bloc/third_bloc.dart';
import 'package:flutter_drawer_nav_demo/screens/third/bloc/third_bloc_interface.dart';
import 'package:flutter_drawer_nav_demo/screens/third/context/third_bloc_context.dart';
import 'package:flutter_drawer_nav_demo/screens/third/ui/third_screen.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';

class Injection {
  static final Injector injector = Injector.getInjector();

  static Widget getCompositionRoot() {
    return injector.get<AppScreenBuilder>()();
  }

  static void initialize() {
    _registerBlocs();
    _registerScreenBuilders();
  }

  static void _registerBlocs() {
    injector.map<IMenuBloc>((i) => MenuBloc());

    injector.map<IFirstBloc>((i) => FirstBloc());
    injector.map<ISecondBloc>((i) => SecondBloc());
    injector.map<IThirdBloc>((i) => ThirdBloc());
  }

  static void _registerScreenBuilders() {
    injector.map<MenuBuilder>((i) => () {
          return BlocProvider(
            child: Menu(),
            blocContext: MenuBlocContext(
                firstScreenBuilder: i.get<FirstScreenBuilder>(),
                secondScreenBuilder: i.get<SecondScreenBuilder>(),
                thirdScreenBuilder: i.get<ThirdScreenBuilder>()),
            bloc: i.get<IMenuBloc>(),
          );
        });

    injector.map<FirstScreenBuilder>((i) => () {
          return BlocProvider(
            child: FirstScreen(),
            blocContext: FirstBlocContext(),
            bloc: i.get<IFirstBloc>(),
          );
        });

    injector.map<SecondScreenBuilder>((i) => () {
          return BlocProvider(
            child: SecondScreen(),
            blocContext: SecondBlocContext(),
            bloc: i.get<ISecondBloc>(),
          );
        });

    injector.map<ThirdScreenBuilder>((i) => () {
          return BlocProvider(
            child: ThirdScreen(),
            blocContext: ThirdBlocContext(),
            bloc: i.get<IThirdBloc>(),
          );
        });

    injector.map<AppScreenBuilder>((i) => () {
          BlocProvider<IMenuBloc> menu = i.get<MenuBuilder>()();
          AppContainerScreen screen = AppContainerScreen(
            menu: menu,
          );
          // IMPORTANT: magic for linking menu with screen's content stream
          MenuBlocContext context = menu.blocContext;
          context.setContentStream(screen.inContent);

          return screen;
        });
  }
}
