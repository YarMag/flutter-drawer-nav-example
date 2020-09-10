import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class AppContainerScreen extends StatefulWidget {
  final Widget _menu;
  final BehaviorSubject<Widget> _contentStream = BehaviorSubject<Widget>();
  Sink<Widget> get inContent => _contentStream.sink;
  Stream<Widget> get _outContent => _contentStream.stream;

  AppContainerScreen({@required Widget menu}) : _menu = menu;

  @override
  State<StatefulWidget> createState() => _AppContainerScreenState();
}

class _AppContainerScreenState extends State<AppContainerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Drawer navigation app"),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: widget._menu,
      ),
      body: SafeArea(
        child: StreamBuilder(
          stream: widget._outContent,
          builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
            return snapshot.hasData ? snapshot.data : Container();
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();

    widget._contentStream.close();
  }
}
