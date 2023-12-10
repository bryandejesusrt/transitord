import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import 'package:transitord/pages/noticiasDigesettPage.dart';

class NoticiasWidget extends StatefulWidget {
  @override
  _NoticiasWidgetState createState() => _NoticiasWidgetState();
}

class _NoticiasWidgetState extends State<NoticiasWidget> {
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
                                _buildFutureBuilder(featuredMediaUrl),
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
                                _buildDateInfo(noticia),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    _parseHtmlString(
                                        noticia['excerpt']?['rendered']),
                                    style: const TextStyle(fontSize: 16.0),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
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

  Widget _buildFutureBuilder(String featuredMediaUrl) {
    return FutureBuilder(
      future: http.get(Uri.parse(featuredMediaUrl)),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildLoadingPlaceholder();
        } else if (snapshot.hasError) {
          return _buildErrorPlaceholder();
        } else {
          final Map<String, dynamic> mediaData =
              jsonDecode(snapshot.data!.body);
          final imageUrl = mediaData['source_url'];
          return _buildImage(imageUrl);
        }
      },
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

  Widget _buildLoadingPlaceholder() {
    return Container(
      height: 200.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.grey[300],
      ),
      child: const Center(child: CircularProgressIndicator()),
    );
  }

  Widget _buildErrorPlaceholder() {
    return Container(
      height: 200.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.grey[300],
      ),
      child: const Icon(Icons.error),
    );
  }

  Widget _buildImage(String imageUrl) {
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

  Widget _buildDateInfo(Map<String, dynamic> noticia) {
    return Column(
      children: [
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
      ],
    );
  }
}
