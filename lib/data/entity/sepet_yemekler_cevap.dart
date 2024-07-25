import 'package:bitirme_projesi/data/entity/sepet_yemekler.dart';

class SepetYemekCevap{

  List<SepetYemekler> sepetYemekler;
  int success;


SepetYemekCevap({required this.sepetYemekler,required this.success});

  factory SepetYemekCevap.fromJson(Map<String, dynamic> json) {
    if (json["sepet_yemekler"] != null) {
      var jsonArray = json["sepet_yemekler"] as List<dynamic>;
      var sepetYemekler = jsonArray.map((jsonArrayListesi) => SepetYemekler.fromJson(jsonArrayListesi)).toList();

      return SepetYemekCevap(
        sepetYemekler: sepetYemekler,
        success: json["success"] as int,
      );
    } else {
      // Eğer sepet_yemekler alanı null ise veya veri yoksa boş bir listeyi dönüyoruz.
      return SepetYemekCevap(
        sepetYemekler: [],
        success: json["success"] as int,
      );
    }
  }


}