
import 'package:flutter_drawer_nav_demo/screens/app_container/app_container_screen.dart';
import 'package:flutter_drawer_nav_demo/screens/common/bloc_provider.dart';
import 'package:flutter_drawer_nav_demo/screens/first/bloc/first_bloc_interface.dart';
import 'package:flutter_drawer_nav_demo/screens/menu/bloc/menu_bloc_interface.dart';
import 'package:flutter_drawer_nav_demo/screens/second/bloc/second_bloc_interface.dart';
import 'package:flutter_drawer_nav_demo/screens/third/bloc/third_bloc_interface.dart';

typedef BlocProvider<IMenuBloc> MenuBuilder();
typedef AppContainerScreen AppScreenBuilder();
typedef BlocProvider<IFirstBloc> FirstScreenBuilder();
typedef BlocProvider<ISecondBloc> SecondScreenBuilder();
typedef BlocProvider<IThirdBloc> ThirdScreenBuilder();