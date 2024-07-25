import 'package:bitirme_projesi/data/entity/yemekler.dart';

class YemeklerCevap{

  List<Yemekler> yemekler;
  int success;

  YemeklerCevap({required this.yemekler,required this.success});

  factory YemeklerCevap.fromJson(Map<String,dynamic> json) {
    var jsonArray =json["yemekler"] as List;
    var yemekler =jsonArray.map((jsonArrayListesi) => Yemekler.fromJson(jsonArrayListesi)).toList();

    return YemeklerCevap(
      yemekler: yemekler,
      success: json["success"] as int,
    );

  }
}