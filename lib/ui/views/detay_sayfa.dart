import 'package:bitirme_projesi/data/entity/sepet_yemekler.dart';
import 'package:bitirme_projesi/data/entity/yemekler.dart';
import 'package:bitirme_projesi/ui/Constants/renkler.dart';
import 'package:bitirme_projesi/ui/cubit/detaysayfa_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/sepet_sayfa_cubit.dart';



class DetaySayfa extends StatefulWidget {
   SepetYemekler yemek;

  DetaySayfa({required this.yemek});

  @override
  State<DetaySayfa> createState() => _DetaySayfaState();
}

class _DetaySayfaState extends State<DetaySayfa> {
  int totalPrice = 0;
  int amount = 1;

  DetaySayfaCubit detaySayfaCubit = DetaySayfaCubit();

  late List<SepetYemekler> sepetyemekler = [];
  late SepetSayfaCubit sepetSayfaCubit;





  @override
  void initState() {
    super.initState();
    detaySayfaCubit = context.read<DetaySayfaCubit>();
    sepetSayfaCubit = context.read<SepetSayfaCubit>();
    getSiparisMiktari();
  }

  Future<void> getSiparisMiktari() async {
    int siparisAmount = await detaySayfaCubit.siparisMiktariAl();
    setState(() {
      amount = siparisAmount;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( centerTitle: true, title: Text("Ürün Detayı"),
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: (){
              setState(() {
                Icon(Icons.favorite,color: Colors.pink);
              });

          }, icon: Icon(Icons.favorite,color: TColor.darkGray),
            )
        ],


      ),
      body: Center(
      child:  Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,


        children: [
          Image.network( 'http://kasimadalan.pe.hu/yemekler/resimler/${widget.yemek.yemek_resim_adi}',
            height: 350,
            width: 350,
            fit: BoxFit.contain,
          ),
          Text("₺ ${widget.yemek.yemek_fiyat}",style: TextStyle(fontSize: 32,color: TColor.primary,fontWeight: FontWeight.w900),),
          Text("${widget.yemek.yemek_adi}",style: TextStyle(fontSize: 32,color: TColor.primaryText,fontWeight: FontWeight.w900),),

          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
               Padding(
                 padding: const EdgeInsets.only(left: 45.0,right: 40.0,),
                 child: InkWell(
                   onTap: (){
                     setState(() {
                       if(amount != 1){
                         amount--;
                       }
                     });
                   },
                   child: Container(
                     alignment: Alignment.center,
                     width: 45,
                     height: 45,
                     decoration: BoxDecoration(
                         border: Border.all(
                           color: TColor.placeholder.withOpacity(0.5),
                           width: 1,
                         ),
                       color: TColor.primary,
                       borderRadius: BorderRadius.circular(12)
                     ),
                     child: Image.asset(
                       "assets/subtack.png",
                       width: 20,
                       height: 20,
                       color: Colors.white,
                     )
                   ),
                 ),
               ),
                Text("$amount"),
                Padding(
                  padding: const EdgeInsets.only(left: 45.0,right: 40.0,),
                  child: InkWell(
                    onTap: (){
                      setState(() {
                        amount++;

                      });
                    },
                    child: Container(
                        alignment: Alignment.center,
                        width: 45,
                        height: 45,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: TColor.placeholder.withOpacity(0.5),
                              width: 1,
                            ),
                            color: TColor.primary,
                            borderRadius: BorderRadius.circular(12)
                        ),
                        child: Image.asset(
                          "assets/add_green.png",
                          width: 20,
                          height: 20,
                          color: Colors.white,
                        )
                    ),
                  ),
                ),

              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(80.0),
                        color: Colors.grey[500]),
                    child:  Text("25-35 dk",style: TextStyle(fontSize: 15,color: Colors.grey[800],fontWeight: FontWeight.w600),)),
              Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(80.0),
                        color: Colors.grey[500]),
                    child:  Text("25-35 dk",style: TextStyle(fontSize: 15,color: Colors.grey[800],fontWeight: FontWeight.w600),)),
              Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(80.0),
                        color: Colors.grey[500]),
                    child:  Text("25-35 dk",style: TextStyle(fontSize: 15,color: Colors.grey[800],fontWeight: FontWeight.w600),)),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 50.0),
                child: Text("₺${totalPrice=(int.parse(widget.yemek.yemek_fiyat)*amount)}",style: TextStyle(fontSize: 28,fontWeight: FontWeight.w600,color: TColor.primaryText),),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  alignment: Alignment.bottomRight,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                      context.read<DetaySayfaCubit>().SepetTekrarEkleme(sepetyemekler, widget.yemek,amount);
                      });

                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(22),),
                      elevation: 0.1,
                      foregroundColor: Colors.white,
                      backgroundColor: TColor.primary,
                    ),
                    child: const Padding(
                      padding:
                      EdgeInsets.symmetric(horizontal: 35.0, vertical: 22.0),

                      child: Text("Add To Cart"),

                    ),
                  ),
                ),
              ),

            ],
          )


        ],


      ),
      ),

    );

  }


}
