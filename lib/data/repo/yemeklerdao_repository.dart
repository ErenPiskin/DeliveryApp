import 'dart:convert';

import 'package:bitirme_projesi/data/entity/yemekler.dart';
import 'package:bitirme_projesi/data/entity/yemekler_cevap.dart';
import 'package:dio/dio.dart';

class YemeklerDaoRepository{


  List<Yemekler> parseYemekler(String cevap){
    return YemeklerCevap.fromJson(json.decode(cevap)).yemekler;
  }

  Future<List<Yemekler>> yemekleriYukle() async
  {
    var url = "http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php";
    var cevap = await Dio().get(url);
    return parseYemekler(cevap.data.toString());
  }
}