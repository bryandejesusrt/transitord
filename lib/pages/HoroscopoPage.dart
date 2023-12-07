import 'package:flutter/material.dart';

class HoroscopoPage extends StatefulWidget {
  @override
  _HoroscopoPageState createState() => _HoroscopoPageState();
}

class _HoroscopoPageState extends State<HoroscopoPage> {
  String _signo = "";

  @override
  void initState() {
    super.initState();
    _getSigno();
  }

  void _getSigno() {
    DateTime now = DateTime.now();
    _signo = Zodiaco.getSigno(now.month, now.day);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Horóscopo"),
      ),
      body: Center(
        child: Text(_getSugerencia()),
      ),
    );
  }

  String _getSugerencia() {
    switch (_signo) {
      case "Aries":
        return "Ten cuidado con tu impulsividad. No tomes decisiones importantes a la ligera.";
      case "Tauro":
        return "No te dejes llevar por las apariencias. Mira más allá de lo superficial.";
      case "Géminis":
        return "No te disperses. Concéntrate en una cosa a la vez.";
      case "Cáncer":
        return "No te aferres al pasado. Deja ir lo que ya no te sirve.";
      case "Leo":
        return "No seas arrogante. Sé humilde y escucha a los demás.";
      case "Virgo":
        return "No seas tan crítico contigo mismo. Sé más amable y comprensivo.";
      case "Libra":
        return "No te dejes llevar por la opinión de los demás. Haz lo que creas que es correcto.";
      case "Escorpio":
        return "No te dejes llevar por tus emociones. Sé racional y piensa con la cabeza.";
      case "Sagitario":
        return "No seas tan impulsivo. Sé más precavido y planifica tus acciones.";
      case "Capricornio":
        return "No te dejes llevar por el trabajo. Tómate un tiempo para relajarte y divertirte.";
      case "Acuario":
        return "No seas tan independiente. Deja que los demás te ayuden.";
      case "Piscis":
        return "No te dejes llevar por tus sueños. Sé más realista y ponte los pies en la tierra.";
    }
    return "No se encontró el signo zodiacal";
  }
}

class Zodiaco {
  static const List<String> signos = [
    "Aries",
    "Tauro",
    "Géminis",
    "Cáncer",
    "Leo",
    "Virgo",
    "Libra",
    "Escorpio",
    "Sagitario",
    "Capricornio",
    "Acuario",
    "Piscis"
  ];

  static String getSigno(int mes, int dia) {
    int diaDelMes = dia;
    if (mes <= 2) {
      diaDelMes -= 12;
    }
    int signo = (diaDelMes + 2) % 12;

    return signos[signo];
  }

  static String getNombreSigno(String signo) {
    return signos.indexOf(signo).toString();
  }
}
