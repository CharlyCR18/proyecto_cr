import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nike_store/presentation/pages/login/login.dart';
import 'package:nike_store/presentation/pages/my_home/my_home.dart';

class OnBoard extends StatelessWidget {
  const OnBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Color(0xFFdaedec),
        ),
        child: Column(children: [
          const SizedBox(
            height: 100,
          ),
          Image.asset(
            "assets/images/nike_logo_lemon.png",
            width: 250,
            height: 250,
          ),
          Text(
            'Whereever you are.',
            style: TextStyle(
              //color: Color(0xFF979797),
              color: Colors.black54,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              letterSpacing: .8,
              height: 1,
            ),
          ),
          Text(
            "Wherever you want to go.",
            style: TextStyle(
                //color: Color(0xFF979797),
                color: Colors.black54,
                fontSize: 16,
                fontWeight: FontWeight.w600,
                letterSpacing: .8,
                height: 1.5),
          ),
          Text(
            "Come run with us.",
            style: TextStyle(
              //color: Color(0xFF979797),
              color: Colors.black54,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              letterSpacing: .8,
              height: 1.5,
            ),
          ),
          SizedBox(
            height: 100,
          ),
          TextButton(
            style: TextButton.styleFrom(minimumSize: Size(300, 5)),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Login()));
            },
            child: Text(
              "LOGIN",
              style: TextStyle(
                color: Colors.black54,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          OutlinedButton(
            onPressed: () {},
            child: Text(
              "JOIN NOW",
              style: TextStyle(
                  color: Colors.black45,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1),
            ),
            style: OutlinedButton.styleFrom(
                primary: Colors.black45,
                backgroundColor: Color(0xFFb3e8e2),
                padding: EdgeInsets.all(25),
                elevation: 7,
                minimumSize: Size(300, 10)),
          ),
        ]),
      ),
    );
  }
}
