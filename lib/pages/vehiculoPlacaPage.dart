import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:transitord/pages/utils/hexColorsUse.dart';
import 'package:transitord/widgets/DrawerMenu.dart';

class ConsultarVehiculoPlaca extends StatelessWidget {
  static const String routeName = '/vehiculoPlaca';

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
            Text(
              'Consulta de Multas',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            // Subtitulo con color más opaco
            Text(
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
              decoration: InputDecoration(
                hintText: 'Ingrese la placa',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            // Lista de multas
            Expanded(
              child: ListView.builder(
                itemCount: 5, // Reemplaza con la cantidad real de multas
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      title: const Text(
                        'Motivo de la Multa',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      subtitle: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Descripción corta de la multa',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.black87,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Fecha y hora de la multa',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      trailing: ElevatedButton(
                        onPressed: () {
                          // Navegar a la pantalla de detalle de la multa
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetalleMultaScreen(),
                            ),
                          );
                        },
                        child: Text('Detalle de la Multa'),
                      ),
                    ),
                  );
                },
              ),
            ),
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
