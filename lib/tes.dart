import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/foundation.dart';
class PageMaps extends StatefulWidget {
  @override
  _PageMapsState createState() => _PageMapsState();
}
class _PageMapsState extends State<PageMaps> {
  final LatLng monas = LatLng(-6.1753924,106.8249587);
  final LatLng udacoding = LatLng(-6.2967286,106.696211);
  final LatLng safari = LatLng(-6.7199119,106.9492224);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title : Text("Maps Flutter"),
      ),
      body: ListView(
        children: <Widget>[
          Card(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 30.0),
              child: Column(
                children: <Widget>[
                  Text("Taman Safari",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.red,
                        fontWeight: FontWeight.bold),
                  ),
                  Center(
                    child: SizedBox(
                      width: 300.0,
                      height: 300.0,
                      child: GoogleMap(
                          initialCameraPosition: CameraPosition(
                              target: safari,
                              zoom: 11.0
                          ),
                          markers:
                          Set<Marker>.of(
                              <Marker>[
                                Marker(
                                  markerId: MarkerId("id_safari"),
                                  position: LatLng(safari.latitude,
                                      safari.longitude),
                                  infoWindow: InfoWindow(
                                      title: "Taman Safari",
                                      snippet: "Rumah Azriel"
                                  ),
                                ),
                              ]
                          ),
                          gestureRecognizers:
                          <Factory<OneSequenceGestureRecognizer>>[
                            Factory<OneSequenceGestureRecognizer>(
                                  () => ScaleGestureRecognizer(),
                            ),
                          ].toSet()
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Card(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 30.0),
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20.0,),
                  Text("Monumen Nasional",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.red,
                        fontWeight: FontWeight.bold),
                  ),
                  Center(
                    child: SizedBox(
                      width: 300.0,
                      height: 300.0,
                      child: GoogleMap(
                          initialCameraPosition: CameraPosition(
                              target: monas,
                              zoom: 11.0
                          ),
                          markers:
                          Set<Marker>.of(
                              <Marker>[
                                Marker(
                                  markerId: MarkerId("id_monas"),
                                  position: LatLng(monas.latitude,
                                      monas.longitude),
                                  infoWindow: InfoWindow(
                                      title: "Monumen Nasional",
                                      snippet: "Pusat Ibu Kota Jakarta"
                                  ),
                                ),
                              ]
                          ),
                          gestureRecognizers:
                          <Factory<OneSequenceGestureRecognizer>>[
                            Factory<OneSequenceGestureRecognizer>(
                                  () => ScaleGestureRecognizer(),
                            ),
                          ].toSet()
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Card(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 30.0),
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20.0,),
                  Text("Udacoding",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.red,
                        fontWeight: FontWeight.bold),
                  ),
                  Center(
                    child: SizedBox(
                      width: 300.0,
                      height: 300.0,
                      child: GoogleMap(
                          initialCameraPosition: CameraPosition(
                              target: udacoding,
                              zoom: 11.0
                          ),
                          markers:
                          Set<Marker>.of(
                              <Marker>[
                                Marker(
                                  markerId: MarkerId("id_udacoding"),
                                  position: LatLng(udacoding.latitude,
                                      udacoding.longitude),
                                  infoWindow: InfoWindow(title: "Udacoding Official", snippet: "Jl.Bougenvile 2 DhayaPesona B2 No.2"
                                  ),
                                ),
                              ]
                          ),
                          gestureRecognizers:
                          <Factory<OneSequenceGestureRecognizer>>[
                            Factory<OneSequenceGestureRecognizer>(
                                  () => ScaleGestureRecognizer(),
                            ),
                          ].toSet()
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
