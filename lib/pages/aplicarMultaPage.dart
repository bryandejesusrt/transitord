import 'dart:convert';
import 'package:record/record.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:sizer/sizer.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:transitord/pages/gobal_vars.dart';
import 'package:transitord/pages/mapaModalPage.dart';
import 'package:transitord/pages/utils/Login.dart';
import 'package:transitord/pages/utils/hexColorsUse.dart';
import 'package:transitord/widgets/DrawerMenu.dart';
import 'package:image_input/image_input.dart';
import 'package:latlong2/latlong.dart';

class AplicarMulta extends StatefulWidget {
  static const String routeName = '/aplicarmultas';
  @override
  State<AplicarMulta> createState() => _AplicarMultaState();
}

class _AplicarMultaState extends State<AplicarMulta> {
  List<XFile> images = [];
  TextEditingController codigoMulta = TextEditingController();
  TextEditingController motivo = TextEditingController();
  TextEditingController foto = TextEditingController();
  TextEditingController audio = TextEditingController();
  TextEditingController longitud = TextEditingController();
  TextEditingController latitud = TextEditingController();
  TextEditingController placa_Vehiculo = TextEditingController();
  TextEditingController cedula_infractor = TextEditingController();

// Lista de opciones
  List<Map<String, dynamic>> opciones = [];
  // Valor seleccionado
  Map<String, dynamic>? valorSeleccionado;

  bool _isLoading = false;

  //GRABACION DE VOZ
  late AudioRecorder audioRecord;
  late AudioPlayer audioPlayer;
  bool isRecording = false;
  String audioPath = '';
  XFile? _image;

  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();
    audioRecord = AudioRecorder();
    _getList();
  }

  void _getList() async {
    final response = await http.get(Uri.parse(
        'https://transitord20231207185629.azurewebsites.net/api/v1/MultasTipo/MultasTipos'));
    if (response.statusCode == 200) {
      List<Map<String, dynamic>> result =
          List<Map<String, dynamic>>.from(json.decode(response.body));
      setState(() {
        opciones = result;
      });
    } else {
      print("Error al obtener la lista");
    }
  }

  @override
  void dispose() {
    audioRecord.dispose();
    audioPlayer.dispose();
    super.dispose();
  }

  Future<void> startRecording() async {
    try {
      if (await audioRecord.hasPermission()) {
        audioPath =
            '/data/user/0/com.example.transitord/cache/${DateTime.now().millisecondsSinceEpoch}.m4a';
        await audioRecord.start(const RecordConfig(), path: audioPath);
        setState(() {
          isRecording = true;
        });
      }
    } catch (e) {
      print('Error al iniciar la grabacion');
    }
  }

  Future<void> stopRecording() async {
    try {
      String? path = await audioRecord.stop();
      audioPath = path!;
      print(audioPath);
      setState(() {
        isRecording = false;
      });
    } catch (e) {
      print('Error al detener la grabacion: $e');
    }
  }

  Future<void> _pickImage() async {
    final XFile? pickedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      _image = pickedImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Aplicar Multa",
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.start,
          ),
          backgroundColor: '#359a5c'.toColor(),
          elevation: 10,
          shadowColor: Colors.black87,
        ),
        backgroundColor: Colors.white,
        drawer: DrawerMenu(),
        body: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Stack(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 00.0, bottom: 10, left: 10),
                        child: IconButton(
                          constraints:
                              const BoxConstraints(minWidth: 30, minHeight: 30),
                          icon: Image(
                            image: const AssetImage(
                                'lib/assets/images/cedulaexplicacion.png'),
                            height: 30,
                          ),
                          onPressed: () async {
                            // Navigator.of(context).push(MaterialPageRoute(
                            // builder: (context) => ProfilePageUser()));
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 18.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 4.h,
                          ),
                          const Row(
                            children: [
                              Text("Aplicar Multa a : ",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 19)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        // controller: title,
                        decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.badge_outlined,
                              color: Colors.black54,
                            ),
                            border: const OutlineInputBorder(
                              // width: 0.0 produces a thin "hairline" border
                              borderRadius:
                                  BorderRadius.all(Radius.circular(90.0)),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: const BorderSide(
                                color: Color.fromARGB(255, 16, 83, 18),
                                width: 1.0,
                              ),
                            ),
                            hintStyle: const TextStyle(
                                fontSize: 15,
                                color: Colors.black54,
                                fontFamily: "WorkSansLight"),
                            filled: true,
                            fillColor: GlobalVar.greyBackgroundCOlor,
                            hintText: 'Cedula del Conductor o pasaporte'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: TextFormField(
                        // controller: title,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.credit_card,
                              color: Colors.black54,
                            ),
                            border: const OutlineInputBorder(
                              // width: 0.0 produces a thin "hairline" border
                              borderRadius:
                                  BorderRadius.all(Radius.circular(90.0)),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: const BorderSide(
                                color: Color.fromARGB(255, 16, 83, 18),
                                width: 1.0,
                              ),
                            ),
                            hintStyle: const TextStyle(
                                fontSize: 15,
                                color: Colors.black54,
                                fontFamily: "WorkSansLight"),
                            filled: true,
                            fillColor: GlobalVar.greyBackgroundCOlor,
                            hintText: 'Placa del Vehiculo'),
                      ),
                    ),

                    // Padding(
                    //   padding: const EdgeInsets.all(18.0),
                    //   child: TextField(
                    //     keyboardType: TextInputType.multiline,
                    //     maxLines: null,
                    //     minLines: 3, // Adjust this value as needed
                    //     decoration: InputDecoration(
                    //       prefixIcon: const Icon(
                    //         Icons.help,
                    //         color: Colors.black54,
                    //       ),
                    //       border: const OutlineInputBorder(
                    //         // width: 0.0 produces a thin "hairline" border
                    //         borderRadius:
                    //             BorderRadius.all(Radius.circular(20.0)),
                    //         borderSide: BorderSide.none,
                    //       ),
                    //       focusedBorder: OutlineInputBorder(
                    //         borderRadius: BorderRadius.circular(25.0),
                    //         borderSide: const BorderSide(
                    //           color: Color.fromARGB(255, 16, 83, 18),
                    //           width: 1.0,
                    //         ),
                    //       ),
                    //       hintStyle: const TextStyle(
                    //         fontSize: 15,
                    //         color: Colors.black54,
                    //         fontFamily: "WorkSansLight",
                    //       ),
                    //       filled: true,
                    //       fillColor: GlobalVar.greyBackgroundCOlor,
                    //       hintText: 'Motivo de la Multa',
                    //     ),
                    //   ),
                    // ),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 1.h),
                              child: IconButton(
                                constraints: const BoxConstraints(
                                    minWidth: 30, minHeight: 30),
                                icon: Image(
                                  image: const AssetImage(
                                      'lib/assets/images/cedulaexplicacion.png'),
                                  height: 25.h,
                                ),
                                onPressed: () async {
                                  // Navigator.of(context).push(MaterialPageRoute(
                                  // builder: (context) => ProfilePageUser()));
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 1.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Registro de multa",
                                    style: TextStyle(
                                        color: '#359a5c'.toColor(),
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600)),
                                const Row(
                                  children: [
                                    Text(
                                        "Rellene los campos para aplicar la multa",
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 14)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 1.h),
                            child: TextFormField(
                              keyboardType: TextInputType.text,
                              controller: cedula_infractor,
                              decoration: InputDecoration(
                                  prefixIcon: const Icon(
                                    Icons.badge_outlined,
                                    color: Colors.black54,
                                  ),
                                  border: const OutlineInputBorder(
                                    // width: 0.0 produces a thin "hairline" border
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(90.0)),
                                    borderSide: BorderSide.none,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                    borderSide: const BorderSide(
                                      color: Color.fromARGB(255, 16, 83, 18),
                                      width: 1.0,
                                    ),
                                  ),
                                  hintStyle: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.black54,
                                      fontFamily: "WorkSansLight"),
                                  filled: true,
                                  fillColor: GlobalVar.greyBackgroundCOlor,
                                  hintText: 'Cedula del Conductor o pasaporte'),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 1.h),
                            child: TextFormField(
                              controller: placa_Vehiculo,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  prefixIcon: const Icon(
                                    Icons.drive_eta,
                                    color: Colors.black54,
                                  ),
                                  border: const OutlineInputBorder(
                                    // width: 0.0 produces a thin "hairline" border
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(90.0)),
                                    borderSide: BorderSide.none,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                    borderSide: const BorderSide(
                                      color: Color.fromARGB(255, 16, 83, 18),
                                      width: 1.0,
                                    ),
                                  ),
                                  hintStyle: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.black54,
                                      fontFamily: "WorkSansLight"),
                                  filled: true,
                                  fillColor: GlobalVar.greyBackgroundCOlor,
                                  hintText: 'Placa del Vehiculo'),
                            ),
                          ),
                          // Padding(
                          //   padding: EdgeInsets.only(bottom: 1.h),
                          //   child: TextFormField(
                          //     controller: codigoMulta,
                          //     keyboardType: TextInputType.number,
                          //     decoration: InputDecoration(
                          //         prefixIcon: const Icon(
                          //           Icons.numbers,
                          //           color: Colors.black54,
                          //         ),
                          //         border: const OutlineInputBorder(
                          //           // width: 0.0 produces a thin "hairline" border
                          //           borderRadius:
                          //               BorderRadius.all(Radius.circular(90.0)),
                          //           borderSide: BorderSide.none,
                          //         ),
                          //         focusedBorder: OutlineInputBorder(
                          //           borderRadius: BorderRadius.circular(25.0),
                          //           borderSide: const BorderSide(
                          //             color: Color.fromARGB(255, 16, 83, 18),
                          //             width: 1.0,
                          //           ),
                          //         ),
                          //         hintStyle: const TextStyle(
                          //             fontSize: 15,
                          //             color: Colors.black54,
                          //             fontFamily: "WorkSansLight"),
                          //         filled: true,
                          //         fillColor: GlobalVar.greyBackgroundCOlor,
                          //         hintText: 'Codigo multa'),
                          //   ),
                          // ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 1.h),
                            child: Column(
                              children: [
                                const Row(
                                  children: [
                                    Text("Codigo multa",
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 14)),
                                  ],
                                ),
                                DropdownButton<Map<String, dynamic>>(
                                  value: valorSeleccionado,
                                  onChanged: (Map<String, dynamic>? newValue) {
                                    setState(() {
                                      valorSeleccionado = newValue;
                                    });
                                  },
                                  items: opciones.map<
                                      DropdownMenuItem<Map<String, dynamic>>>(
                                    (Map<String, dynamic> value) {
                                      return DropdownMenuItem<
                                          Map<String, dynamic>>(
                                        value: value,
                                        child: Text(value['descripcion']),
                                      );
                                    },
                                  ).toList(),
                                ),
                                // Text(
                                //     'Multa seleccionada: ${valorSeleccionado != null ? valorSeleccionado!["descripcion"] : "Ninguna"}'),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 1.h),
                            child: TextField(
                              keyboardType: TextInputType.multiline,
                              controller: motivo,
                              maxLines: null,
                              minLines: 3, // Adjust this value as needed
                              decoration: InputDecoration(
                                prefixIcon: const Icon(
                                  Icons.help,
                                  color: Colors.black54,
                                ),
                                border: const OutlineInputBorder(
                                  // width: 0.0 produces a thin "hairline" border
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0)),
                                  borderSide: BorderSide.none,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 16, 83, 18),
                                    width: 1.0,
                                  ),
                                ),
                                hintStyle: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.black54,
                                  fontFamily: "WorkSansLight",
                                ),
                                filled: true,
                                fillColor: GlobalVar.greyBackgroundCOlor,
                                hintText: 'Motivo de la Multa',
                              ),
                            ),
                          ),
                          // Padding(
                          //   padding: const EdgeInsets.all(18.0),
                          //   child: Column(
                          //     crossAxisAlignment: CrossAxisAlignment.start,
                          //     children: [
                          //       Align(
                          //         alignment: Alignment.centerLeft,
                          //         child: Text(
                          //           "Fotos de la Multa",
                          //           style: TextStyle(
                          //             color: Colors.black,
                          //             fontSize: 19,
                          //             fontWeight: FontWeight.w600,
                          //           ),
                          //         ),
                          //       ),
                          //       ImageInput(
                          //         allowEdit: true,
                          //         allowMaxImage: 5,
                          //         initialImages: images,
                          //         onImageSelected: (image, index) {
                          //           //save image to cloud and get the url
                          //           //or
                          //           //save image to local storage and get the path
                          //           String? tempPath = image.path;
                          //           print(tempPath);
                          //           setState(() {
                          //             images.add(image);
                          //           });
                          //         },
                          //         onImageRemoved: (image, index) {
                          //           setState(() {
                          //             images.removeAt(index);
                          //           });
                          //         },
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 1.h),
                            child: TextField(
                              controller: longitud,
                              keyboardType: TextInputType.text,
                              maxLines: null,
                              decoration: InputDecoration(
                                prefixIcon: const Icon(
                                  Icons.location_on_outlined,
                                  color: Colors.black54,
                                ),
                                border: const OutlineInputBorder(
                                  // width: 0.0 produces a thin "hairline" border
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0)),
                                  borderSide: BorderSide.none,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 16, 83, 18),
                                    width: 1.0,
                                  ),
                                ),
                                hintStyle: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.black54,
                                  fontFamily: "WorkSansLight",
                                ),
                                filled: true,
                                fillColor: GlobalVar.greyBackgroundCOlor,
                                hintText: 'Longitud de la Multa',
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 1.h),
                            child: TextField(
                              controller: latitud,
                              keyboardType: TextInputType.text,
                              maxLines: null,
                              decoration: InputDecoration(
                                prefixIcon: const Icon(
                                  Icons.location_on_outlined,
                                  color: Colors.black54,
                                ),
                                border: const OutlineInputBorder(
                                  // width: 0.0 produces a thin "hairline" border
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0)),
                                  borderSide: BorderSide.none,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 16, 83, 18),
                                    width: 1.0,
                                  ),
                                ),
                                hintStyle: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.black54,
                                  fontFamily: "WorkSansLight",
                                ),
                                filled: true,
                                fillColor: GlobalVar.greyBackgroundCOlor,
                                hintText: 'Latitud de la Multa',
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 1.h),
                            child: ElevatedButton(
                              onPressed: _pickImage,
                              child: const Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Text(
                                    'Agregar ',
                                    style: TextStyle(color: Colors.green),
                                  ),
                                  Icon(Icons.add_a_photo, color: Colors.green),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 1.h),
                            child: ElevatedButton(
                              onPressed:
                                  isRecording ? stopRecording : startRecording,
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Text(
                                    (isRecording ? 'Detener' : 'Grabar'),
                                    style: isRecording
                                        ? TextStyle(color: Colors.red)
                                        : TextStyle(color: Colors.green),
                                  ),
                                  Icon(Icons.mic,
                                      color: isRecording
                                          ? Colors.red
                                          : Colors.green),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 28.w, right: 28.w, bottom: 1.h),
                              child: InkWell(
                                onTap: () {},
                                child: GestureDetector(
                                  // onTap: () {
                                  // addBooktoDB(
                                  //     title.text.toString(),
                                  //     authors.text.toString(),
                                  //     isbn.text.toString(),
                                  //     isbn13.text.toString(),
                                  //     publisher.text.toString(),
                                  //     numpagess.text.toString(),
                                  //     average_ratings.text.toString(),
                                  //     book_id.text.toString(),
                                  //     language_code.text.toString(),
                                  //     publication_date.text.toString(),
                                  //     ratings_count.text.toString(),
                                  //     text_reviews_count.text.toString());
                                  // },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: Color.fromARGB(255, 16, 83, 18),
                                    ),
                                    child: Center(
                                      child: Padding(
                                          padding: EdgeInsets.only(
                                              top: 2.h,
                                              bottom: 2.h,
                                              left: 2.8.w,
                                              right: 2.8.w),
                                          child: Text('Aplicar Multa',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 13.sp,
                                                  fontWeight:
                                                      FontWeight.bold))),
                                    ),
                                  ),
                                  onTap: enviarMulta,
                                ),
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
      );
    });
  }

  Future<void> enviarMulta() async {
    setState(() {
      _isLoading = true;
    });
    String fecha = DateFormat('dd/MM/yyyy').format(DateTime.now());
    String hora = DateFormat('hh:mm a').format(DateTime.now());
    String imagenPath = _image == null ? '' : _image!.path;

    final json = {
      "agenteId": Login.agenteId.toString(),
      "codigoMulta": valorSeleccionado!["id"],
      "motivo": motivo.text,
      "foto": imagenPath, //foto.text,
      "audio": audioPath, //audio.text,
      "longitud": longitud.text,
      "latitud": latitud.text,
      "placa_Vehiculo": placa_Vehiculo.text,
      "cedula_infractor": cedula_infractor.text,
      "fecha": fecha,
      "hora": hora,
    };
    print(json);
    var url = Uri.parse(
        'https://transitord20231207185629.azurewebsites.net/api/v1/Multas/Multas');
    final response = await http.post(
      url,
      body: jsonEncode(json),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    print(response.statusCode);
    if (response.statusCode == 200 || response.statusCode == 201) {
      setState(() {
        _isLoading = false;
      });
      Fluttertoast.showToast(
          msg: 'Multa aplicada correctamente',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP_RIGHT,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 15.0);
    } else {
      setState(() {
        _isLoading = false;
      });
      Fluttertoast.showToast(
          msg: 'Ha ocurrido un error al momento de aplicar la multa',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP_RIGHT,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 15.0);
    }
  }
}
