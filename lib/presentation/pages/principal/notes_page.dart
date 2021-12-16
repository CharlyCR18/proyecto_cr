import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';
import 'package:proyecto_cr/api/notification_api.dart';
import 'package:proyecto_cr/presentation/pages/Registrar/registrar.dart';
import 'package:proyecto_cr/presentation/pages/bloqueo/bloqueo.dart';
import 'package:proyecto_cr/presentation/pages/db/notes_database.dart';
import 'package:proyecto_cr/presentation/pages/login/sesion.dart';
import 'package:proyecto_cr/presentation/pages/model/note.dart';
import 'package:proyecto_cr/presentation/pages/model/user.dart';
import 'package:proyecto_cr/presentation/pages/principal/edit_note_page.dart';
import 'package:proyecto_cr/presentation/pages/principal/note_detail_page.dart';
import 'package:proyecto_cr/presentation/pages/principal/principal.dart';
import 'package:proyecto_cr/presentation/pages/widget/note_card_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/riverpod.dart';

class Boleanos {
  bool notificationv = false;
  bool bloqueov = false;
}

class NotesPage extends StatefulWidget {
  User usuario;
  NotesPage({Key? key, required this.usuario}) : super(key: key);
  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage>
    with SingleTickerProviderStateMixin {
  late List<Note> notes;
  bool isLoading = false;
  DateTime tiempo = DateTime.now();
  //late DateTime comparatime = DateTime.parse(_timeString);
  late String p = "Hola";

  late String _timeString;
  late TabController _tabController;

  var bools = Boleanos();

  late String booln;
  late String boolb;

  late User user;
  late int? idUser;
  late String nomUser;
  late String nomCorreo;
  late String nomContra;

  late String numNotes;
  bool condicion = true;

  //bool notificationv = false;
  //bool bloqueov = false;

  final snack = SnackBar(
    content: Text("Sesion iniciada... Bienvenido ;)"),
    backgroundColor: Colors.green,
  );

  //Inicializa, lee las notas existentes
  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 4, vsync: this, initialIndex: 0);

    refreshNotes();

    _timeString = _formatDateTime(DateTime.now());

    iniciaTimers(condicion);

    NotificationApi.init();

    iniciarbools();

    user = widget.usuario;
    idUser = widget.usuario.id;
    nomUser = widget.usuario.name;
    nomCorreo = widget.usuario.correo;
    nomContra = widget.usuario.contra;
  }

  void iniciaTimers(bool condicion) {
    Timer.periodic(Duration(seconds: 1), (Timer t) {
      if (condicion == true) {
        _getTime();
      } else {
        t.cancel();
      }
    });

    Timer.periodic(Duration(seconds: 1), (Timer t2) {
      if (condicion == true) {
        notaTime(_timeString);
      } else {
        t2.cancel();
      }
    });
  }

  void iniciarbools() {
    setState(() {
      booln = bools.notificationv.toString();
    });
    setState(() {
      boolb = bools.bloqueov.toString();
    });
  }

  void NotificacionAviso() => NotificationApi.ShowNotification(
      title: "Dia programado",
      body: "llegó la hora, ahora yo tengo el control :D",
      payload: "UwU");

  void PantallaBloqueo(String mensaje) {
    setState(() {
      condicion = false;
    });
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Bloqueo(
                  usuario: user,
                  mensaje: mensaje,
                )));
  }

  //Navigator.push(context, MaterialPageRoute(builder: (context) => Principal()));

  void notaTime(String tiempo) {
    String t;
    String at;
    for (var i = 0; i < notes.length; i++) {
      DateTime tiempoNota = notes[i].createdTime;
      t = DateFormat('yyyy-MM-dd kk:mm').format(tiempoNota);

      DateTime antesTiempo =
          notes[i].createdTime.subtract(Duration(minutes: 1));
      at = DateFormat('yyyy-MM-dd kk:mm').format(antesTiempo);

      if (at == tiempo && bools.notificationv == false) {
        NotificacionAviso();
        setState(() {
          bools.notificationv = true;
          //booln = bools.notificationv.toString();
        });
        setState(() {
          booln = bools.notificationv.toString();
        });
      }

      if (t == tiempo && bools.bloqueov == false) {
        PantallaBloqueo(notes[i].description.toString());
        setState(() {
          bools.bloqueov = true;
          //boolb = bools.bloqueov.toString();
        });
        setState(() {
          booln = bools.bloqueov.toString();
        });
      }
    }
  }

  void _getTime() {
    final DateTime now = DateTime.now();
    final String formattedDateTime = _formatDateTime(now);

    setState(() {
      _timeString = formattedDateTime;
    });
  }

  String _formatDateTime(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd kk:mm').format(dateTime);
  }

  //Cierrra las notas con el metodo close
  @override
  void dispose() {
    NotesDatabase.instance.close();

    super.dispose();
  }

  //lee las notas existentes
  Future refreshNotes() async {
    setState(() => isLoading = true);

    this.notes = await NotesDatabase.instance.readAllNotes();

    setState(() => isLoading = false);

    numNotes = notes.length.toString();
  }

  _alertDialog() async {
    var alertDialogs = await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Cerrar sesión"),
            content: Text(
              "¿Seguro que deseas cerrar tu sesión?",
              textAlign: TextAlign.justify,
            ),
            actions: <Widget>[
              ElevatedButton(
                  onPressed: () => Navigator.pop(context, "Regresar"),
                  child: Text("Cancelar")),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      condicion = false;
                    });
                    //Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => Sesion()), (Route<dynamic> route) => false);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Sesion()));
                  },
                  child: Text("Aceptar")),
            ],
          );
        });
    return alertDialogs;
  }

  //Inicia lo grafico
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Padding(
            padding: EdgeInsets.symmetric(horizontal: 0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    child: Builder(
                      builder: (context) => IconButton(
                        onPressed: () => Scaffold.of(context).openDrawer(),
                        icon: Icon(
                          Icons.person_outline_outlined,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Container(
                    child: Center(
                      child: Text("Hola $nomUser ;)"),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    child: IconButton(
                      onPressed: _alertDialog,
                      icon: Icon(
                        Icons.power_settings_new_rounded,
                        color: Colors.red.shade400,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          /*title: Center(
            child: Text(nomUser, textAlign: TextAlign.center),
            Image.asset(
              "assets/images/tclogo.png",
              width: 250,
              height: 250,
            ),
          ),*/

          //actions: [IconButton(onPressed: onPressed, icon: icon)],
          //actions: [Icon(Icons.search), SizedBox(width: 12)],
        ),
        drawer: Drawer(
          child: Container(
            width: double.infinity,
            color: Colors.black,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 40,
                  backgroundImage: AssetImage("assets/images/bloqueo_logo.png"),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Icon(
                      Icons.tag,
                      color: Colors.purple,
                    ),
                    Text(
                      "ID: " + idUser.toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.blue, fontSize: 18),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Icon(
                      Icons.person_outline_outlined,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      nomUser,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.blue, fontSize: 28),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Icon(
                      Icons.mail_outline_outlined,
                      color: Colors.green,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      nomCorreo,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.blue, fontSize: 15),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
        body: isLoading
            ? CircularProgressIndicator()
            : notes.isEmpty
                ? Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 200),
                        Text(
                          'Bienvenido, ¿Alguna tarea pendiente?',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 28),
                        ),
                      ],
                    ),
                  )
                : buildNotes(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue,
          child: Icon(Icons.add),
          onPressed: () async {
            await Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => AddEditNotePage()),
            );

            refreshNotes();
          },
        ),
      );

  Widget buildNotes() => StaggeredGridView.countBuilder(
        padding: EdgeInsets.all(8),
        itemCount: notes.length,
        staggeredTileBuilder: (index) => StaggeredTile.fit(4),
        crossAxisCount: 4,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        itemBuilder: (context, index) {
          final note = notes[index];

          return GestureDetector(
            onTap: () async {
              await Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => NoteDetailPage(noteId: note.id!),
              ));

              refreshNotes();
            },
            child: NoteCardWidget(note: note, index: index),
          );
        },
      );
}
