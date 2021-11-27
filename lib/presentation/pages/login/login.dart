import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nike_store/presentation/pages/login/widgets/name_input.dart';
import 'package:nike_store/presentation/pages/my_home/my_home.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  
  Widget build(BuildContext context) {
    String name = "";
    String mail = "";
    String phone = "";
    String password = "";
    String VerifyPassword = "";
    final _formKey = GlobalKey<FormState>();
    const appTitle = 'Form Validation Demo';
    TextEditingController passwordCtrl = new TextEditingController();
    TextEditingController repeatPassCtrl = new TextEditingController();

    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(appTitle),
        ),
        body: SingleChildScrollView(
            child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //NOMBRE
              TextFormField(
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
                decoration: const InputDecoration(
                    icon: Icon(Icons.account_circle), label: Text("Nombre")),
              ),
              //APELLIDO
              TextFormField(
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
                decoration: const InputDecoration(
                    icon: Icon(Icons.account_circle), label: Text("Apellido")),
              ),
              //MAIL
              TextFormField(
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
                decoration: const InputDecoration(
                    icon: Icon(Icons.account_circle),
                    label: Text("Correo Electronico")),
              ),
              //TELEFONO
              TextFormField(
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                keyboardType: TextInputType.number,
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'please enter some text';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                    icon: Icon(Icons.account_circle), label: Text("Telefono")),
              ),
              //CONTRASEÑA
              TextFormField(
                controller: passwordCtrl,
                obscureText: true,
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'please enter some text';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                    icon: Icon(Icons.account_circle),
                    label: Text("Contraseña")),
              ),
              //VERIFICAR CONTRASEÑA
              TextFormField(
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
                decoration: const InputDecoration(
                    icon: Icon(Icons.account_circle),
                    label: Text("Verificar Contraseña")),
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

                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => MyHome()));
                    }
                  },
                  child: const Text('Submit'),
                ),
              ),
            ],
          ),
        )),
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
