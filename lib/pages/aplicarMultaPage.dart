import 'package:flutter/material.dart';
import 'package:transitord/widgets/DrawerMenu.dart';

class AplicarMulta extends StatelessWidget {
  static const String routeName = '/aplicarMulta';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("AplicarMulta"),
      ),
      drawer: DrawerMenu(),
      body: Center(
        child: Text(
          'AplicarMulta Page',
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
