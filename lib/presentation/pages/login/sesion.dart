import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:proyecto_cr/presentation/pages/db/user_database.dart';
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
  final _conUserName = TextEditingController();
  final passwordCtrl = new TextEditingController();
  bool _secureText = true;
  final _formKey = GlobalKey<FormState>();
  var dbHelper;
  String msj = "Iniciado";

  final snackError = SnackBar(
    content: Text("Error: Revise sus datos"),
    backgroundColor: Colors.red,
  );

  @override
  void initState() {
    super.initState();
    dbHelper = UserDatabase;
  }

  login() async {
    String uid = _conUserName.text;
    String passwd = passwordCtrl.text;

    if (uid.isEmpty) {
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(snackError);
      setState(() {
        msj = "Introduzca su usuario";
      });
    } else if (passwd.isEmpty) {
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(snackError);
      setState(() {
        msj = "Introduzca su contraseña";
      });
    } else {
      await UserDatabase.instance.getLoginUsers(uid, passwd).then((UserData) {
        if (UserData != null) {
          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => Principal(usuario: UserData)), (Route<dynamic> route) => false);
          //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Principal(usuario: UserData,)));
          //Navigator.push(context, MaterialPageRoute(builder: (context) => Principal(usuario: UserData,)));
        } else {
          ScaffoldMessenger.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(snackError);
          setState(() {
            msj = "Usuario no encontrado";
          });
        }
      }).catchError((error) {
        setState(() {
          msj = "Error en el login";
        });
      });
    }
  }

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
              mainAxisSize: MainAxisSize.max,
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
                    controller: _conUserName,
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
                    onPressed: login,
                    child: const Text('Iniciar Sesion'),
                  ),
                ),
              ],
            ),
          )),
        ));
  }
}
