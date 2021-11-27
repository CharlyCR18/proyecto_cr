import 'package:flutter/material.dart';

class CardIcons extends StatelessWidget {
  const CardIcons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 25,
      child: SizedBox(
        width: 300,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Icon(Icons.favorite_border_outlined, size: 35,),
            Icon(Icons.shopping_cart_outlined, size: 35,)
          ],
        ),
      ),
    );
  }
}