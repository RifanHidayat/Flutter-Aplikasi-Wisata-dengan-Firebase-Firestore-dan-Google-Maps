import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wisata/models/WisataModel.dart';

final CollectionReference myCollection =
    Firestore.instance.collection('Sekolah');

class DatabaseServices {
  Future<WisataModel> tambahDataWisata(String nama, double lat, double long,
      String alamat, String photo, String deskripsi) async {
    final TransactionHandler createTransaction = (Transaction tx) async {
      final DocumentSnapshot ds = await tx.get(myCollection.document());
      var id = ds.reference.documentID;

      final WisataModel sekolah =
          new WisataModel(nama, lat, long, alamat, photo, deskripsi, id);
      final Map<String, dynamic> data = sekolah.toMap();
      await tx.set(ds.reference, data);
      return data;
    };

    return Firestore.instance.runTransaction(createTransaction).then((mapData) {
      return WisataModel.fromMap(mapData);
    }).catchError((error) {
      print('error: $error');
      return null;
    });
  }

  Stream<QuerySnapshot> getAlData({int offset, int limit}) {
    Stream<QuerySnapshot> snapshots = myCollection.snapshots();

    if (offset != null) {
      snapshots = snapshots.skip(offset);
    }
    if (limit != null) {
      snapshots = snapshots.take(limit);
    }
    return snapshots;
  }

  Future<void> delete(String id) async {
    await myCollection.document(id).delete();
  }

  Future<void> UpdateData(String id,
      {String nama,
      String alamat,
      String photo,
      double lat,
      double long,
      String deskripsi}) async {
    await myCollection.document(id).setData({
      "nama": nama,
      "alamat": alamat,
      "photo": photo,
      "lat": lat,
      "long": long,
      "deskripsi": deskripsi
    }, merge: true);
  }

  Future getFoMapData() async {
    List itemsList = [];

    try {
      await myCollection.getDocuments().then((querySnapshot) {
        querySnapshot.documents.forEach((element) {
          itemsList.add(element.data);
        });
      });
      return itemsList;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
