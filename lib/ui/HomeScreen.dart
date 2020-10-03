import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:wisata/database_service/database_services.dart';
import 'package:wisata/models/WisataModel.dart';
import 'package:wisata/ui/FormUpdateDataScreen.dart';
import 'package:wisata/ui/ResideDrawer.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<WisataModel> items;
  DatabaseServices services = new DatabaseServices();
  StreamSubscription<QuerySnapshot> wisata;
  static const snackBarDuration = Duration(seconds: 3);
  final scaffoldKey = GlobalKey<ScaffoldState>();

  DateTime backButtonPressTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: WillPopScope(
          onWillPop: onWillPop,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: Container(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height - 100,
                          child: ListView.builder(
                              itemCount: items.length,
                              itemBuilder: (context, index) {
                                return Column(children: <Widget>[
                                  Center(
                                    child: Padding(
                                      padding:
                                          EdgeInsets.only(left: 8.0, right: 8.0),
                                      child: Container(
                                        width: MediaQuery.of(context).size.width,
                                        height: 400.0,
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              top: 8.0, bottom: 8.0),
                                          child: Material(
                                            color: Colors.white,
                                            elevation: 14.0,
                                            shadowColor: Color(0x802196F3),
                                            child: Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Column(
                                                children: <Widget>[
//                                      todoType('${items[index].tasktype}'),
                                                  Image.network(
                                                    '${items[index].photo}',
                                                    width: double.infinity,
                                                    height: 200,
                                                    fit: BoxFit.fill,
                                                  ),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  //widget nama
                                                  Container(
                                                      width: double.infinity,
                                                      child: Row(
                                                        children: <Widget>[
                                                          Text(
                                                            '${items[index].nama}',
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.black,
                                                                fontSize: 18.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ],
                                                      )),

                                                  //widget Alamat
                                                  Container(
                                                      width: double.infinity,
                                                      child: Row(
                                                        children: <Widget>[
                                                          Flexible(
                                                            child: Text(
                                                              '${items[index].alamat}',
                                                              style: TextStyle(
                                                                color:
                                                                    Colors.black,
                                                                fontSize: 15.0,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      )),

                                                  new InkWell(
                                                    onTap: () {
                                                      Navigator
                                                          .push(
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
                                                        width: double.infinity,
                                                        child: Row(
                                                          children: <Widget>[
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: CircleAvatar(
                                                                backgroundColor:
                                                                    Colors.green,
                                                                radius: 20,
                                                                child: Icon(
                                                                  Icons
                                                                      .location_on,
                                                                  color: Colors
                                                                      .white,
                                                                  size: 30,
                                                                ),
                                                              ),
                                                            ),
                                                            new InkWell(
                                                              onTap: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .push(
                                                                        new MaterialPageRoute(
                                                                  builder: (BuildContext
                                                                          context) =>
                                                                      new ResideDrawer(
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
                                                                    deskripsi: items[
                                                                            index]
                                                                        .deskripsi,
                                                                    posisi: "3",
                                                                    tiitle:
                                                                        "Ubah Data",
                                                                  ),
                                                                ));
                                                              },
                                                              child: Container(
                                                                child:
                                                                    CircleAvatar(
                                                                  backgroundColor:
                                                                      Colors.green,
                                                                  radius: 20,
                                                                  child: Icon(
                                                                    Icons.edit,
                                                                    color: Colors
                                                                        .white,
                                                                    size: 30,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            InkWell(
                                                              onTap: () {
                                                                alert(items[index]
                                                                    .id);
                                                              },
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(8.0),
                                                                child: Container(
                                                                  child:
                                                                      CircleAvatar(
                                                                    backgroundColor:
                                                                        Colors.green,
                                                                    radius: 20,
                                                                    child: Icon(
                                                                      Icons
                                                                          .restore_from_trash,
                                                                      color: Colors
                                                                          .white,
                                                                      size: 30,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        )),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ]);
                              }),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    items = new List();

    wisata?.cancel();
    wisata = services.getAlData().listen((QuerySnapshot snapshot) {
      final List<WisataModel> wisata = snapshot.documents
          .map((documentSnapshot) => WisataModel.fromMap(documentSnapshot.data))
          .toList();

      setState(() {
        this.items = wisata;
      });
    });
  }

  void alert(String data) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: new Text("yakin Menghapus data ini?"),
            actions: <Widget>[
              new RaisedButton(
                  child: new Text(
                    'Iya',
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.red,
                  onPressed: () {
                    // ignore: unnecessary_statements
                    services.delete(data).then((_) {
                      Navigator.pop(context);
                      Toast.show("Berhasil menghapus data", context,
                          duration: 5, gravity: Toast.BOTTOM);
                    });
                  }),
              FlatButton(
                  child: new Text(
                    'Batalkan',
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.blue,
                  onPressed: () {
                    Navigator.pop(context);
                  }),
            ],
          );
        });
  }


  final snackBar = SnackBar(
    content: Text('Tap Satu lagi untuk keluar dari aplikasi'),
    duration: snackBarDuration,
  );


  Future<bool> onWillPop() async {
    DateTime currentTime = DateTime.now();

    bool backButtonHasNotBeenPressedOrSnackBarHasBeenClosed =
        backButtonPressTime == null ||
            currentTime.difference(backButtonPressTime) > snackBarDuration;

    if (backButtonHasNotBeenPressedOrSnackBarHasBeenClosed) {
      backButtonPressTime = currentTime;
      scaffoldKey.currentState.showSnackBar(snackBar);
      return false;
    }

    return true;
  }
}
