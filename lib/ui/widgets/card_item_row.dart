
import 'package:bitirme_projesi/data/entity/sepet_yemekler.dart';
import 'package:bitirme_projesi/data/entity/yemekler.dart';
import 'package:bitirme_projesi/ui/cubit/sepet_sayfa_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Constants/renkler.dart';
import '../cubit/detaysayfa_cubit.dart';

class CartItemRow extends StatefulWidget {
   SepetYemekler cObj;
   CartItemRow({required this.cObj});

  @override
  State<CartItemRow> createState() => _CartItemRowState();
}

class _CartItemRowState extends State<CartItemRow> {

  DetaySayfaCubit detaySayfaCubit = DetaySayfaCubit();
  SepetSayfaCubit sepetSayfaCubit = SepetSayfaCubit();
  late Yemekler yemekler;
  late int total;
  int amount=1;
  late int defaultPrice;



  @override
  void initState() {
    super.initState();
    context.read<SepetSayfaCubit>().SepetYemekleriYukle("eren");
    yemekler = Yemekler(
        yemek_id: widget.cObj.sepet_yemek_id,
        yemek_adi: widget.cObj.yemek_adi,
        yemek_resim_adi: widget.cObj.yemek_resim_adi,
        yemek_fiyat: widget.cObj.yemek_fiyat);
    getSiparisMiktari();
    getDefaultPrice();
  }

  Future<void> getSiparisMiktari() async {
    int siparisAmount = await detaySayfaCubit.siparisMiktariAl();
    setState(() {
      amount = siparisAmount;
    });
  }

  Future<void> getDefaultPrice() async{
    int defaultprice = await sepetSayfaCubit.defaultprice(yemekler);
    setState(() {
      defaultPrice=defaultprice;
    });
  }


  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        height: 150,
        padding: EdgeInsets.symmetric(vertical: 15),
        color: Colors.white,

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Image.network("http://kasimadalan.pe.hu/yemekler/resimler/${widget.cObj.yemek_resim_adi}",
                      width: 110,
                      height: 100,
                      fit:BoxFit.contain,
                    ),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                widget.cObj.yemek_adi,
                                style: TextStyle(
                                    color: TColor.primaryText,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all( 8.0),
                              child: InkWell(
                                onTap:(){
                                  context.read<SepetSayfaCubit>().sil(widget.cObj.sepet_yemek_id, widget.cObj.kullanici_adi);
                                },
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  alignment: Alignment.center,
                                  child: Image.asset(
                                    "assets/trash.png",
                                  ),
                                ),
                              ),
                            ),

                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,

                          children: [

                            Text("Adet: ",style: TextStyle(fontSize: 15,color: TColor.primaryText),),
                            

                            Padding(
                              padding:  EdgeInsets.all(8.0),
                              child: Text(widget.cObj.yemek_siparis_adet,style: TextStyle(fontSize: 15,color: TColor.primaryText) ,),
                            ),

                           const Spacer(),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("₺ ${widget.cObj.yemek_fiyat}",
                                 style: TextStyle(
                                  color: TColor.primaryText,
                                   fontSize: 20,
                                    fontWeight: FontWeight.w600)
                                ),
                            ),


                          ],
                        )
                      ]),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}