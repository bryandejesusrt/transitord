import 'package:flutter/material.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

const MAPBOX_API_KEY =
    'pk.eyJ1IjoiYnJ5YW4tcnQxNSIsImEiOiJjbHB4bjZzdGwwbHNrMmxwZDNrMG80eDhyIn0.hV-wq5oNH8ru7-w7pwri0g';
const MAPBOX_STYLE = 'mapbox://styles/mapbox/streets-v12';
const _myLocation = LatLng(18.4861, -69.9312);

class MapaModal extends StatelessWidget {
  const MapaModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Mapa de Multas'),
        ),
        body: Center(
          child: Container(
            child: const Column(children: [
              Flexible(
                child: FlutterMap(
                  options: MapOptions(
                    initialCenter: _myLocation,
                    initialZoom: 13.0,
                  ),
                  children: [],
                ),
              ),
            ]),
          ),
        ));
  }
}
