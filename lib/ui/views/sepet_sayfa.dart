import 'package:bitirme_projesi/data/entity/yemekler.dart';
import 'package:bitirme_projesi/ui/cubit/sepet_sayfa_cubit.dart';
import 'package:bitirme_projesi/ui/widgets/card_item_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bitirme_projesi/data/entity/sepet_yemekler.dart';

import '../Constants/renkler.dart';
import '../cubit/detaysayfa_cubit.dart';

class SepetSayfa extends StatefulWidget {
  const SepetSayfa({super.key});

  @override
  State<SepetSayfa> createState() => _SepetSayfaState();
}

class _SepetSayfaState extends State<SepetSayfa> {

  DetaySayfaCubit detaySayfaCubit = DetaySayfaCubit();

   int amount=1;
  List<SepetYemekler> sepetyemekler = [];
  SepetSayfaCubit sepetSayfaCubit = SepetSayfaCubit();


  @override
  void initState() {
    super.initState();
    sepetSayfaCubit = context.read<SepetSayfaCubit>();
    setState(() {
      context.read<SepetSayfaCubit>().SepetYemekleriYukle("eren");
    });
   // getTotalPrice();
    getSiparisMiktari();
  }
//TODO: Çalışmıyor düzelt
  /*Future<void> getTotalPrice() async {
    int totalprice = await sepetSayfaCubit.calculateTotalPrice(sepetyemekler);
    setState(() {
      //total = totalprice;
    });
  }*/

  Future<void> getSiparisMiktari() async {
    int siparisAmount = await detaySayfaCubit.siparisMiktariAl();
    setState(() {
      amount = siparisAmount;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.5,
          centerTitle: true,
          title: Text(
            "My Cart",
            style: TextStyle(
                color: TColor.primaryText,
                fontSize: 20,
                fontWeight: FontWeight.w700),
          ),
        ),
      backgroundColor: Colors.white,

      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          BlocBuilder<SepetSayfaCubit, List<SepetYemekler>>(
            builder: (context, sepetYemeklerListesi) {
              if (sepetYemeklerListesi.isNotEmpty) {
                return ListView.separated(
                  itemCount: sepetYemeklerListesi.length,
                  separatorBuilder: (context, index) => const Divider(
                    color: Colors.black26,
                    height: 1,
                  ),
                  itemBuilder: (context, indeks) {
                    var sepetYemek = sepetYemeklerListesi[indeks];
                    return CartItemRow(cObj: sepetYemek);
                  },
                );
              }
              else {
                return const Center(
                    child: Text(
                    "Sepetiniz boş",
                    style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                        ),
                    )
                );
              }
            },

          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: ElevatedButton(
                  onPressed: () {

                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(19),),
                    elevation: 0.1,
                    foregroundColor: Colors.white,
                    backgroundColor: TColor.primary,
                  ),
                  child: const Padding(
                    padding:
                    EdgeInsets.symmetric(horizontal: 120.0, vertical: 22.0),
                    child: Text("Go to Checkout! "),

                  ),
                ),
              ),

            ],
          )

        ],
      ),



    );

  }




}
