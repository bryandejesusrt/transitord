import 'package:flutter/material.dart';
import 'package:transitord/widgets/DrawerMenu.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class TarifarioMultas extends StatefulWidget {
  static const String routeName = '/tarifario';
  @override
  _MyScreenState createState() => _MyScreenState();
}

class _MyScreenState extends State<TarifarioMultas> {
  Future<List<Map<String, dynamic>>> fetchData() async {
    final response = await http.get(Uri.parse(
        'https://transitord20231207185629.azurewebsites.net/api/v1/MultasTipo/MultasTipos'));
    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(json.decode(response.body));
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles de Multas'),
      ),
      drawer: DrawerMenu(),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text('No se encontraron datos'),
            );
          } else {
            // Muestra la lista de detalles
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final multa = snapshot.data![index];
                return ListTile(
                  title: Text('ID: ${multa['id']}'),
                  subtitle: Text('Descripción: ${multa['descripcion']}'),
                );
              },
            );
          }
        },
      ),
    );
  }
}
