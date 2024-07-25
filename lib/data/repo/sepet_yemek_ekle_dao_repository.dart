import 'dart:convert';
import 'package:bitirme_projesi/data/entity/sepet_yemekler.dart';
import 'package:bitirme_projesi/data/repo/sepet_yemeklerdao_repository.dart';
import 'package:dio/dio.dart';
import '../../ui/cubit/detaysayfa_cubit.dart';
import '../../ui/cubit/sepet_sayfa_cubit.dart';
import '../entity/sepet_yemek_ekleme_cevap.dart';
import '../entity/sepet_yemekler_cevap.dart';

class SepetYemekEkleDaoRepository{


  SepetYemeklerDaoRepository yemek = SepetYemeklerDaoRepository();


   String parseSepetYemekCevap(String cevap){
    return SepetYemekEkleCevap.fromJson(json.decode(cevap)).message;
  }

  Future<void> ekle(String yemek_adi,String yemek_resim_adi,String yemek_fiyat,int yemek_siparis_adet,String kullanici_adi) async {
    var url = "http://kasimadalan.pe.hu/yemekler/sepeteYemekEkle.php";
    var veri = {
      "yemek_adi" :yemek_adi,
      "yemek_resim_adi":yemek_resim_adi,
      "yemek_fiyat":yemek_fiyat,
      "yemek_siparis_adet":yemek_siparis_adet,
      "kullanici_adi":kullanici_adi,
    };
    var cevap = await Dio().post(url, data: FormData.fromMap(veri));
    print("Sepete ürün ekle : ${cevap.data.toString()}");
  }


}