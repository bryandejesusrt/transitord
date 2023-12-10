import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:transitord/pages/utils/hexColorsUse.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:transitord/widgets/DrawerMenu.dart';

class ConsultarVehiculoPlaca extends StatefulWidget {
  static const String routeName = '/vehiculoPlaca';
  @override
  _MyScreenState createState() => _MyScreenState();
}

class _MyScreenState extends State<ConsultarVehiculoPlaca> {
  TextEditingController placaController = TextEditingController();
  bool _isLoading = false;
  String mensaje =
      'Introduce el numero de placa incluyendo numeros y letras y luego pula en buscar.';
  var data = null;

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse(
        'https://transitord20231207185629.azurewebsites.net/api/v1/Vehiculo/Vehiculo/plate/${placaController.text}'));
    if (response.statusCode == 200) {
      print(json.decode(response.body));
      setState(() {
        data = json.decode(response.body);
        _isLoading = false;
      });
    } else {
      setState(() {
        mensaje = 'Vehiculo no encontrado.';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Consulta de vehículo por placa",
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
            // Titulo con color negro
            const Text(
              'Consulta de Multas',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            // Subtitulo con color más opaco
            const Text(
              'Ingrese la placa del vehículo a consultar',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            TextFormField(
              controller: placaController,
              decoration: InputDecoration(
                hintText: 'Ingrese la placa',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _isLoading = true;
                });
                fetchData();
              },
              child: Text('Buscar'),
            ),
            SizedBox(
              height: 2.h,
            ),
            _isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : data != null
                    ? Center(
                        child: Card(
                          margin: EdgeInsets.all(16.0),
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Placa: ${data['placa']}'),
                                Text('Chasis: ${data['chasis']}'),
                                Text('Marca: ${data['marca']}'),
                                Text('Modelo: ${data['modelo']}'),
                                Text('Color: ${data['color']}'),
                                Text('Fabricacion: ${data['fabricacion']}'),
                                Text('Estatus: ${data['estatus']}'),
                                Text('Multas: ${data['multas']}'),
                                Text(
                                    'Nombre Propietario: ${data['nombre_Propietario']}'),
                                Text(
                                    'Direccion Propietario: ${data['direccion_Propietario']}'),
                                Text(
                                    'Cedula Propietario: ${data['cedula_Propietario']}'),
                                Text('Tipo vehiculo: ${data['tipo_vehiculo']}'),
                                Text('Tipo Emision: ${data['tipoEmision']}'),
                              ],
                            ),
                          ),
                        ),
                      )
                    : Text(mensaje),
          ],
        ),
      ),
    );
  }
}

class DetalleMultaScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detalle de la Multa"),
      ),
      body: Center(
        child: Text(
          'Detalles de la Multa',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
