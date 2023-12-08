import 'package:flutter/material.dart';
import 'package:transitord/widgets/DrawerMenu.dart';

class ConsultarVehiculoPlaca extends StatelessWidget {
  static const String routeName = '/ConductorLicencia';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Consultar Vehiculo"),
      ),
      drawer: DrawerMenu(),
      body: Center(
        child: Text(
          'ConsultarVehiculoPlaca Page',
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
