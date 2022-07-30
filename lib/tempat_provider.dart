import 'package:flutter/cupertino.dart';
import 'package:modul3/tempat.dart';

class TempatProvider with ChangeNotifier {
  List<Tempat> data = [];
  //cari lokasi saat ini di halaman utama
  Tempat getCurrent(int index) {
    return data.elementAt(index);
  }

  void addAllTempat(List<Tempat> list) {
    data = list;
    notifyListeners();
  }

//fungsi ini wat nambah data lokasi
  void addTempat(Tempat tempat) {
    data.add(tempat);
    //fungsi ini dipanggil agar data di provider terupdate
    notifyListeners();
  }

//fungsi ini buat mengupdate data yang diubah
  void updateTempat(int index, Tempat tempat) {
    List<Tempat> temp = [];
    for (var i = 0; i < data.length; i++) {
      if (i == index) {
        temp.add(tempat);
        continue;
      }
      temp.add(data[i]);
    }
    data = temp;
    notifyListeners();
  }

//fungsi ini digunakan untuk menghapus data
  void deleteTempat(int index) {
    data.removeAt(index);
    notifyListeners();
  }
}
