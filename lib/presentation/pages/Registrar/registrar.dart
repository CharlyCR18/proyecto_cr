import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:proyecto_cr/presentation/pages/db/user_database.dart';
import 'package:proyecto_cr/presentation/pages/login/sesion.dart';
import 'package:proyecto_cr/presentation/pages/model/user.dart';
import 'package:proyecto_cr/presentation/pages/principal/notes_page.dart';
import 'package:proyecto_cr/presentation/pages/principal/principal.dart';

class Registrar extends StatefulWidget {
  final User? user;

  const Registrar({Key? key, this.user}) : super(key: key);

  @override
  _RegistrarState createState() => _RegistrarState();
}

class _RegistrarState extends State<Registrar> {
  late String name;
  late String correo;
  late String contra;

  String name2 = "no iniciada";
  String correo2 = "no iniciada";
  String contra2 = "no iniciada";

  final _formKey = GlobalKey<FormState>();

  final _conUserId = TextEditingController();
  final _conUserName = TextEditingController();
  final _conEmail = TextEditingController();
  final passwordCtrl = new TextEditingController();
  final repeatPassCtrl = new TextEditingController();
  var dbHelper;
  String msj = "Iniciado";

  @override
  void initState() {
    super.initState();

    name = widget.user?.name ?? '';
    correo = widget.user?.correo ?? '';
    contra = widget.user?.contra ?? '';
  }

  @override
  Widget build(BuildContext context) {
    //var maxHeight = MediaQuery.of(context).size.height;
    String name = "";
    String mail = "";
    String phone = "";
    String password = "";
    String VerifyPassword = "";

    bool secureText = true;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Registrarse", textAlign: TextAlign.center,),
      ),
      body: Container(
          width: double.infinity,
          color: Colors.black,
          child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: CircleAvatar(
                            backgroundColor: Colors.grey[400],
                            radius: 50.0,
                            backgroundImage:
                                AssetImage("assets/images/user.png"),
                          ),
                        ),

                        SizedBox(
                          height: 20,
                        ),

                        //USUARIO
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: TextFormField(
                            controller: _conUserName,
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
                              } else {
                                setState(() {
                                  name = _conUserName.text;
                                });
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
                                  borderSide:
                                      BorderSide(color: Colors.white, width: 3),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(18),
                                  borderSide:
                                      BorderSide(color: Colors.blue, width: 3),
                                )),
                          ),
                        ),

                        //CORREO
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: TextFormField(
                            controller: _conEmail,
                            style: TextStyle(color: Colors.white),
                            // The validator receives the text that the user has entered.
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'please enter some text';
                              }
                              if (!StringAdm.validateEmail(value)) {
                                return 'Ingrese un correo válido';
                              } else {
                                setState(() {
                                  correo = _conEmail.text;
                                });
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.mail_outline_outlined,
                                  color: Colors.green,
                                ),
                                labelStyle: TextStyle(color: Colors.blue),
                                labelText: "Correo",
                                hintStyle: TextStyle(color: Colors.white),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(18),
                                  borderSide:
                                      BorderSide(color: Colors.white, width: 3),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(18),
                                  borderSide:
                                      BorderSide(color: Colors.blue, width: 3),
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
                                  borderSide:
                                      BorderSide(color: Colors.white, width: 3),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(18),
                                  borderSide:
                                      BorderSide(color: Colors.blue, width: 3),
                                )),
                            obscureText: secureText,
                            // The validator receives the text that the user has entered.
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'please enter some text';
                              } else {
                                setState(() {
                                  contra = passwordCtrl.text;
                                });
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
                                  borderSide:
                                      BorderSide(color: Colors.white, width: 3),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(18),
                                  borderSide:
                                      BorderSide(color: Colors.blue, width: 3),
                                )),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: ElevatedButton(
                            onPressed: () {
                              final snack = SnackBar(
                                content: Text("Registrado con exito"),
                                backgroundColor: Colors.green,
                              );
                              final snackError = SnackBar(
                                content: Text("Error: Revise sus datos"),
                                backgroundColor: Colors.red,
                              );
                              if (passwordCtrl.text == repeatPassCtrl.text) {
                                ScaffoldMessenger.of(context)
                                  ..removeCurrentSnackBar()
                                  ..showSnackBar(snack);
                                addOrUpdateUser();
                              } else {
                                ScaffoldMessenger.of(context)
                                  ..removeCurrentSnackBar()
                                  ..showSnackBar(snackError);
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
          ),
    );
  }

  void addOrUpdateUser() async {
    final isValid = _formKey.currentState!.validate();

    if (passwordCtrl.text == repeatPassCtrl.text) {
      if (isValid) {
        await addUser();

        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Sesion()));
      }
    } else {
      setState(() {
        msj = "contraseña distinta";
      });
    }
  }

  void checar() async {
    final isValid = _formKey.currentState!.validate();

    if (passwordCtrl.text == repeatPassCtrl.text) {
      if (isValid) {
        setState(() {
          name2 = _conUserName.text;
        });
        setState(() {
          correo2 = _conEmail.text;
        });
        setState(() {
          contra2 = passwordCtrl.text;
        });
      }
    } else {
      setState(() {
        msj = "contraseña distinte";
      });
    }
  }

  Future addUser() async {
    final user = User(
      name: _conUserName.text,
      correo: _conEmail.text,
      contra: passwordCtrl.text,
    );

    await UserDatabase.instance.create(user);
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
