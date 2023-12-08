import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart';
import 'package:transitord/widgets/DrawerMenu.dart';

class NoticiasPage extends StatefulWidget {
  static const String routeName = '/noticias';
  @override
  _NoticiasPageState createState() => _NoticiasPageState();
}

class _NoticiasPageState extends State<NoticiasPage> {
  List<Map<String, dynamic>>? noticias;

  @override
  void initState() {
    super.initState();
    cargarNoticias();
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

  Future<void> _refreshNoticias() async {
    await cargarNoticias();
  }

  String _parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    return document.body!.text;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Noticias Digeset'),
      ),
      drawer: DrawerMenu(),
      body: noticias == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: _buildHeader(),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final noticia = noticias![index];
                      final featuredMediaUrl =
                          noticia['_links']['wp:featuredmedia'][0]['href'];

                      return SizedBox(
                        width: 400.0,
                        child: Card(
                          margin: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetallesNoticiaPage(
                                    noticia: noticia,
                                    imageUrl: featuredMediaUrl,
                                  ),
                                ),
                              );
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FutureBuilder(
                                  future: http.get(Uri.parse(featuredMediaUrl)),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return Container(
                                        height: 200.0,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          color: Colors.grey[300],
                                        ),
                                        child: const Center(
                                            child: CircularProgressIndicator()),
                                      );
                                    } else if (snapshot.hasError) {
                                      return Container(
                                        height: 200.0,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          color: Colors.grey[300],
                                        ),
                                        child: const Icon(Icons.error),
                                      );
                                    } else {
                                      final Map<String, dynamic> mediaData =
                                          jsonDecode(snapshot.data!.body);
                                      final imageUrl = mediaData['source_url'];
                                      return ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        child: Image.network(
                                          imageUrl,
                                          height: 200.0,
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                        ),
                                      );
                                    }
                                  },
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    noticia['title']?['rendered'] ?? '',
                                    style: const TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Fecha: ${noticia['date'] ?? ''}',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      fontStyle: FontStyle.italic,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    _parseHtmlString(
                                        noticia['excerpt']?['rendered']),
                                    style: const TextStyle(fontSize: 16.0),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(0.0),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              DetallesNoticiaPage(
                                            noticia: noticia,
                                            imageUrl: featuredMediaUrl,
                                          ),
                                        ),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      elevation: 2,
                                      primary:
                                          Color.fromARGB(255, 148, 150, 193),
                                    ),
                                    child: const Text(
                                      'Visitar',
                                      style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 248, 240, 255),
                                        fontWeight: FontWeight.bold,
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
      floatingActionButton: FloatingActionButton(
        onPressed: _refreshNoticias,
        child: const Icon(Icons.refresh),
      ),
    );
  }
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

class DetallesNoticiaPage extends StatelessWidget {
  final Map<String, dynamic> noticia;
  final String imageUrl;

  DetallesNoticiaPage({required this.noticia, required this.imageUrl});

  String _parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    return document.body!.text;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalles de la Noticia'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder(
              future: http.get(Uri.parse(imageUrl)),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container(
                    height: 200.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Colors.grey[300],
                    ),
                    child: const Center(child: CircularProgressIndicator()),
                  );
                } else if (snapshot.hasError) {
                  return Container(
                    height: 200.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Colors.grey[300],
                    ),
                    child: const Icon(Icons.error),
                  );
                } else {
                  final Map<String, dynamic> mediaData =
                      jsonDecode(snapshot.data!.body);
                  final imageUrl = mediaData['source_url'];
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      imageUrl,
                      height: 200.0,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  );
                }
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                noticia['title']?['rendered'] ?? '',
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                _parseHtmlString(noticia['content']?['rendered'] ?? ''),
                style: const TextStyle(fontSize: 16.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  // Lógica para visitar la noticia completa
                },
                style: ElevatedButton.styleFrom(
                  elevation: 2,
                  primary: Color.fromARGB(255, 148, 150, 193),
                ),
                child: const Text(
                  'Visitar',
                  style: TextStyle(
                    color: Color.fromARGB(255, 248, 240, 255),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
