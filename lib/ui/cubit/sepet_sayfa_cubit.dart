
import 'package:bitirme_projesi/data/entity/sepet_yemekler.dart';
import 'package:bitirme_projesi/data/repo/sepet_yemek_ekle_dao_repository.dart';
import 'package:bitirme_projesi/data/repo/sepet_yemeklerdao_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/entity/yemekler.dart';

class SepetSayfaCubit extends Cubit<List<SepetYemekler>>{
  SepetSayfaCubit():super(<SepetYemekler>[]);


  var syrepo = SepetYemeklerDaoRepository();
  var syerepo = SepetYemekEkleDaoRepository();

  Future<void> SepetYemekleriYukle(String kullanici_adi) async{
    var liste = await syrepo.SepetYemekleriYukle(kullanici_adi);
    emit(liste);
  }

  Future<void> sil(String sepet_yemek_id,String kullanici_adi) async{
    var sepetListesi = state.toList(); // Aktif sepet listesini al
    if (sepetListesi.length == 1 && sepetListesi[0].sepet_yemek_id == sepet_yemek_id) {
      emit(<SepetYemekler>[]);
      await syrepo.sil(sepet_yemek_id, kullanici_adi);
    } else {
      await syrepo.sil(sepet_yemek_id, kullanici_adi);
      var updatedList = await syrepo.SepetYemekleriYukle(kullanici_adi);
      emit(updatedList);
    }

  }

  int calculateTotalPrice(List<SepetYemekler> sepetYemekler) {
    int total = 0;
    for (int i = 0; i < sepetYemekler.length; i++) {
        total += int.parse(sepetYemekler[i].yemek_fiyat);
    }
    return total;
  }

  int defaultprice(Yemekler yemekler){
    int defaultprice = int.parse(yemekler.yemek_fiyat);
    return defaultprice;

  }





}