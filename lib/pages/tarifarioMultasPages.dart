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
        title: Text(
          "Consulta Tarifarío de Multas",
          style: TextStyle(fontSize: 15.sp, color: Colors.white),
        ),
        backgroundColor: '#359a5c'.toColor(),
        elevation: 10,
        shadowColor: Colors.black87,
      ),
      drawer: DrawerMenu(),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Tarifarío de Multas',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Text(
              'Aqui debajo se muestra el tarifarío de multas que se aplican en el sistema de transporte público de la ciudad de Santo Domingo R.D.',
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 4.h),
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
                        return Card(
                          elevation: 3,
                          margin: EdgeInsets.symmetric(vertical: 8),
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'ID: ${multa['id']}',
                                  style: TextStyle(fontSize: 14.sp),
                                ),
                                Text(
                                  'Descripción: ${multa['descripcion']}',
                                  style: TextStyle(fontSize: 13.sp),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.help),
                                      onPressed: () {
                                        // Acción cuando se presiona el botón EDITAR
                                      },
                                    ),
                                    SizedBox(width: 8),
                                    TextButton(
                                      child: Text('CONSULTAR'),
                                      onPressed: () {
                                        // Acción cuando se presiona el botón ELIMINAR
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
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
