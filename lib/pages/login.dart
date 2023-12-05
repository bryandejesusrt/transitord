import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool showError = false;

  void login() {
    // Aquí puedes implementar tu lógica de autenticación
    // Por ahora, simplemente verifica si el usuario es "usuario" y la contraseña es "contraseña"
    if (usernameController.text == "usuario" && passwordController.text == "contraseña") {
      // Si la autenticación es exitosa, puedes navegar a otra pantalla o realizar la acción que desees.
      print("Inicio de sesión exitoso");
    } else {
      // Si la autenticación falla, muestra el error y cambia la imagen
      setState(() {
        showError = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Inicio de sesión"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            showError
                ? Image.asset(
                    "assets/images/stop.png", // Asegúrate de tener la imagen en la carpeta assets
                    height: 100,
                    width: 100,
                  )
                : Image.asset(
                    "assets/images/high-visibility-vest.png", // Asegúrate de tener la imagen en la carpeta assets
                    height: 100,
                    width: 100,
                  ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  TextField(
                    controller: usernameController,
                    decoration: InputDecoration(labelText: "Usuario"),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: passwordController,
                    decoration: InputDecoration(labelText: "Contraseña"),
                    obscureText: true,
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: login,
                    child: Text("Iniciar sesión"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
