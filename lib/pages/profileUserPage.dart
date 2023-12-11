import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:transitord/pages/gobal_vars.dart';
import 'package:transitord/pages/utils/Login.dart';

String nombre = "";
String apellido = "";
String usuario = "";
String cedulla = "";

class ProfilePageUser extends StatefulWidget {
  @override
  State<ProfilePageUser> createState() => _ProfilePageUserState();
}

class _ProfilePageUserState extends State<ProfilePageUser> {
  // FlutterSecureStorage storage = const FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    fetchDataAgente();
  }

  Future<void> fetchDataAgente() async {
    var url = Uri.parse(
        'https://transitord20231207185629.azurewebsites.net/api/v1/Agente/Agente/${Login.agenteId}');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      nombre = data['nombre'];
      apellido = data['apellido'];
      usuario = data['usuario'];
      cedulla = data['cedula'];

      // Puedes imprimir los valores para verificar
      print('Nombre: $nombre');
      print('Apellido: $apellido');
      print('Usuario: $usuario');
      print('Cédula: $cedulla');
    } else {
      print('Error en la llamada a la API');
    }
  }
  // void toast(String msg) {
  //   Fluttertoast.showToast(
  //       msg: msg,
  //       toastLength: Toast.LENGTH_LONG,
  //       gravity: ToastGravity.BOTTOM,
  //       timeInSecForIosWeb: 2,
  //       backgroundColor: Colors.black,
  //       textColor: Colors.white,
  //       fontSize: 15.0);
  // }

  // showDialogFunction() {
  //   showDialog(
  //       context: context,
  //       builder: (context) {
  //         return AlertDialog(
  //           // title: Text('Material Alert Dialog'),
  //           content: const Text("Are you sure you want to Logout?"),
  //           actions: <Widget>[
  //             TextButton(
  //                 onPressed: () async {
  //                   await storage.deleteAll();
  //                   Navigator.of(context).pop();
  //                   Navigator.of(context).pushAndRemoveUntil(
  //                       MaterialPageRoute(
  //                           builder: (context) => const LoginScreenNew()),
  //                       (Route<dynamic> route) => true);
  //                 },
  //                 child: const Text('Yes')),
  //             TextButton(
  //               onPressed: () {
  //                 Navigator.pop(context); //close Dialog
  //               },
  //               child: const Text('No'),
  //             ),
  //           ],
  //         );
  //       });
  // }

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            "Tu Perfil",
            style: TextStyle(color: Colors.white),
          ),
          elevation: 0,
          backgroundColor: const Color(0xFF022136),
          iconTheme: const IconThemeData(color: Colors.white, size: 22.0),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: InkWell(
                child: const Icon(
                  Icons.logout_outlined,
                  color: Colors.white,
                ),
                onTap: () async {
                  // showDialogFunction();
                },
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                color: const Color(0xFF022136),
                alignment: Alignment.center,
                child: Column(
                  children: [
                    SizedBox(
                      height: 2.h,
                    ),
                    Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(
                            color: const Color(0xff081108),
                            width: 2,
                          ),
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.white24,
                              blurRadius: 20,
                              offset: Offset(5, 5),
                            ),
                          ]),
                      child: const CircleAvatar(
                        radius: 70,
                        backgroundColor: Colors.white,
                        backgroundImage: NetworkImage(
                            "https://resources.diariolibre.com/images/imagenes/2014/22/456581-focus-0-0-375-240.jpg"),
                      ),
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    Text(
                      "${nombre} ${apellido}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Amet(primer teniente))",
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    SizedBox(
                      height: 100.h,
                      child: Card(
                        color: Colors.white,
                        elevation: 5,
                        margin: EdgeInsets.zero,
                        clipBehavior: Clip.antiAlias,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(50),
                                topRight: Radius.circular(50))),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 20, left: 50, right: 50, bottom: 10),
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.only(
                                    top: 20, left: 10, bottom: 10),
                                alignment: Alignment.center,
                                child: Text(
                                  "Tu" + " Informacion:",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                              Column(
                                children: [
                                  SizedBox(height: 2.h),
                                  Card(
                                    color: Colors.white,
                                    elevation: 2,
                                    margin: EdgeInsets.zero,
                                    clipBehavior: Clip.antiAlias,
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(28))),
                                    child: ListTile(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                        horizontal: 18,
                                        vertical: 8,
                                      ),
                                      leading: const Icon(Icons.email),
                                      title: const Text("Correo Electronico"),
                                      subtitle: Text(
                                          "$nombre$apellido@digesett.gob.do"),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 1.h,
                                  ),
                                  Card(
                                    color: Colors.white,
                                    elevation: 2,
                                    margin: EdgeInsets.zero,
                                    clipBehavior: Clip.antiAlias,
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(28))),
                                    child: ListTile(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                        horizontal: 18,
                                        vertical: 8,
                                      ),
                                      leading: const Icon(Icons.phone),
                                      title: const Text(
                                          "Numero de Telefono / cedula"),
                                      subtitle: Text("$cedulla"),
                                      // onTap: ,
                                      // trailing: InkWell(child: Icon(Icons.edit, color: Colors.blueGrey,)),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 1.h,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
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
