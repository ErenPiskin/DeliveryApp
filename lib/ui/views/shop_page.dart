import 'package:bitirme_projesi/data/entity/yemekler.dart';
import 'package:bitirme_projesi/ui/Constants/renkler.dart';
import 'package:bitirme_projesi/ui/cubit/detaysayfa_cubit.dart';
import 'package:bitirme_projesi/ui/cubit/sepet_sayfa_cubit.dart';
import 'package:bitirme_projesi/ui/cubit/shop_cubit.dart';
import 'package:bitirme_projesi/ui/views/detay_sayfa.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/entity/sepet_yemekler.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}
class _ShopPageState extends State<ShopPage> {
  bool _isSelected = true;
  int gridview = 2;




  @override
  void initState() {
    super.initState();
    context.read<ShopCubit>().YemekleriYukle();

  }


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,

      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [

          Padding(
            padding: const EdgeInsets.only(top: 50.0),
            child: Container(
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.grey[200]),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Search"),
                  Icon(Icons.search),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 15.0,top: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,

              children: [
                //TODO:filtreleme butonlarını yap

                Container(
                  width: 35,
                  height: 35,
                  child: IconButton(
                    onPressed: (){
                      setState(() {
                        _isSelected = !_isSelected;
                        gridview=2;
                      });


                    },   icon: Image.asset(
                    _isSelected ? 'assets/grid_2_aktif.png' : 'assets/grid_2_pasif.png',
                  ),
                  ),
                ),
                Container(
                  width: 50,
                  height: 50,
                  child: IconButton(
                    onPressed: (){
                      setState(() {
                        _isSelected = !_isSelected;
                        gridview=3;
                      });
                    }, icon: Image.asset(_isSelected ? 'assets/grid_3_pasif.png' : 'assets/grid_3_aktif.png'),),
                ),
              ],
            ),
          ),

          BlocBuilder<ShopCubit,List<Yemekler>>(
              builder: (context,yemeklerListesi){
                if(yemeklerListesi.isNotEmpty){
                  return GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: yemeklerListesi.length,
                      gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: gridview
                          ,childAspectRatio: _isSelected ? 1/1.1 : 1.1/1.8
                      ),
                      itemBuilder: (context,indeks){
                        var yemek = yemeklerListesi[indeks];
                        return GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) =>  DetaySayfa(yemek: SepetYemekler.fromYemekler(yemek))));
                          },
                          child:  Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Container(
                              margin: EdgeInsets.only(left: 12,right:12),
                              width:20,
                              height: 20,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                                color: Colors.grey[100],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                                children: [
                                  Image.network(
                                    width: 160,
                                    height: _isSelected ? 120 : 130,
                                    fit: BoxFit.cover,
                                    'http://kasimadalan.pe.hu/yemekler/resimler/${yemek.yemek_resim_adi}',
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      child: Text("${yemek.yemek_adi}",style: TextStyle(fontSize: _isSelected ? 18 : 15,
                                          fontWeight: FontWeight.bold,color: TColor.primaryText),),),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text("₺ ${yemek.yemek_fiyat}",style: TextStyle(fontSize: _isSelected ? 18 : 15,fontWeight: FontWeight.bold,color: TColor.primaryText),)),
                                  ),
                                  Padding(
                                    padding:  EdgeInsets.only(bottom: 4.0,left: 8,right: 8),
                                    child: Container(
                                      width: 160,
                                      height: 30,
                                      child: FloatingActionButton(
                                        heroTag: null,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(3.0),),
                                        backgroundColor: TColor.primary,
                                        onPressed: () {
                                          setState(() {
                                            Navigator.push(context, MaterialPageRoute(builder: (context) =>  DetaySayfa(yemek: SepetYemekler.fromYemekler(yemek))));
                                          });
                                        },
                                        child:Text("Add to Cart",style: TextStyle(color: Colors.white),),),
                                    ),
                                  ),


                                ],
                              ),


                            ),
                          ),

                        );


                      }
                  );
                }else{
                  return  const Center(
                  );

                }
              }


          ),


        ],




      ),
    );
  }
}