import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  //final String? payload;
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
      /*appBar: AppBar(
        title: Text('Perfil'),
      ),*/
      body: Container(child: ElevatedButton(
        onPressed: () {
          
        }, 
        child: Text("Cancelar"),
        ),
      ),
    );
  }
  