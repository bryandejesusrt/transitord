// import 'dart:io';
// import 'package:audioplayers/audioplayers.dart';
// import 'package:flutter/material.dart';

// class multasRegistradasDetalles extends StatelessWidget {
//   final String Id;
//   String audioPath;

//   multasRegistradasDetalles({
//     required this.Id,
//   });

//   Future<void> playRecording() async {
//     try {
//       AudioPlayer audioPlayer = AudioPlayer();
//       Source urlsource = UrlSource(audioPath);
//       await audioPlayer.play(urlsource);
//     } catch (e) {
//       print('Error al reproducir la grabacion: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.lightGreen,
//       appBar: AppBar(
//         backgroundColor: Colors.lightGreen,
//         title: Text(title,
//             style: const TextStyle(
//               color: Colors.white,
//             )),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(title,
//                 style: const TextStyle(
//                   fontSize: 24,
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold,
//                 )),
//             // audioPath != null && audioPath.isNotEmpty
//             //     ? Text("audioPath: $audioPath")
//             //     : const Text("No hubo grabacion de audio ese dia."),
//             photoPath != null && photoPath.isNotEmpty
//                 ? Image.file(
//                     File(photoPath),
//                     width: 200,
//                     height: 200,
//                   )
//                 : const Text("No se tomaron fotos este dia."),
//             const SizedBox(height: 10),
//             audioPath != null && audioPath.isNotEmpty
//                 ? ElevatedButton(
//                     onPressed: playRecording,
//                     child: const Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: <Widget>[
//                         Text(
//                           'Reproducir ',
//                           style: TextStyle(color: Colors.green),
//                         ),
//                         Icon(Icons.headphones, color: Colors.green),
//                       ],
//                     ),
//                   )
//                 : const Text("No hubo grabacion de audio ese dia."),
//             const SizedBox(height: 10),
//             Text(date,
//                 style: const TextStyle(
//                   fontSize: 14,
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold,
//                 )),
//             const SizedBox(height: 3),
//             Text(
//               description,
//               style: const TextStyle(
//                 fontSize: 14,
//                 color: Colors.white,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:transitord/widgets/DrawerMenu.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class multasRegistradasDetalles extends StatefulWidget {
  static const String routeName = '/multasregistradasdetalles';
  final String Id;

  multasRegistradasDetalles({
    required this.Id,
  });

  @override
  _MyScreenState createState() => _MyScreenState(Id: Id);
}

class _MyScreenState extends State<multasRegistradasDetalles> {
  final String Id;

  _MyScreenState({
    required this.Id,
  });

  String agenteId = '';
  String codigoMulta = '';
  String motivo = '';
  String foto = '';
  String audio = '';
  String longitud = '';
  String latitud = '';
  String placa_Vehiculo = '';
  String cedula_infractor = '';
  String fecha = '';
  String hora = '';

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse(
        'https://transitord20231207185629.azurewebsites.net/api/v1/Multas/Multas/$Id'));
    if (response.statusCode == 200) {
      var temp = json.decode(response.body);
      print(temp);
      setState(() {
        agenteId = temp['agenteId'].toString();
        codigoMulta = temp['codigoMulta'].toString();
        motivo = temp['motivo'].toString();
        foto = temp['foto'].toString();
        audio = temp['audio'].toString();
        longitud = temp['longitud'].toString();
        latitud = temp['latitud'].toString();
        placa_Vehiculo = temp['placa_Vehiculo'].toString();
        cedula_infractor = temp['cedula_infractor'].toString();
        fecha = temp['fecha'].toString();
        hora = temp['hora'].toString();
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles de Multas'),
      ),
      drawer: DrawerMenu(),
      body: Center(
        child: Card(
          margin: EdgeInsets.all(16.0),
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('agenteId: $agenteId'),
                Text('codigoMulta: $codigoMulta'),
                Text('motivo: $motivo'),
                Text('foto: $foto'),
                Text('audio: $audio'),
                Text('longitud: $longitud'),
                Text('placa_Vehiculo: $placa_Vehiculo'),
                Text('cedula_infractor: $cedula_infractor'),
                Text('fecha: $fecha'),
                Text('hora: $hora'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
