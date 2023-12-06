import 'package:flutter/material.dart';
import 'package:transitord/pages/HoroscopoPage.dart';
import 'package:transitord/pages/clima.dart';
import 'pages/login.dart'; // Importa la página de inicio de sesión

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ClimaScreen(), // Para pruebas cambiar por
      //el widget que se este trabajando hasta que le menu este listo
    );
  }
}

//ClimaScreen
//HoroscopoPage
//LoginPage
