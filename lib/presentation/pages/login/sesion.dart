import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:proyecto_cr/presentation/pages/principal/notes_page.dart';
import 'package:proyecto_cr/presentation/pages/principal/principal.dart';

class Sesion extends StatefulWidget {
  Sesion({Key? key}) : super(key: key);

  @override
  _SesionState createState() => _SesionState();
}

class _SesionState extends State<Sesion> {
  String negro = "0xDD000000";
  double ver = 18;
  TextEditingController passwordCtrl = new TextEditingController();
  bool _secureText = true;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
        appBar: AppBar(
          title: Text("Sesion"),
        ),
        body: Container(
          width: double.infinity,
          //decoration: const BoxDecoration(color: Color(0xFF03A9F4),),
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 50),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: ver),
                  child: CircleAvatar(
                    backgroundColor: Colors.grey[400],
                    radius: 50.0,
                    backgroundImage: AssetImage("assets/images/user.png"),
                  ),
                ),

                //NOMBRE DE USUARIO
                Padding(
                  padding: EdgeInsets.symmetric(vertical: ver),
                  child: TextFormField(
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp(r'[a-zA-Z]+|\s'),
                      ),
                    ],
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'please enter some text';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.account_circle_outlined,
                          color: Colors.indigo,
                        ),
                        //icon: Icon(Icons.account_circle_outlined),
                        labelStyle: TextStyle(color: Colors.black),
                        labelText: "Nombre de usuario",
                        hintStyle: TextStyle(color: Colors.black),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide(color: Colors.black, width: 3),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide(color: Colors.white, width: 3),
                        )),
                  ),
                ),

                //CONTRASEÑA
                Padding(
                  padding: EdgeInsets.symmetric(vertical: ver),
                  child: TextFormField(
                    controller: passwordCtrl,
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.security_outlined,
                          color: Colors.red,
                        ),
                        //icon: Icon(Icons.account_circle_outlined),
                        labelStyle: TextStyle(color: Colors.black),
                        labelText: "Contraseña",
                        hintStyle: TextStyle(color: Colors.black),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide(color: Colors.black, width: 3),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide(color: Colors.white, width: 3),
                        )),
                    obscureText: _secureText,
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'please enter some text';
                      }
                      return null;
                    },
                  ),
                ),

                //BOTON
                Padding(
                  padding: EdgeInsets.symmetric(vertical: ver),
                  child: ElevatedButton(
                    onPressed: () {
                      // Validate returns true if the form is valid, or false otherwise.
                      if (_formKey.currentState!.validate()) {
                        // If the form is valid, display a snackbar. In the real world,
                        // you'd often call a server or save the information in a database.
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Processing Data')),
                        );

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Principal()));
                      }
                    },
                    child: const Text('Iniciar Sesion'),
                  ),
                ),
              ],
            ),
              )
            
          ),
        ));
  }
}
