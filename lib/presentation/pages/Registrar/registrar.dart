import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:proyecto_cr/presentation/pages/principal/notes_page.dart';
import 'package:proyecto_cr/presentation/pages/principal/principal.dart';

class Registrar extends StatefulWidget {
  Registrar({Key? key}) : super(key: key);

  @override
  _RegistrarState createState() => _RegistrarState();
}

class _RegistrarState extends State<Registrar> {
  @override
  Widget build(BuildContext context) {
    //var maxHeight = MediaQuery.of(context).size.height;
    String name = "";
    String mail = "";
    String phone = "";
    String password = "";
    String VerifyPassword = "";
    final _formKey = GlobalKey<FormState>();
    TextEditingController passwordCtrl = new TextEditingController();
    TextEditingController repeatPassCtrl = new TextEditingController();
    bool secureText = true;
    //Color gris = const Color(0xFFD6D6D6);
    //const blanco = const Color(0xFFFFFFFF);

    return Scaffold(
      //backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Registrarse"),
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            color: Color(0xDD000000),
            //backgroundColor: Color(Colors.black),
          ),
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: CircleAvatar(
                    backgroundColor: Colors.grey[400],
                    radius: 50.0,
                    backgroundImage: AssetImage("assets/images/user.png"),
                  ),
                ),

                SizedBox(
                  height: 20,
                ),
                //NOMBRE
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: TextFormField(
                    style: TextStyle(color: Colors.white),
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
                          color: Colors.blue,
                        ),
                        //icon: Icon(Icons.account_circle_outlined),
                        labelStyle: TextStyle(color: Colors.blue),
                        labelText: "Nombre",
                        hintStyle: TextStyle(color: Colors.white),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide(color: Colors.white, width: 3),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide(color: Colors.blue, width: 3),
                        )),
                  ),
                ),

                //USUARIO
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: TextFormField(
                    style: TextStyle(color: Colors.white),
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
                          color: Colors.blue,
                        ),
                        labelStyle: TextStyle(color: Colors.blue),
                        labelText: "Usuario",
                        hintStyle: TextStyle(color: Colors.white),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide(color: Colors.white, width: 3),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide(color: Colors.blue, width: 3),
                        )),
                  ),
                ),

                //CORREO
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: TextFormField(
                    style: TextStyle(color: Colors.white),
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'please enter some text';
                      }
                      if (!StringAdm.validateEmail(value)) {
                        return 'Ingrese un correo válido';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.mail_outline_outlined,
                          color: Colors.pink[200],
                        ),
                        labelStyle: TextStyle(color: Colors.blue),
                        labelText: "Correo",
                        hintStyle: TextStyle(color: Colors.white),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide(color: Colors.white, width: 3),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide(color: Colors.blue, width: 3),
                        )),
                  ),
                ),

                //TELEFONO
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: TextFormField(
                    style: TextStyle(color: Colors.white),
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    keyboardType: TextInputType.number,
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'please enter some text';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.phone_outlined,
                          color: Colors.green,
                        ),
                        labelStyle: TextStyle(color: Colors.blue),
                        labelText: "Telefono",
                        hintStyle: TextStyle(color: Colors.white),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide(color: Colors.white, width: 3),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide(color: Colors.blue, width: 3),
                        )),
                  ),
                ),

                //CONTRASEÑA
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: TextFormField(
                    style: TextStyle(color: Colors.white),
                    controller: passwordCtrl,
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.security_outlined,
                          color: Colors.red,
                        ),
                        labelStyle: TextStyle(color: Colors.blue),
                        labelText: "Contraseña",
                        hintStyle: TextStyle(color: Colors.white),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide(color: Colors.white, width: 3),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide(color: Colors.blue, width: 3),
                        )),
                    obscureText: secureText,
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'please enter some text';
                      }
                      return null;
                    },
                  ),
                ),

                //VERIFICAR CONTRASEÑA
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: TextFormField(
                    style: TextStyle(color: Colors.white),
                    controller: repeatPassCtrl,
                    obscureText: true,
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'please enter some text';
                      }
                      if (value != passwordCtrl.text) {
                        return "Las contraseñas no coinciden";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.security_outlined,
                          color: Colors.red,
                        ),
                        labelStyle: TextStyle(color: Colors.blue),
                        labelText: "Verificar Contraseña",
                        hintStyle: TextStyle(color: Colors.white),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide(color: Colors.white, width: 3),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide(color: Colors.blue, width: 3),
                        )),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
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
                    child: const Text('Submit'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class StringAdm {
  static bool validateEmail(String email) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern.toString());
    return (!regex.hasMatch(email)) ? false : true;
  }
}
