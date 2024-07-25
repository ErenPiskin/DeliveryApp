import 'dart:convert';

import 'package:bitirme_projesi/data/entity/sepet_yemekler.dart';
import 'package:bitirme_projesi/data/entity/sepet_yemekler_cevap.dart';

import 'package:dio/dio.dart';


class SepetYemeklerDaoRepository{


  List<SepetYemekler> parseSepetYemekler(String cevap){
    try {
      var jsonCevap = json.decode(cevap);
      if (jsonCevap['sepet_yemekler'] == null) {
        return [];
      }
      return SepetYemekCevap.fromJson(jsonCevap).sepetYemekler;
    } catch (e) {
      print("Hata: $e");
      return [];
    }
  }

  Future<List<SepetYemekler>> SepetYemekleriYukle(String kullanici_adi) async
  {
    try {
      var url = "http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php";
      var veri = {
        "kullanici_adi": kullanici_adi,
      };
      var cevap = await Dio().post(url, data: FormData.fromMap(veri));

      // Cevapın kontrolü
      if (cevap.statusCode == 200) {
        // Cevap 200 OK ise işleme devam ediyoruz
        var jsonString = cevap.data.toString();
        if (jsonString.isNotEmpty) {
          // Cevap boş değilse, veriyi işleyerek dönüştürüyoruz
          return parseSepetYemekler(jsonString);
        } else {
          // Cevap boş ise boş bir liste döndürüyoruz
          return [];
        }
      } else {
        // Hata durumunda isteğin durumunu konsola yazdırabiliriz
        print("Hata: ${cevap.statusCode}");
        throw Exception("Sepet yüklenirken bir hata oluştu. Status code: ${cevap.statusCode}");
      }
    } catch (e) {
      print("Hata: $e");
      throw Exception("Sepet yüklenirken bir hata oluştu: $e");
    }


  }
  Future<void> sil(String sepet_yemek_id,String kullanici_adi) async {
    var url = "http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php";
    var veri = {
      "sepet_yemek_id" :sepet_yemek_id,
      "kullanici_adi":kullanici_adi,
    };
    var cevap = await Dio().post(url, data: FormData.fromMap(veri));
    print("sepette Ürün sil : ${cevap.data.toString()}");

  }
}