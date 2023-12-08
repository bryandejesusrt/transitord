import 'package:flutter/material.dart';
import 'package:transitord/widgets/DrawerMenu.dart';

class TarifarioMultas extends StatelessWidget {
  static const String routeName = '/tarifario';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tarifario de Multas"),
      ),
      drawer: DrawerMenu(),
      body: Center(
        child: Text(
          'tarifario Page',
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
