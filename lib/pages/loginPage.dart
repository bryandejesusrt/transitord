import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:sizer/sizer.dart';
import 'package:transitord/pages/utils/hexColorsUse.dart';

class LoginPage extends StatefulWidget {
  static const String routeName = "/LoginPage";

  const LoginPage({super.key});

  @override
  _LoginClassState createState() => _LoginClassState();
}

class _LoginClassState extends State<LoginPage> {
  TextEditingController userIdController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _obscureText = true, _isLoading = false;

  final List<Widget> users = <Widget>[Text('User'), Text('Worker')];
  final List<bool> selectedUsers = <bool>[true, false];

  void toast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 15.0);
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return Stack(
        children: [
          Scaffold(
              resizeToAvoidBottomInset: false,
              body: SingleChildScrollView(
                  child: SafeArea(
                child: Container(
                    height: 100.h,
                    color: Color(0xFF022136),
                    child: ListView(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Card(
                              color: Colors.white,
                              elevation: 5,
                              margin: EdgeInsets.zero,
                              clipBehavior: Clip.antiAlias,
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(80),
                                      bottomRight: Radius.circular(80))),
                              child: Column(
                                children: [
                                  SizedBox(
                                    width: double.infinity,
                                    height: 6.h,
                                  ),
                                  Image(
                                    image: AssetImage(
                                        "./lib/assets/images/logo_digesett.png"),
                                    height: 20.h,
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    height: 5.h,
                                  ),
                                  Text(
                                    "Inicio de sesión",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24.sp,
                                        color: Colors.black),
                                  ),
                                  SizedBox(
                                    height: 1.75.h,
                                  ),
                                  Padding(
                                      padding: EdgeInsets.only(
                                          left: 10.w, right: 10.w),
                                      child: Text(
                                        "Utilice sus credenciales para iniciar sesión en su cuenta",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 12.5.sp,
                                            color: Colors.black54),
                                      )),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Padding(
                                      padding: EdgeInsets.only(
                                          left: 10.w, right: 10.w),
                                      child: TextField(
                                        controller: userIdController,
                                        decoration: InputDecoration(
                                          isDense: true,
                                          labelText: 'Nombre de usuario',
                                          labelStyle: const TextStyle(
                                              color: Colors.black),
                                          prefixIcon:
                                              const Icon(Icons.mail_outline),
                                          prefixIconColor: '#3ba33d'.toColor(),
                                          enabledBorder:
                                              const OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 1.0,
                                                color: Colors.black45),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 1.0,
                                                color: '#00004d'.toColor()),
                                          ),
                                        ),
                                      )),
                                  SizedBox(
                                    height: 2.5.h,
                                  ),
                                  Padding(
                                      padding: EdgeInsets.only(
                                          left: 10.w, right: 10.w),
                                      child: TextFormField(
                                        controller: passwordController,
                                        decoration: InputDecoration(
                                          isDense: true,
                                          labelText: 'Contraseña',
                                          labelStyle:
                                              TextStyle(color: Colors.black),
                                          prefixIcon: Icon(Icons.lock),
                                          prefixIconColor: '#3ba33d'.toColor(),
                                          suffixIcon: IconButton(
                                            icon: Icon(_obscureText
                                                ? Icons.visibility
                                                : Icons.visibility_off),
                                            onPressed: () {
                                              setState(
                                                () {
                                                  _obscureText = !_obscureText;
                                                },
                                              );
                                            },
                                          ),
                                          alignLabelWithHint: false,
                                          filled: false,
                                          enabledBorder:
                                              const OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 1.0,
                                                color: Colors
                                                    .black45), //<-- SEE HERE
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            //<-- SEE HERE
                                            borderSide: BorderSide(
                                                width: 1.0,
                                                color: '#00004d'.toColor()),
                                          ),
                                        ),
                                        obscureText: _obscureText,
                                      )),
                                  SizedBox(
                                    height: 2.5.h,
                                  ),
                                  SizedBox(
                                      width: double.infinity,
                                      child: Padding(
                                          padding:
                                              EdgeInsets.only(right: 9.5.w),
                                          child: GestureDetector(
                                            onTap: () {
                                              // Navigator.push(
                                              //     context,
                                              //     MaterialPageRoute(
                                              //         builder: (context) =>
                                              //             const ResetPassPage()));
                                            },
                                            child: Text(
                                              "Olvidaste tu contraseña?",
                                              textAlign: TextAlign.end,
                                              style: TextStyle(
                                                  fontSize: 11.5.sp,
                                                  color: '#3ba33d'.toColor()),
                                            ),
                                          ))),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  SizedBox(
                                    height: 4.h,
                                  ),
                                ],
                              )),
                          SizedBox(
                            height: 5.h,
                          ),
                          Padding(
                              padding: EdgeInsets.only(left: 28.w, right: 28.w),
                              child: InkWell(
                                onTap: () {},
                                child: GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        color: '#3ba33d'.toColor(),
                                      ),
                                      child: Center(
                                        child: Padding(
                                            padding: EdgeInsets.only(
                                                top: 2.h,
                                                bottom: 2.h,
                                                left: 3.w,
                                                right: 3.w),
                                            child: Text('Acceder',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 13.sp,
                                                    fontWeight:
                                                        FontWeight.bold))),
                                      ),
                                    )),
                              )),
                          SizedBox(
                            height: 26.h,
                          ),
                        ])),
              ))),
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      );
    });
  }
}
