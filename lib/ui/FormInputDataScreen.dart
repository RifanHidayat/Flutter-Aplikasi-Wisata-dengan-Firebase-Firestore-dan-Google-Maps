import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:stacked/stacked.dart';
import 'package:toast/toast.dart';
import 'package:uuid/uuid.dart';
import 'package:uuid/uuid_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wisata/Validator/validasi.dart';
import 'package:wisata/database_service/database_services.dart';
import 'package:wisata/models/Location.dart';
import 'package:wisata/style/constants.dart';
import 'package:wisata/ui/ResideDrawer.dart';
import 'package:wisata/ui/root.dart';

class FormInputDataScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xff543B7A),
      ),
      home: FormInputData(),
    );
  }
}

class FormInputData extends StatefulWidget {
  @override
  _FormInputDataScreenState createState() => _FormInputDataScreenState();
}

class _FormInputDataScreenState extends State<FormInputData> {
  DatabaseServices services = new DatabaseServices();
  Validasi validasi = new Validasi();
  static const snackBarDuration = Duration(seconds: 3);
  final scaffoldKey = GlobalKey<ScaffoldState>();

  DateTime backButtonPressTime;

  var datalat, datalong;

  String imageUrl;
  File image;
  String filename;

  BuildContext context;
  Firestore firestore = Firestore.instance;

  var nama = new TextEditingController();
  var alamat = new TextEditingController();
  var deskripsi = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
        viewModelBuilder: () => HomeViewModel(),
        builder: (context, model, child) => Scaffold(
              key: scaffoldKey,
              body: WillPopScope(
                onWillPop: onWillPop,
                child: SingleChildScrollView(
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 30),
                      child: Column(
                        children: <Widget>[
                          _buildNama(),

                          _buildAlamat(),

                          _buildDeskripsi(),

                          SizedBox(
                            height: 40,
                          ),
                          _photo(),

                          SizedBox(
                            height: 20.0,
                          ),

                          SizedBox(
                            height: 10,
                          ),

                          //btn simpan
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 30.0),
                            width: double.infinity,
                            child: RaisedButton(
                              elevation: 5.0,
                              onPressed: () {
                                if (alamat.text.isEmpty){


                                }else{
                                  setState(() {
                                    model.searchLocationLat(alamat.text);
                                    model.searchLocationLong(alamat.text);
                                  });

                                }
                                if (nama.text.isEmpty) {
                                  Toast.show(
                                      "Nama wisata tidak boleh kosong", context,
                                      duration: 5, gravity: Toast.BOTTOM);
                                } else if (alamat.text.isEmpty) {
                                  Toast.show(
                                      "Alamat tempat wisata tidak boleh kosong",
                                      context,
                                      duration: 5,
                                      gravity: Toast.BOTTOM);
                                } else if (deskripsi.text.isEmpty) {
                                  Toast.show(
                                      "Deskripsi tempat wisata belum diisi",
                                      context,
                                      duration: 5,
                                      gravity: Toast.BOTTOM);
                                } else if (image == null) {
                                  Toast.show("photo belum dipilih", context,
                                      duration: 5, gravity: Toast.BOTTOM);
                                } else {
                                  uploadImage();
                                  setState(() {
                                    model.searchLocationLat(alamat.text);
                                    model.searchLocationLong(alamat.text);
                                  });

                                  if ((model.Lat == null) &&
                                      model.Long == null) {
                                    Toast.show(
                                        "Alamat yang dimasukkan tidak valid",
                                        context,
                                        duration: 1,
                                        gravity: Toast.BOTTOM);
                                  } else if (imageUrl == null) {
                                    Toast.show("Gagal upload photo", context,
                                        duration: 1, gravity: Toast.BOTTOM);
                                  } else {
                                    //proses_Pengiriman(context);
                                    setState(() {
                                      datalat = double.parse(model.Lat);
                                      datalong = double.parse(model.Long);
                                    });

                                    services
                                        .tambahDataWisata(
                                            nama.text,
                                            datalat,
                                            datalong,
                                            alamat.text,
                                            imageUrl,
                                            deskripsi.text)
                                        .then((_) {

                                      Toast.show(
                                          "Data berhasil dikirim", context,
                                          duration: 5, gravity: Toast.BOTTOM);

                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                ResideDrawer(
                                                  posisi: "1",
                                                  tiitle: "Home",
                                                )),
                                      );
                                      // Navigator.pop(context);
                                    });
                                  }
                                }
                              },
                              padding: EdgeInsets.all(15.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              color: Colors.white,
                              child: Text(
                                'Simpan Data',
                                style: TextStyle(
                                  color: Color(0xFF527DAA),
                                  letterSpacing: 1.5,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'OpenSans',
                                ),
                              ),
                            ),
                          ),

                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ));
  }

  Widget _photo() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black26,
        borderRadius: new BorderRadius.circular(5.0),
      ),
      width: double.infinity,
      height: 200,
      child: Stack(
        children: <Widget>[
          //Image.file(image, width:double.infinity),
          Container(
              child: image != null
                  ? Image.file(
                      image,
                      width: double.maxFinite,
                      height: 200,
                      fit: BoxFit.fill,
                    )
                  : Text("")),

          InkWell(
            onTap: () {
              getImage();
            },
            child: Center(
              child: Icon(
                Icons.camera_alt,
                size: 50,
                color: Colors.green,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildNama() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          child: TextFormField(
            controller: nama,
            keyboardType: TextInputType.name,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
            decoration: new InputDecoration(
                prefixIcon: Icon(
                  Icons.drive_file_rename_outline,
                  color: Colors.green,
                ),
                hintText: "Masukan nama tempat wisata",
                hintStyle: kHintTextStyleLabel,
                labelText: "Nama",
                labelStyle: kHintTextStyleLabel,
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green),
                    borderRadius: new BorderRadius.circular(5.0)),
                focusedBorder: new OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green[200]),
                    borderRadius: new BorderRadius.circular(5.0))),
          ),
        ),
      ],
    );
  }

  Widget _buildAlamat() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          height: 120.0,
          child: TextFormField(
            maxLines: 2,
            controller: alamat,
            keyboardType: TextInputType.multiline,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
            decoration: new InputDecoration(
                prefixIcon: Icon(
                  Icons.place_outlined,
                  color: Colors.green,
                ),
                hintText: "Masukan Alamat  tempat wisata",
                hintStyle: kHintTextStyleLabel,
                labelText: "Alamat",
                labelStyle: kHintTextStyleLabel,
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green),
                    borderRadius: new BorderRadius.circular(5.0)),
                focusedBorder: new OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green[200]),
                    borderRadius: new BorderRadius.circular(5.0))),
          ),
        ),
      ],
    );
  }

  Widget _buildDeskripsi() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          height: 120.0,
          child: TextFormField(
            maxLines: 15,
            controller: deskripsi,
            keyboardType: TextInputType.multiline,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
            decoration: new InputDecoration(
                prefixIcon: Icon(
                  Icons.description,
                  color: Colors.green,
                ),
                hintText: "Masukkan Deskripsi tempat wisata",
                hintStyle: kHintTextStyleLabel,
                labelText: "Deskripsi",
                labelStyle: kHintTextStyleLabel,
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green),
                    borderRadius: new BorderRadius.circular(5.0)),
                focusedBorder: new OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green[200]),
                    borderRadius: new BorderRadius.circular(5.0))),
          ),
        ),
      ],
    );
  }

  Future getImage() async {
    await Permission.photos.request();

    var PermissionStatus = await Permission.photos.status;
    if (PermissionStatus.isGranted) {
      var selectedImage =
          await ImagePicker.pickImage(source: ImageSource.gallery);
      setState(() {
        image = File(selectedImage.path);
        filename = basename(selectedImage.path);
      });
    } else {
      print('Grant Permissions and try again');
    }
  }

  uploadImage() async {
    var uuid = Uuid();
    if (image != null) {
      var kode_unik = uuid.v4(options: {'rng': UuidUtil.cryptoRNG});
      StorageReference reference =
          FirebaseStorage.instance.ref().child("images/$kode_unik");
      StorageUploadTask uploadTask = reference.putFile(image);
      var downUrl = await (await uploadTask.onComplete).ref.getDownloadURL();
      var url = downUrl.toString();
      setState(() {
        imageUrl = url;
      });
      return "";
    } else {
      Toast.show("photo belum dipilih", context,
          duration: 5, gravity: Toast.BOTTOM);
    }
  }

  void proses_Pengiriman(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              content: Container(
            height: 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text("Loading...."),
                SizedBox(
                  height: 30,
                ),
                CircularProgressIndicator(
                  backgroundColor: Colors.blue[250],
                ),
              ],
            ),
          ));
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
