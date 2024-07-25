import 'package:bitirme_projesi/data/entity/yemekler.dart';
import 'package:bitirme_projesi/data/repo/yemeklerdao_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopCubit extends Cubit<List<Yemekler>>{
  ShopCubit():super(<Yemekler>[]);

  var yrepo = YemeklerDaoRepository();

  Future<void> YemekleriYukle() async{
    var liste = await yrepo.yemekleriYukle();
    emit(liste);
  }




}