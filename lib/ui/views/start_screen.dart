import 'package:bitirme_projesi/ui/views/router_page.dart';
import 'package:flutter/material.dart';
import 'package:gif/gif.dart';
import 'package:lottie/lottie.dart';

import '../Constants/renkler.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(80.0),
                child: Container(
                    child: Image.asset("assets/cart.png"),
                width: 200,
                  height: 200,
                ),
              ),


             const  Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: Text("Grab a Bag of Delicious Fun!",
                    style: TextStyle(color: Colors.grey,
                    fontWeight: FontWeight.bold,fontSize: 16)),

              ), const Text("Get a Mouthful of This!",
                  style: TextStyle(color: Colors.grey,
                      fontWeight: FontWeight.bold,fontSize: 15)),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: const SizedBox(height: 48),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: GestureDetector(
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) =>  RouterPage())),
                  child: Container(
                    decoration: BoxDecoration(
                      color: TColor.primary,
                      borderRadius: BorderRadius.circular(12),
                    ),child: const Padding(
                      padding:  EdgeInsets.all(30.0),
                      child: Center(
                      child: Text("Shop Now",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16),),

                                  ),
                    ),


                  ),
                ),
              ),

            ],

          ),
        ),
      ),

    );

  }
}
