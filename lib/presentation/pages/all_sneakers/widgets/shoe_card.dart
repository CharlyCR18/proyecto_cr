import 'package:flutter/material.dart';
import 'package:nike_store/data/models/shoes.dart';
import 'package:nike_store/presentation/pages/all_sneakers/widgets/card_icons.dart';
import 'package:nike_store/presentation/pages/all_sneakers/widgets/model_name.dart';
import 'package:nike_store/presentation/pages/all_sneakers/widgets/model_number.dart';
import 'package:nike_store/presentation/pages/all_sneakers/widgets/model_price.dart';
import 'package:nike_store/presentation/pages/all_sneakers/widgets/shoe_image.dart';

class ShoeCard extends StatelessWidget {
  final Shoes shoe;
  const ShoeCard({Key? key, required this.shoe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      alignment: Alignment.topCenter,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        color: Color(shoe.color),
      ),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          ModelNumber(modelNumber: shoe.modelNumber),
          ShoeImage(modelImage: shoe.images.first,),
          ModelName(modelName: shoe.model,),
          ModelPrice(modelPrice: shoe.oldPrice, modelPriceLow: shoe.currentPrice,),
          CardIcons(),
        ],
      ),
    );
  }
}
