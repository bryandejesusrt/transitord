import 'package:flutter/material.dart';
import 'pages/login.dart'; // Importa la página de inicio de sesión

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(), // Usa LoginPage como la página de inicio
    );
  }
}
