import 'package:flutter/material.dart';
import 'package:transitord/pages/AplicarMultaPage.dart';
import 'package:transitord/pages/climaPage.dart';
import 'package:transitord/pages/conductorLicenciaPage.dart';
import 'package:transitord/pages/homePage.dart';
import 'package:transitord/pages/infoAppPage.dart';
import 'package:transitord/pages/loginPage.dart';
import 'package:transitord/pages/mapaMultasPage.dart';
import 'package:transitord/pages/multasRegistradasPages.dart';
import 'package:transitord/pages/noticiasDigesettPage.dart';
import 'package:transitord/pages/tarifarioMultasPages.dart';
import 'package:transitord/pages/vehiculoPlacaPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static const String home = Home.routeName;
  static const String tarifarioMultas = TarifarioMultas.routeName;
  static const String conductorLicencia = ConsultarConductorLicencia.routeName;
  static const String vehiculoPlaca = ConsultarVehiculoPlaca.routeName;
  static const String infoApp = InfoApp.routeName;
  static const String aplicarMulta = AplicarMulta.routeName;
  static const String multasRegistradas = MultasRegistradas.routeName;
  static const String mapaMultas = MapaMultas.routeName;
  static const String climasPage = ClimaScreen.routeName;
  static const String noticiasPage = NoticiasPage.routeName;
  static const String loginPage = LoginPage.routeName;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Transitord',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        home: (context) => Home(),
        tarifarioMultas: (context) => TarifarioMultas(),
        conductorLicencia: (context) => ConsultarConductorLicencia(),
        vehiculoPlaca: (context) => ConsultarVehiculoPlaca(),
        aplicarMulta: (context) => AplicarMulta(),
        multasRegistradas: (context) => MultasRegistradas(),
        mapaMultas: (context) => MapaMultas(),
        infoApp: (context) => InfoApp(),
        climasPage: (context) => ClimaScreen(),
        noticiasPage: (context) => NoticiasPage(),
        loginPage: (context) => LoginPage(),
      },
      home: Home(),
    );
  }
}
