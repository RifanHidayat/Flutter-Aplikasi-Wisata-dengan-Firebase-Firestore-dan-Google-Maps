import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wisata/database_service/database_services.dart';
import 'package:wisata/models/ModelMaps.dart';
import 'package:wisata/models/WisataModel.dart';
import 'package:wisata/ui/ResideDrawer.dart';



class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  List dataMarker = [];
  List<WisataModel> items;
  GoogleMapController _controller;
  DatabaseServices services = new DatabaseServices();

  List<Marker> allMarkers = [];

  PageController _pageController;

  int prevPage;

  @override
  void initState() {
    StreamSubscription<QuerySnapshot> wisata;
    // TODO: implement initState

    super.initState();
    fetchDatabaseList();

    items = new List();

    wisata?.cancel();
    wisata = services.getAlData().listen((QuerySnapshot snapshot) {
      final List<WisataModel> wisata = snapshot.documents
          .map((documentSnapshot) => WisataModel.fromMap(documentSnapshot.data))
          .toList();

      setState(() {
        this.items = wisata;
        print("rifan");
        print(items);
      });
    });
    print("rifan");
    //print(dataMarker[1]['nama']);

    _pageController = PageController(initialPage: 1, viewportFraction: 0.8)
      ..addListener(_onScroll);
  }

  void _onScroll() {
    if (_pageController.page.toInt() != prevPage) {
      prevPage = _pageController.page.toInt();
      moveCamera();
    }
  }

  _coffeeShopList(index) {
    return AnimatedBuilder(
      animation: _pageController,
      builder: (BuildContext context, Widget widget) {
        double value = 1;
        if (_pageController.position.haveDimensions) {
          value = _pageController.page - index;
          value = (1 - (value.abs() * 0.3) + 0.06).clamp(0.0, 1.0);
        }
        return Center(
          child: SizedBox(
            height: Curves.easeInOut.transform(value) * 125.0,
            width: Curves.easeInOut.transform(value) * 350.0,
            child: widget,
          ),
        );
      },
      child: InkWell(
          onTap: () {
            Navigator
                .pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (BuildContext
                  context) =>
                      ResideDrawer(
                        nama: items[
                        index]
                            .nama,
                        alamat: items[
                        index]
                            .alamat,
                        photo: items[
                        index]
                            .photo,
                        id: items[
                        index]
                            .id,
                        deskripsi:
                        items[index]
                            .deskripsi,
                        posisi:
                        "4",
                        tiitle:
                        "Detail Wisata",
                        long: items[
                        index]
                            .long
                            .toString(),
                        lat: items[
                        index]
                            .lat
                            .toString(),
                      )),);

          },
          child: Container(
            child: Stack(children: [
              Center(
                  child: Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 10.0,
                        vertical: 20.0,
                      ),
                      height: 125.0,
                      width: 275.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black54,
                              offset: Offset(0.0, 4.0),
                              blurRadius: 10.0,
                            ),
                          ]),
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.white),
                          child: Row(children: [
                            Container(
                                height: 90.0,
                                width: 90.0,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(10.0),
                                        topLeft: Radius.circular(10.0)),
                                    image: DecorationImage(
                                        image: NetworkImage(items[index].photo),
                                        fit: BoxFit.cover))),
                            SizedBox(width: 5.0),
                            Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    items[index].nama,
                                    style: TextStyle(
                                        fontSize: 12.5,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    items[index].alamat,
                                    style: TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Container(
                                    width: 170.0,
                                    child: Text(
                                      items[index].deskripsi,
                                      style: TextStyle(
                                          fontSize: 11.0,
                                          fontWeight: FontWeight.w300),
                                    ),
                                  )
                                ])
                          ]))))
            ]),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height - 50.0,
          width: MediaQuery.of(context).size.width,
          child: GoogleMap(
            initialCameraPosition:
                CameraPosition(target: LatLng(40.7128, -74.0060), zoom: 12.0),
            markers: Set.from(allMarkers),
            onMapCreated: mapCreated,
          ),
        ),
        Positioned(
          bottom: 20.0,
          child: Container(
            height: 200.0,
            width: MediaQuery.of(context).size.width,
            child: PageView.builder(
              controller: _pageController,
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {
                return _coffeeShopList(index);
              },
            ),
          ),
        )
      ],
    ));
  }

  void mapCreated(controller) {
    setState(() {
      _controller = controller;
    });
  }

  moveCamera() {
    _controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(items[_pageController.page.toInt()].lat,
            items[_pageController.page.toInt()].long),
        zoom: 14.0,
        bearing: 45.0,
        tilt: 45.0)));
  }

  fetchDatabaseList() async {
    dynamic resultant = await DatabaseServices().getFoMapData();

    if (resultant == null) {
      print('Unable to retrieve');
    } else {
      setState(() {
        dataMarker = resultant;

        dataMarker.forEach((element) {
          allMarkers.add(Marker(
              markerId: MarkerId(element['nama']),
              draggable: false,
              infoWindow: InfoWindow(
                  title: element['nama'], snippet: element['deskripsi']),
              position: LatLng(element['lat'], element['long'])));
        });
      });
    }
  }
}
