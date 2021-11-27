import 'package:flutter/material.dart';

class ModelName extends StatelessWidget {
  final String modelName;
  const ModelName({Key? key, required this.modelName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 90,
      child: Text(
        modelName,
        style: const TextStyle(
          fontSize: 16,
          letterSpacing: 1.2,
          wordSpacing: 1.5,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}