import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:transitord/pages/HoroscopoPage.dart';
import 'package:transitord/pages/WeatherModel.dart';
import 'package:transitord/pages/http.dart';
import 'package:transitord/pages/noticiasDigesettPage.dart';
import 'package:transitord/pages/profileUserPage.dart';
import 'package:transitord/pages/utils/Login.dart';
import 'package:transitord/pages/utils/hexColorsUse.dart';
import 'package:transitord/widgets/DrawerMenu.dart';

class Home extends StatefulWidget {
  static const String routeName = '/home';
  List<Map<String, dynamic>>? noticias;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<Home> {
  List<Map<String, dynamic>>? noticias;

  @override
  void initState() {
    super.initState();
    cargarNoticias();
    fetchDataAgente();
  }

  Future<void> cargarNoticias() async {
    final response = await http.get(
        Uri.parse('https://remolacha.net/wp-json/wp/v2/posts?search=digeset'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      setState(() {
        noticias = data.cast<Map<String, dynamic>>();
      });
    } else {
      throw Exception('Error al cargar las noticias');
    }
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

  Future<void> _refreshNoticias() async {
    await cargarNoticias();
  }

  String _parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    return document.body!.text;
  }

  Weather client = Weather();
  WeatherModel? data;
  Future<void> getData() async {
    data = await client.getWeather('Santo Domingo, DO');
  }

  @override
  Widget build(BuildContext context) {
    // Obtén la hora actual
    DateTime now = DateTime.now();
    String saludo = obtenerSaludo(now.hour);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            Text(
              'Transitord',
              style: const TextStyle(
                color: Color.fromARGB(255, 255, 255, 255),
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            CircleAvatar(
              backgroundColor: Color.fromARGB(255, 160, 204, 184),
              radius: 20,
              child: ClipRRect(
                child: IconButton(
                  icon: const Icon(
                    Icons.supervised_user_circle,
                    color: Color.fromARGB(255, 230, 230, 230),
                    weight: 5,
                  ),
                  onPressed: () async {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ProfilePageUser(),
                    ));
                  },
                ),
              ),
            ),
          ],
        ),
        backgroundColor: '#3ba33d'.toColor(),
        elevation: 10,
        shadowColor: Color.fromARGB(255, 43, 77, 66),
      ),
      drawer: DrawerMenu(),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              color: const Color(0xFF022136),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 4.h,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 12.0, bottom: 10, left: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IconButton(
                          constraints:
                              BoxConstraints(minWidth: 10, minHeight: 10),
                          icon: const CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.blueGrey,
                            backgroundImage: NetworkImage(
                              "https://resources.diariolibre.com/images/imagenes/2014/22/456581-focus-0-0-375-240.jpg",
                            ),
                          ),
                          onPressed: () async {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ProfilePageUser(),
                            ));
                          },
                        ),
                        SizedBox(
                            width:
                                10), // Ajusta el espacio entre la imagen y el texto
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "$saludo",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            SizedBox(height: 1.h),
                            Row(
                              children: [
                                Text(
                                  "$nombre",
                                  style: TextStyle(
                                    color:
                                        const Color.fromARGB(255, 64, 255, 175),
                                    fontSize: 20,
                                  ),
                                ),
                                SizedBox(width: 1.h),
                                Text(
                                  "¿Cómo va tu día?",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              ],
                            ),
                            SizedBox(height: 1.h),
                            Text(
                              "Hoy es ${now.day} de ${obtenerMes(now.month)} del ${now.year}",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  //imagen con estado del clima y al lado la temperatura

                  FutureBuilder(
                    future: getData(),
                    builder: (BuildContext context,
                        AsyncSnapshot<dynamic> snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (data == null) {
                          return Text('Cargando Data');
                        } else {
                          return Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10.0, right: 10),
                                child: Row(
                                  children: [
                                    SizedBox(width: 3.h),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${data!.cityName}",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.normal),
                                        ),
                                        SizedBox(height: 1.h),
                                        Text(
                                          "${data!.temp}",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(height: 1.h),
                                        Text(
                                          "${data!.weatherMain}°",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      height: 150,
                                      width: 40.w,
                                      margin: EdgeInsets.only(left: 5.w),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(25),
                                        child: Image.asset(
                                          data!.temp! > 18
                                              ? 'lib/assets/images/contrast.png'
                                              : 'lib/assets/images/cold.gif',
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        }
                      } else if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const LinearProgressIndicator();
                      }
                      return Container();
                    },
                  ),

                  const Padding(
                    padding: EdgeInsets.all(18.0),
                    child: Text(
                      "Horoscopo",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),

                  //obtener el signo zodiacal y mostrarlo en pantalla con su respectiva imagen en base al mes y dia actual del dispositivo  y debajo una sugerencia en base al signo zodiacal de manera estatica
                  Padding(
                    padding: const EdgeInsets.only(left: 0.0, right: 10),
                    child: Row(
                      children: [
                        Container(
                          height: 80,
                          width: 40.w,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(35),
                            child: Image.asset(
                              'lib/assets/images/balance.png',
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                        ),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${Zodiaco.getSigno(now.month, now.day)}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              SizedBox(height: 1.h),
                              Text(
                                "Tu sugerencia es: ${Zodiaco.getSugerencia(Zodiaco.getSigno(now.month, now.day))}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              SizedBox(height: 1.h),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 1.h),
                  const Padding(
                    padding: EdgeInsets.all(18.0),
                    child: Text(
                      "Noticias",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 34.0, right: 34),
                    child: Row(
                      children: [
                        Text("Hoy",
                            style:
                                TextStyle(color: Colors.white, fontSize: 15)),
                        Spacer(),
                        Text("Transito",
                            style: TextStyle(
                                color: Colors.blueGrey, fontSize: 15)),
                        Spacer(),
                        Text("Politicas",
                            style: TextStyle(
                                color: Colors.blueGrey, fontSize: 15)),
                        Spacer(),
                        Text("Motivacion",
                            style: TextStyle(
                                color: Colors.blueGrey, fontSize: 15)),
                      ],
                    ),
                  ),
                  SizedBox(height: 4.h),
                  SizedBox(
                    height: 100.h,
                    child: Card(
                      color: Colors.grey.shade100,
                      elevation: 5,
                      margin: EdgeInsets.zero,
                      clipBehavior: Clip.antiAlias,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 30,
                          left: 20,
                          right: 20,
                          bottom: 10,
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                SizedBox(width: 2.h),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14),
                                    color: Colors.grey.shade200,
                                  ),
                                  child: Center(
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        top: 1.5.h,
                                        bottom: 1.5.h,
                                        left: 5.w,
                                        right: 5.w,
                                      ),
                                      child: Text(
                                        'Ultimas noticias',
                                        style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 9.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 2.h),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14),
                                    color: Colors.grey.shade200,
                                  ),
                                  child: Center(
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        top: 1.5.h,
                                        bottom: 1.5.h,
                                        left: 5.w,
                                        right: 5.w,
                                      ),
                                      child: Text(
                                        'Popular',
                                        style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 9.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 4.h,
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Container(
                                    height: 470,
                                    width: 85.w,
                                    child: CustomScrollView(
                                      slivers: [
                                        SliverToBoxAdapter(
                                          child: _buildHeader(),
                                        ),
                                        SliverList(
                                          delegate: SliverChildBuilderDelegate(
                                            (context, index) {
                                              final noticia = noticias![index];
                                              final featuredMediaUrl =
                                                  noticia['_links']
                                                          ['wp:featuredmedia']
                                                      [0]['href'];

                                              return SizedBox(
                                                width: 400.0,
                                                child: Card(
                                                  margin:
                                                      const EdgeInsets.all(8.0),
                                                  child: InkWell(
                                                    onTap: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              DetallesNoticiaPage(
                                                            noticia: noticia,
                                                            imageUrl:
                                                                featuredMediaUrl,
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        FutureBuilder(
                                                          future: http.get(
                                                              Uri.parse(
                                                                  featuredMediaUrl)),
                                                          builder: (context,
                                                              snapshot) {
                                                            if (snapshot
                                                                    .connectionState ==
                                                                ConnectionState
                                                                    .waiting) {
                                                              return Container(
                                                                height: 200.0,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8.0),
                                                                  color: Colors
                                                                          .grey[
                                                                      300],
                                                                ),
                                                                child: const Center(
                                                                    child:
                                                                        CircularProgressIndicator()),
                                                              );
                                                            } else if (snapshot
                                                                .hasError) {
                                                              return Container(
                                                                height: 200.0,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8.0),
                                                                  color: Colors
                                                                          .grey[
                                                                      300],
                                                                ),
                                                                child: const Icon(
                                                                    Icons
                                                                        .error),
                                                              );
                                                            } else {
                                                              final Map<String,
                                                                      dynamic>
                                                                  mediaData =
                                                                  jsonDecode(
                                                                      snapshot
                                                                          .data!
                                                                          .body);
                                                              final imageUrl =
                                                                  mediaData[
                                                                      'source_url'];
                                                              return ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8.0),
                                                                child: Image
                                                                    .network(
                                                                  imageUrl,
                                                                  height: 200.0,
                                                                  width: double
                                                                      .infinity,
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ),
                                                              );
                                                            }
                                                          },
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Text(
                                                            noticia['title']?[
                                                                    'rendered'] ??
                                                                '',
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 18.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Text(
                                                            'Fecha: ${noticia['date'] ?? ''}',
                                                            style: TextStyle(
                                                              fontSize: 14.0,
                                                              fontStyle:
                                                                  FontStyle
                                                                      .italic,
                                                              color: Colors
                                                                  .grey[600],
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Text(
                                                            _parseHtmlString(
                                                                noticia['excerpt']
                                                                    ?[
                                                                    'rendered']),
                                                            style:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        16.0),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(0.0),
                                                          child: ElevatedButton(
                                                            onPressed: () {
                                                              Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          DetallesNoticiaPage(
                                                                    noticia:
                                                                        noticia,
                                                                    imageUrl:
                                                                        featuredMediaUrl,
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              elevation: 2,
                                                              primary: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      148,
                                                                      150,
                                                                      193),
                                                            ),
                                                            child: const Text(
                                                              'Visitar',
                                                              style: TextStyle(
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        248,
                                                                        240,
                                                                        255),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                            childCount: noticias!.length,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const Spacer(),
                              ],
                            ),
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
      // body: RefreshIndicator(
      //   onRefresh: _refreshNoticias,
      //   child: ListView.builder(
      //     itemCount: noticias == null ? 0 : noticias!.length,
      //     itemBuilder: (BuildContext context, int index) {
      //       return Noticias(
      //         title: _parseHtmlString(noticias![index]['title']['rendered']),
      //         content:
      //             _parseHtmlString(noticias![index]['content']['rendered']),
      //         image: noticias![index]['jetpack_featured_media_url'],
      //       );
      //     },
      //   ),
      // ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Últimas Noticias de la institución',
            style: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.start,
          ),
          SizedBox(height: 16.0),
          ClipRRect(
            child: const Image(
              image: AssetImage('lib/assets/images/logo_digesett.png'),
              width: 180,
              height: 180,
            ),
          ),
          SizedBox(height: 16.0),
        ],
      ),
    );
  }

  String obtenerSaludo(int hora) {
    if (hora < 12) {
      return 'Buenos días';
    } else if (hora < 18) {
      return 'Buenas tardes';
    } else {
      return 'Buenas noches';
    }
  }

  String obtenerMes(int numeroMes) {
    final meses = [
      'enero',
      'febrero',
      'marzo',
      'abril',
      'mayo',
      'junio',
      'julio',
      'agosto',
      'septiembre',
      'octubre',
      'noviembre',
      'diciembre'
    ];
    return meses[numeroMes - 1];
  }
}
