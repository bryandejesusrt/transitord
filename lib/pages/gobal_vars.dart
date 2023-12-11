import 'package:flutter/material.dart';
import 'package:transitord/pages/utils/Login.dart';

class GlobalVar {
  static String link =
      "https://kumar-harsh-frappe-api-dev-hiring-test.vercel.app";
  static String userid = "";

  static var selectedNavBarColor = const Color.fromARGB(255, 75, 125, 225);
  static const unselectedNavBarColor = Colors.black87;
  static const backgroundColor = Colors.white;
  static const Color greyBackgroundCOlor = Color(0xffebecee);
  static int agenteId = Login.agenteId;
  static String nombre = "";
  static String apellido = "";
  static String cedula = "";
  static String usuario = "";
}
