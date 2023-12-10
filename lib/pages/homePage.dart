import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart';
import 'package:flutter/material.dart';
import 'package:transitord/widgets/DrawerMenu.dart';
import 'package:transitord/widgets/noticias.dart';

class Home extends StatefulWidget {
  static const String routeName = '/home';
  List<Map<String, dynamic>>? noticias;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<Home> {
  List<Map<String, dynamic>>? noticias;

  @override
  void initState() {
    super.initState();
    cargarNoticias();
  }

  Future<void> cargarNoticias() async {
    final response = await http.get(
        Uri.parse('https://remolacha.net/wp-json/wp/v2/posts?search=digeset'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      setState(() {
        noticias = data.cast<Map<String, dynamic>>();
      });
    } else {
      throw Exception('Error al cargar las noticias');
    }
  }

  Future<void> _refreshNoticias() async {
    await cargarNoticias();
  }

  String _parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    return document.body!.text;
  }

  @override
  Widget build(BuildContext context) {
    // Obtén la hora actual
    DateTime now = DateTime.now();
    String saludo = obtenerSaludo(now.hour);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      drawer: DrawerMenu(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Card con saludo y horóscopo
            Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      '$saludo Bryan Rosa',
                      style: const TextStyle(fontSize: 24),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      'Horóscopo de Géminis: Texto del horóscopo aquí.',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Card con fecha y hora actual
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  '${now.hour}:${now.minute} del día ${now.day}, del mes de ${obtenerMes(now.month)} del año ${now.year}',
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Card con imagen y temperatura
            Card(
              child: Row(
                children: [
                  // Columna para la imagen
                  Expanded(
                    flex: 1,
                    child: Image.network(
                      'https://resources.diariolibre.com/images/imagenes/2014/22/456581-focus-0-0-375-240.jpg',
                      height: 100,
                      width: 100,
                    ),
                  ),
                  const SizedBox(width: 16),

                  // Columna para la temperatura y estado del clima
                  const Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Temperatura: 25°C',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Estado del clima: Despejado',
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Card con lista de noticias
            const Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      'Noticias Relevantes',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String obtenerSaludo(int hora) {
    if (hora < 12) {
      return 'Buenos días';
    } else if (hora < 18) {
      return 'Buenas tardes';
    } else {
      return 'Buenas noches';
    }
  }

  String obtenerMes(int numeroMes) {
    final meses = [
      'enero',
      'febrero',
      'marzo',
      'abril',
      'mayo',
      'junio',
      'julio',
      'agosto',
      'septiembre',
      'octubre',
      'noviembre',
      'diciembre'
    ];
    return meses[numeroMes - 1];
  }
}
