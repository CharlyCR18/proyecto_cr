import 'package:flutter/material.dart';

class ModelPrice extends StatelessWidget {
  final double modelPrice;
  final double modelPriceLow;
  const ModelPrice({Key? key, required this.modelPrice, required this.modelPriceLow}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 20,
      child: Column(
        children: [
          Text(
            modelPrice.toString(),
            style: const TextStyle(
              color: Colors.red,
              fontSize: 18,
              letterSpacing: 1.2,
              decoration: TextDecoration.lineThrough,
            ),
          ),
          SizedBox(height: 7,),
          Text(
            modelPriceLow.toString(),
            style: const TextStyle(
              fontSize: 22,
              letterSpacing: 1.2,
              fontWeight: FontWeight.w900
            ),
          ),
        ],
      ),
    );
  }
}