import 'package:flutter/material.dart';
import 'package:transitord/widgets/DrawerMenu.dart';

class Home extends StatelessWidget {
  static const String routeName = '/home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      drawer: DrawerMenu(),
      body: Center(
        child: Text(
          'Home Page',
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
