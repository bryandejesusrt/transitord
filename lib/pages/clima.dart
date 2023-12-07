import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:transitord/pages/WeatherModel.dart';
import 'package:transitord/pages/http.dart';

class ClimaScreen extends StatefulWidget {
  const ClimaScreen({Key? key}) : super(key: key);

  @override
  State<ClimaScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<ClimaScreen> {
  Weather client = Weather();
  WeatherModel? data;
  Future<void> getData() async {
    data = await client.getWeather('Santo Domingo, DO');
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.1,
          title: const Text(
            'Clima ',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: FutureBuilder(
          future: getData(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (data == null) {
                return Text('Cargando Data');
              } else {
                return Column(
                  children: [
                    SizedBox(
                        height: 360,
                        width: double.infinity,
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            Image.asset(data!.temp! > 18
                                ? 'lib/assets/images/sun.gif'
                                : 'lib/assets/images/cold.gif'),
                            Text(data!.cityName.toString()),
                          ],
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      '${data!.temp}°',
                      style: const TextStyle(
                          fontSize: 50, fontWeight: FontWeight.bold),
                    ),
                    const Divider(
                      color: Colors.black,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Addition information',
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                const Text(
                                  'Pressure',
                                  style: TextStyle(fontWeight: FontWeight.w300),
                                ),
                                const Spacer(),
                                Text('${data!.pressure}'),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                const Text(
                                  'Feels Like',
                                  style: TextStyle(fontWeight: FontWeight.w300),
                                ),
                                const Spacer(),
                                Text('${data!.feelsLike}'),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              }
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const LinearProgressIndicator();
            }
            return Container();
          },
        ));
  }
}
