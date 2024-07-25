import 'package:bitirme_projesi/data/entity/sepet_yemekler.dart';

class SepetYemekEkleCevap{

  int success;
  String message;


  SepetYemekEkleCevap({required this.success,required this.message});

  factory SepetYemekEkleCevap.fromJson(Map<String,dynamic> json){
    return SepetYemekEkleCevap(
        success: json["success"] as int,
        message: json["message"] as String,
        );


  }

}