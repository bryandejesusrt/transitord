import 'package:flutter/material.dart';
import 'package:transitord/widgets/DrawerMenu.dart';

class MapaMultas extends StatelessWidget {
  static const String routeName = '/mapamultas';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mapa De Multas"),
      ),
      drawer: DrawerMenu(),
      body: Center(
        child: Text(
          'MAPA ULTAS Page',
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
