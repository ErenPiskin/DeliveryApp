import 'package:bitirme_projesi/ui/cubit/sepet_sayfa_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/entity/sepet_yemekler.dart';
import '../../data/repo/sepet_yemek_ekle_dao_repository.dart';
import '../../data/repo/sepet_yemeklerdao_repository.dart';



class DetaySayfaCubit extends Cubit<void>{
  DetaySayfaCubit():super(0);

  var syrepo = SepetYemeklerDaoRepository();
  var syerepo = SepetYemekEkleDaoRepository();


  Future<void> SepetYemekEkle(String yemek_adi,String yemek_resim_adi,String yemek_fiyat,int yemek_siparis_adet,String kullanici_adi) async {
    await syerepo.ekle(
        yemek_adi,
        yemek_resim_adi,
        yemek_fiyat,
        yemek_siparis_adet,
        kullanici_adi
    );
  }

  Future<void> SepetTekrarEkleme(List<SepetYemekler> sepetyemekler, SepetYemekler yemek, int amount) async {
    bool isimVarMi = false;
    SepetSayfaCubit? s;
    for (var i in sepetyemekler) {
      if (i.yemek_adi == yemek.yemek_adi) {
        isimVarMi = true;
        break;
      }
    }

    if (isimVarMi) {
      await s!.sil(yemek.sepet_yemek_id, yemek.kullanici_adi);
      SepetYemekEkle(
        yemek.yemek_adi,
        yemek.yemek_resim_adi,
        (int.parse(yemek.yemek_fiyat) * amount).toString(),
        amount,
        yemek.kullanici_adi,
      );
    } else {
      SepetYemekEkle(
        yemek.yemek_adi,
        yemek.yemek_resim_adi,
        (int.parse(yemek.yemek_fiyat) * amount).toString(),
        amount,
        yemek.kullanici_adi,
      );
    }
  }
  Future<int> siparisMiktariAl() async {
    int amount=1;
    return amount;
  }

}