import 'package:flutter/material.dart';
import 'package:transitord/widgets/DrawerMenu.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class MultasRegistradas extends StatefulWidget {
  static const String routeName = '/multasregistradas';

  @override
  _MyScreenState createState() => _MyScreenState();
}

class _MyScreenState extends State<MultasRegistradas> {
  Future<List<Map<String, dynamic>>> fetchData() async {
    final response = await http.get(Uri.parse(
        'https://transitord20231207185629.azurewebsites.net/api/v1/Multas/Multass'));
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
                  onTap: () {
                    // Navigator.pushReplacementNamed(context, MyApp.home)
                    Navigator.pushNamed(context, '/multasregistradasdetalles',
                        arguments: multa['id']);
                  },
                  title: Text('Vehiculo: ${multa['placa_Vehiculo']}'),
                  subtitle: Text('${multa['motivo']}'),
                  leading: Text('${multa['codigoMulta']}'),
                  trailing: const Icon(Icons.arrow_forward),
                );
              },
            );
          }
        },
      ),
    );
  }
}
