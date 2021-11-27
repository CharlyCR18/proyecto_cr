import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xFF4392BE),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50.0,
                backgroundImage: AssetImage("assets/images/caroline.png"),
              ),
              Text(
                "Carlos Corrales",
                style: TextStyle(color:  Colors.white, fontSize: 30, fontFamily: "Birthstone"),
                ),
                Text(
                "Desarrollador",
                style: TextStyle(color:  Colors.white, fontSize: 20, fontFamily: "Roboto"),
                ),
                Container(
                  color: Colors.white,
                  width: 250,
                  height: 50,
                  margin: const EdgeInsets.all(10.0),
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(5.0),
                        child: Icon(Icons.phone_outlined, color: Colors.blue),
                      ),
                      Container(
                        padding: const EdgeInsets.all(5.0),
                        child: Text("733 117 4729"),
                      ),
                      
                    ],
                  ),
                  
                ),

                Container(
                  color: Colors.white,
                  width: 250,
                  height: 50,
                  margin: const EdgeInsets.all(10.0),
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(5.0),
                        child: Icon(Icons.mail_outline, color: Colors.blue),
                      ),
                      Container(
                        padding: const EdgeInsets.all(5.0),
                        child: Text("18670275@iguala.tecnm.mx"),
                      ),
                      
                    ],
                  ),
                  
                ),

                Container(
                  color: Colors.white,
                  width: 250,
                  height: 50,
                  margin: const EdgeInsets.all(10.0),
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(5.0),
                        child: Icon(FontAwesomeIcons.twitter, color: Colors.blue),
                      ),
                      Container(
                        padding: const EdgeInsets.all(5.0),
                        child: Text("@Carlos"),
                      ),
                      
                    ],
                  ),
                  
                ),
            ],
          ),
        ),
      ),
    );
  }
}