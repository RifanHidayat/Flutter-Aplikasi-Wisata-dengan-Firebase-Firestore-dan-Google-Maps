import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wisata/ui/ResideDrawer.dart';

class DetailTempatWisataScreen extends StatefulWidget {
  DetailTempatWisataScreen(
      {this.nama,
      this.alamat,
      this.photo,
      this.deskripsi,
      this.lat,
      this.long,
      this.id});

  final String nama, alamat, photo, id, deskripsi, lat, long;

  @override
  _DetailTempatWisataState createState() => _DetailTempatWisataState();
}

class _DetailTempatWisataState extends State<DetailTempatWisataScreen> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.white,
                      Colors.white,
                      Colors.white,
                      Colors.white,
                    ],
                    stops: [0.1, 0.4, 0.7, 0.9],
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: [
                      Column(
                        children: [
                          Stack(
                            children: <Widget>[
                              Image.network(
                                widget.photo,
                                width: double.infinity,
                                height: 250,
                                fit: BoxFit.fill,
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 150),
                                width: double.maxFinite,
                                height: 100,
                                color: Colors.black26,
                              ),
                              Container(
                                width: double.infinity,
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 170, horizontal: 10),
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        margin: EdgeInsets.only(left: 25),
                                        alignment: Alignment.bottomLeft,
                                        child: Column(
                                          children: <Widget>[
                                            Text(
                                              widget.nama,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Row(
                                          children: <Widget>[
                                            new Icon(
                                              Icons.location_on,
                                              color: Colors.white,
                                              size: 20,
                                            ),
                                            Text(
                                              widget.alamat,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 230, horizontal: 10),
                                child: Container(
                                  width: double.infinity,
                                  child: new Card(
                                    child: new Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Row(
                                        children: <Widget>[
                                          Container(
                                            padding: EdgeInsets.only(left: 20),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                new Text(
                                                  widget.deskripsi,
                                                  style: new TextStyle(
                                                      fontSize: 18.0,
                                                      color: Colors.black),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 320, horizontal: 10),
                                child: Card(
                                  child: Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Column(
                                      children: <Widget>[
                                        Center(
                                          child: SizedBox(
                                            width: 300.0,
                                            height: 300.0,
                                            child: GoogleMap(
                                                initialCameraPosition:
                                                    CameraPosition(
                                                        target: LatLng(double.parse(widget.lat),double.parse(widget.long)),
                                                        zoom: 11.0),
                                                markers:
                                                    Set<Marker>.of(<Marker>[
                                                  Marker(
                                                    markerId: MarkerId(
                                                        "${widget.id}"),
                                                    position: LatLng(
                                                        double.parse(widget.lat),
                                                        double.parse(widget.long)),
                                                    infoWindow: InfoWindow(
                                                        title:
                                                            "${widget.nama}",
                                                        snippet:
                                                            " Alamat: ${widget.alamat}"),
                                                  ),
                                                ]),
                                                gestureRecognizers: <
                                                    Factory<
                                                        OneSequenceGestureRecognizer>>[
                                                  Factory<
                                                      OneSequenceGestureRecognizer>(
                                                    () =>
                                                        ScaleGestureRecognizer(),
                                                  ),
                                                ].toSet()),
                                          ),
                                        ),
                                        _builbtn()
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                            ],
                          ),

                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _builbtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 30.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () {
          Navigator
              .pushReplacement(
            context,
            MaterialPageRoute(
                builder: (BuildContext
                context) =>
                    ResideDrawer(
                      posisi: "5",
                      tiitle: "Lokasi Wisata",
                      lat: widget.lat,
                      long: widget.long,

                    )),);
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: Colors.white,
        child: Text(
          'Lihat Semua Posisi',
          style: TextStyle(
            color: Color(0xFF527DAA),
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }
}
