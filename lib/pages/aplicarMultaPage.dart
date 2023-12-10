import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:transitord/pages/gobal_vars.dart';
import 'package:transitord/pages/mapaModalPage.dart';
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
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Aplicar Multa!",
                              style: TextStyle(
                                  color: '#359a5c'.toColor(),
                                  fontSize: 30,
                                  fontWeight: FontWeight.w600)),
                          SizedBox(
                            height: 1.h,
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
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: TextField(
                        keyboardType: TextInputType.multiline,
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
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Fotos de la Multa",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 19,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          ImageInput(
                            allowEdit: true,
                            allowMaxImage: 5,
                            initialImages: images,
                            onImageSelected: (image, index) {
                              //save image to cloud and get the url
                              //or
                              //save image to local storage and get the path
                              String? tempPath = image.path;
                              print(tempPath);
                              setState(() {
                                images.add(image);
                              });
                            },
                            onImageRemoved: (image, index) {
                              setState(() {
                                images.removeAt(index);
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: TextField(
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        minLines: 3, // Adjust this value as needed
                        decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.comment,
                            color: Colors.black54,
                          ),
                          border: const OutlineInputBorder(
                            // width: 0.0 produces a thin "hairline" border
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0)),
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
                          hintText: 'Comentarios de la Multa',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 18.0, right: 18, top: 2, bottom: 18),
                      child: GestureDetector(
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime(2100),
                          );
                          // if (pickedDate != null) {
                          //   setState(() {
                          //     _chosenDate = pickedDate;
                          //   });
                          // }
                        },
                        child: TextFormField(
                          // Disable text editing
                          enabled: false,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.calendar_today,
                              color: Colors.black54,
                            ),
                            border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(90.0)),
                              borderSide: BorderSide.none,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: const BorderSide(
                                color: Colors.red,
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
                            // Display chosen date or initial hint if not picked yet
                            hintText: 'Pick a date',
                          ),
                          onChanged: (value) {
                            // Update chosen date variable
                            // setState(() {
                            //   _chosenDate = DateTime.parse(value);
                            // });
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // ...
                          Padding(
                            padding: EdgeInsets.all(16),
                            child: ElevatedButton.icon(
                              onPressed: () async {
                                // Abre la pantalla modal y espera la respuesta
                                LatLng? resultado = await showModalBottomSheet(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      MapaModal(),
                                );

                                // Si se seleccionó una ubicación, puedes utilizarla aquí
                                if (resultado != null) {
                                  // Aquí puedes utilizar las coordenadas (resultado.latitude y resultado.longitude)
                                  // para almacenar en tu variable o realizar cualquier otra acción.
                                }
                              },
                              icon: Icon(Icons.location_on),
                              label: Text("Seleccionar Ubicación"),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: TextField(
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
                      padding: const EdgeInsets.all(18.0),
                      child: TextField(
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
                    SizedBox(
                      height: 2.h,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 18.0, right: 18, top: 2, bottom: 18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Texto sobre la hora de la multa
                          const Text(
                            "La hora y fecha de la multa se tomará automáticamente",
                            style: TextStyle(
                              color: Color.fromARGB(255, 70, 70, 70),
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 8), // Espacio entre los textos

                          // Obtener la hora actual en formato de 24 horas
                          Text(
                            "Hora actual: ${DateFormat('HH:mm').format(DateTime.now())}",
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.normal,
                              color: Colors.grey,
                            ),
                          ),

                          // Obtener la fecha actual
                          Text(
                            "Fecha: ${DateFormat('d/M/yyyy').format(DateTime.now())}",
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.normal,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(
                            left: 28.w, right: 28.w, bottom: 5.h),
                        child: InkWell(
                          onTap: () {},
                          child: GestureDetector(
                              onTap: () {
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
                              },
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
                                              fontWeight: FontWeight.bold))),
                                ),
                              )),
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
}
