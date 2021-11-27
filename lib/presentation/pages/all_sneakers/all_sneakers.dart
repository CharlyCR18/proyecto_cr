import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:nike_store/data/models/shoes.dart';
import 'package:nike_store/presentation/pages/all_sneakers/widgets/shoe_card.dart';

class AllSneakers extends StatelessWidget {
  const AllSneakers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          //const SizedBox(height: 50,),
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(top: 20, bottom: 20),
            child: Image.asset(
              "assets/images/nike_logo.png",
              height: 60,
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                ShoeCard(shoe: nikeShoes[0]),
                ShoeCard(shoe: nikeShoes[1]),
                ShoeCard(shoe: nikeShoes[2]),
                ShoeCard(shoe: nikeShoes[3]),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
