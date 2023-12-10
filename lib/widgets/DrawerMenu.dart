import 'package:flutter/material.dart';
import 'package:transitord/main.dart';

class DrawerMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color.fromRGBO(31, 184, 161, 1),
      child: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                _buildDrawerHeader(),
                _buildDrawerItem(
                    icon: Icons.home,
                    text: 'Inicio',
                    onTap: () =>
                        {Navigator.pushReplacementNamed(context, MyApp.home)}),
                const Divider(),
                _buildDrawerItem(
                    icon: Icons.payments_rounded,
                    text: 'Tarifario de Multas',
                    onTap: () => {
                          Navigator.pushReplacementNamed(
                              context, MyApp.tarifarioMultas)
                        }),
                _buildDrawerItem(
                    icon: Icons.car_crash_outlined,
                    text: 'Consultar Vehiculo',
                    onTap: () => {
                          Navigator.pushReplacementNamed(
                              context, MyApp.vehiculoPlaca)
                        }),
                _buildDrawerItem(
                    icon: Icons.sports_motorsports_rounded,
                    text: 'Consultar Conductor',
                    onTap: () => {
                          Navigator.pushReplacementNamed(
                              context, MyApp.conductorLicencia)
                        }),
                _buildDrawerItem(
                    icon: Icons.gavel_rounded,
                    text: 'Aplicar Multa',
                    onTap: () => {
                          Navigator.pushReplacementNamed(
                              context, MyApp.aplicarMulta)
                        }),
                _buildDrawerItem(
                    icon: Icons.receipt_long_outlined,
                    text: 'Multas Registradas',
                    onTap: () => {
                          Navigator.pushReplacementNamed(
                              context, MyApp.multasRegistradas)
                        }),
                _buildDrawerItem(
                    icon: Icons.person_pin_circle_rounded,
                    text: 'Mapa de Multas ',
                    onTap: () => {
                          Navigator.pushReplacementNamed(
                              context, MyApp.mapaMultas)
                        }),
                const Divider(),
                _buildDrawerItem(
                    icon: Icons.water_drop_sharp,
                    text: 'Clima',
                    onTap: () => {
                          Navigator.pushReplacementNamed(
                              context, MyApp.climasPage)
                        }),
                _buildDrawerItem(
                    icon: Icons.newspaper_rounded,
                    text: 'Noticias Digesett',
                    onTap: () => {
                          Navigator.pushReplacementNamed(
                              context, MyApp.noticiasPage)
                        }),
                _buildDrawerItem(
                    icon: Icons.login_rounded,
                    text: 'Salir',
                    onTap: () => {
                          Navigator.pushReplacementNamed(
                              context, MyApp.loginPage)
                        }),
              ],
            ),
          ),
          _buildInfoApp(context),
        ],
      ),
    );
  }

  Widget _buildDrawerHeader() {
    return const DrawerHeader(
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage('lib/assets/images/cover_menu.png'))),
        child: Stack(children: <Widget>[
          Positioned(
              bottom: 12.0,
              left: 16.0,
              child: Text("Compilación Movil",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500))),
        ]));
  }

  Widget _buildInfoApp(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Ink(
        decoration: BoxDecoration(
          color: Color.fromRGBO(248, 255, 254, 0.027),
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shadowColor: Colors.transparent, // Elimina las sombras
          ),
          onPressed: () {
            Navigator.pushReplacementNamed(context, MyApp.infoApp);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 0.0),
                child: Row(
                  children: [
                    Icon(Icons.info_outline_rounded,
                        size: 18.0, color: Color.fromARGB(221, 149, 45, 11)),
                    SizedBox(width: 8.0),
                    Text(
                      'App version 1.0.0',
                      style: TextStyle(
                          fontSize: 12.0,
                          color: Color.fromARGB(221, 49, 49, 49)),
                      selectionColor: Color.fromARGB(221, 11, 149, 103),
                    ),
                  ],
                ),
              ),
              Container(), // Puedes usar esto para agregar más elementos a la derecha
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildDrawerItem(
    {IconData? icon, required String text, required GestureTapCallback onTap}) {
  return ListTile(
    title: Row(
      children: <Widget>[
        Icon(icon),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(text),
        )
      ],
    ),
    onTap: onTap,
  );
}
