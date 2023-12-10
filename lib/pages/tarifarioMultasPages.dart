import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:transitord/pages/utils/hexColorsUse.dart';
import 'package:transitord/widgets/DrawerMenu.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class TarifarioMultas extends StatefulWidget {
  static const String routeName = '/tarifario';
  @override
  _MyScreenState createState() => _MyScreenState();
}

class _MyScreenState extends State<TarifarioMultas> {
  bool _isLoading = false;
  TextEditingController licenciaController = TextEditingController();

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
        title: const Text(
          "Consulta Tarifarío de Multas",
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.start,
        ),
        backgroundColor: '#359a5c'.toColor(),
        elevation: 10,
        shadowColor: Colors.black87,
      ),
      drawer: DrawerMenu(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Buscar en el Tarifarío de Multas',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const Text(
              'Ingrese el nombre de la infracción',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            // TextFormField(
            //   controller: licenciaController,
            //   decoration: InputDecoration(
            //     hintText: 'Ingrese la multa que quiere consultar',
            //     prefixIcon: Icon(Icons.search),
            //     border: OutlineInputBorder(
            //       borderRadius: BorderRadius.circular(10),
            //     ),
            //   ),
            // ),
            // const SizedBox(
            //   height: 20,
            // ),
            // ElevatedButton(
            //   onPressed: () {
            //     setState(() {
            //       _isLoading = true;
            //     });
            //     fetchData();
            //   },
            //   child: Text('Buscar'),
            // ),
            SizedBox(
              height: 1.h,
            ),
            Expanded(
              child: FutureBuilder<List<Map<String, dynamic>>>(
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
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final multa = snapshot.data![index];
                        return ListTile(
                          title: Text('ID: ${multa['id']}'),
                          subtitle:
                              Text('Descripción: ${multa['descripcion']}'),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
