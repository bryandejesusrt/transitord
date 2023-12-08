import 'package:flutter/material.dart';
import 'package:transitord/widgets/DrawerMenu.dart';

class ConsultarConductorLicencia extends StatelessWidget {
  static const String routeName = '/ConductorLicencia';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Consultar Conductor"),
      ),
      drawer: DrawerMenu(),
      body: Center(
        child: Text(
          'ConductorLicencia Page',
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
