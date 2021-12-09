import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_cr/api/notification_api.dart';
import 'package:proyecto_cr/presentation/pages/Registrar/registrar.dart';
import 'package:proyecto_cr/presentation/pages/login/sesion.dart';

class OnBoard extends StatelessWidget {
  const OnBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String negro = "0xFFD6D6D6";
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Color(0xDD000000),
          //backgroundColor: Color(Colors.black),
          
        ),
        child: Column(children: [
          const SizedBox(
            height: 50,
          ),
          Image.asset(
            "assets/images/tclogo.png",
            width: 250,
            height: 250,
          ),
          SizedBox(
            height: 10,
          ),
          //TEXTO BIENVENIDA
          Text(
            '¿Ya tienes una cuenta?',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              letterSpacing: .8,
              height: 1,
            ),
          ),
          //SEPARADOR
          SizedBox(
            height: 10,
          ),
          Text(
            'Inicia Sesion o Registrate',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
              letterSpacing: .8,
              height: 1,
            ),
          ),
          //SEPARADOR
          SizedBox(
            height: 50,
          ),
          //INICIA SESION
          OutlinedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Sesion()));
            },
            child: Text(
              "Inicia Sesion",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1),
            ),
            style: OutlinedButton.styleFrom(
                primary: Colors.black,
                backgroundColor: Color(0xFF2196F3),
                //backgroundColor: Color(Colors.blue),
                padding: EdgeInsets.all(18),
                elevation: 7,
                minimumSize: Size(300, 5)),
          ),
          //SEPARADOR
          SizedBox(
            height: 10,
          ),
          //REGISTRATE
          TextButton(
            style: TextButton.styleFrom(minimumSize: Size(300, 5)),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Registrar()));
            },
            child: Text(
              "Registrarse",
              style: TextStyle(
                decoration: TextDecoration.underline,
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ]),
      ),
    );
  }
}