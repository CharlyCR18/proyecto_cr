import 'package:flutter/material.dart';

class ModelNumber extends StatelessWidget {
  final int modelNumber;
  const ModelNumber({Key? key, required this.modelNumber}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 20,
      child: Text(
        modelNumber.toString(),
        style: const TextStyle(
            color: Color(0x10000000),
            fontSize: 180,
            letterSpacing: 2,
            height: .95,
            fontWeight: FontWeight.w800),
      ),
    );
  }
}
