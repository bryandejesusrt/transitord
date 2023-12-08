import 'package:flutter/material.dart';
import 'package:transitord/widgets/DrawerMenu.dart';

class MultasRegistradas extends StatelessWidget {
  static const String routeName = '/multasregistradas';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MultasRegistradas"),
      ),
      drawer: DrawerMenu(),
      body: Center(
        child: Text(
          'MultasRegistradas Page',
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
