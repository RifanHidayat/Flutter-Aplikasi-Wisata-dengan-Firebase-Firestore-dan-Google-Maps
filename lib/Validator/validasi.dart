import 'package:flutter/cupertino.dart';
import 'package:toast/toast.dart';
import 'package:wisata/database_service/database_services.dart';

class Validasi{
  valdasi_pengiriman(BuildContext context,double lat,double long,String nama,String alamat,String deskripsi,String photo){
    DatabaseServices services = new DatabaseServices();
    if (nama.isEmpty){
      Toast.show("Nama wisata tidak boleh kosong", context,
          duration: 5, gravity: Toast.BOTTOM);
    }else if (alamat.isEmpty){
      Toast.show("Alamat tempat wisata tidak boleh kosong", context,
          duration: 5, gravity: Toast.BOTTOM);
    }else if (deskripsi.isEmpty){
      Toast.show("Deskripsi tempat wisata belum diisi", context,
          duration: 5, gravity: Toast.BOTTOM);
    }else if(photo.isEmpty){
      Toast.show("photo belum dipilih", context,
          duration: 5, gravity: Toast.BOTTOM);
    }else{
      services.tambahDataWisata(nama,lat, long, alamat, photo, deskripsi).then((_){
        Toast.show("Data berhasil dikirim", context,
            duration: 5, gravity: Toast.BOTTOM);
      });


    }

  }
}