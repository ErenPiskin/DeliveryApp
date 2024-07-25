import 'package:bitirme_projesi/ui/cubit/detaysayfa_cubit.dart';
import 'package:bitirme_projesi/ui/cubit/sepet_sayfa_cubit.dart';
import 'package:bitirme_projesi/ui/cubit/shop_cubit.dart';
import 'package:bitirme_projesi/ui/views/start_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
        BlocProvider(create: (context) => ShopCubit()),
        BlocProvider(create: (context) => SepetSayfaCubit()),
        BlocProvider(create: (context) => DetaySayfaCubit())
        ],
        child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: StartScreen(),

    ),
    );
  }
}

