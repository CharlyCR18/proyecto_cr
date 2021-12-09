import 'package:flutter/material.dart';
import 'package:proyecto_cr/presentation/pages/model/user.dart';
import 'package:proyecto_cr/presentation/pages/principal/notes_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proyecto_cr/presentation/pages/principal/principal.dart';
import 'package:proyecto_cr/riverpod/providers/providers.dart';
import 'package:riverpod/riverpod.dart';

/*
class Bloquear extends ConsumerWidget {
  const Bloquear({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //final counternotificacion = ref.watch(notificacionStateProvider);
    //final counterbloqueo = refe.watch(bloqueoStateProvider);

    return Scaffold(
      body: Container(
        child: ElevatedButton(
          onPressed: () {

            Navigator.push(
              context, MaterialPageRoute(builder: (context) => Principal()));
          },
          child: Text("hola"),
        ),
      ),
    );
  }
}
*/

class Bloqueo extends StatefulWidget {
  User usuario;
  Bloqueo({
    Key? key, required this.usuario
  }) : super(key: key);

  @override
  _BloqueoState createState() => _BloqueoState();
}

class _BloqueoState extends State<Bloqueo> {
  var boleanos = Boleanos();
  String boln = "iniciado n";
  String bolb = "iniciado b";

  late User user;
  late int? idUser;
  late String nomUser;
  late String nomCorreo;
  late String nomContra;

  @override
  void initState() {
    super.initState();
    
    user = widget.usuario;
    idUser = widget.usuario.id;
    nomUser = widget.usuario.name;
    nomCorreo = widget.usuario.correo;
    nomContra = widget.usuario.contra;
  }

  void checar() {
    setState(() {
      boln = boleanos.notificationv.toString();
    });
    setState(() {
      bolb = boleanos.bloqueov.toString();
    });
  }

  _alertDialog() async {
    var alertDialogs = await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Cancelando"),
            content: Text("¿Seguro que deseas cancelar?", textAlign: TextAlign.justify,),
            actions: <Widget>[
              ElevatedButton(
                  onPressed: () {
                    _alertDialog2();
                  },
                  child: Text("Si")),
              ElevatedButton(
                  onPressed: () => Navigator.pop(context, "Regresar"),
                  child: Text("Regresar")),
            ],
          );
        });
    return alertDialogs;
  }

  _alertDialog2() async {
    var alertDialogs = await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("¿Estas seguro?"),
            content: Text("me vas a decepcionar, y a todos lo que confian en ti UnU", textAlign: TextAlign.justify,),
            actions: <Widget>[
              ElevatedButton(
                  onPressed: () {
                    _alertDialog3();
                  },
                  child: Text("Si")),
              ElevatedButton(
                  onPressed: () => Navigator.pop(context, "Regresar"),
                  child: Text("Regresar")),
            ],
          );
        });
    return alertDialogs;
  }

  _alertDialog3() async {
    var alertDialogs = await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Hasta luego"),
            content: Text("Nos vemos, pero a pesar de todo, lo unico que haz roto, es mi corazón UnU, vete...", textAlign: TextAlign.justify,),
            actions: <Widget>[
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Principal(usuario: user,)));
                  },
                  child: Text("Si")),
              ElevatedButton(
                  onPressed: () => Navigator.pop(context, "Regresar"),
                  child: Text("Regresar")),
            ],
          );
        });
    return alertDialogs;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        /*appBar: AppBar(
        title: Text('Perfil'),
      ),*/
        body: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Color(0xDD000000),
            //backgroundColor: Color(Colors.black),
          ),
          child: Column(children: [
            const SizedBox(
              height: 100,
            ),
            Image.asset(
              "assets/images/bloqueo.gif",
              width: 250,
              height: 250,
            ),
            SizedBox(
              height: 1,
            ),
            //TEXTO BIENVENIDA
            Text(
              '¿Como te va $nomUser? OwO',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.pink.shade200,
                fontSize: 16,
                fontWeight: FontWeight.w600,
                letterSpacing: .8,
                height: 1,
              ),
            ),
            //SEPARADOR
            SizedBox(
              height: 50,
            ),
            Text(
              'Concentrate, tu puedes lograrlo ;)',
              textAlign: TextAlign.center,
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
                _alertDialog();
              },
              child: Text(
                "Cancelar",
                style: TextStyle(
                    color: Colors.white,
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
            SizedBox(
              height: 10,
            ),
            Text(
              'Enserio vas a cancelar? :(',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                //fontWeight: FontWeight.w600,
                letterSpacing: .8,
                height: 1,
              ),
            ),
          ]),
        ),
      );
}
