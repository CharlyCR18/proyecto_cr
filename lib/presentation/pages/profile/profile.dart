import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  final String? payload;
  const Profile({Key? key, required this.payload}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: Text('Perfil'),
      ),
      body: Container(child: Text(payload ?? ''),),
    );
  }