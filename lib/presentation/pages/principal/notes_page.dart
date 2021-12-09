import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';
import 'package:proyecto_cr/api/notification_api.dart';
import 'package:proyecto_cr/presentation/pages/Registrar/registrar.dart';
import 'package:proyecto_cr/presentation/pages/bloqueo/bloqueo.dart';
import 'package:proyecto_cr/presentation/pages/db/notes_database.dart';
import 'package:proyecto_cr/presentation/pages/model/note.dart';
import 'package:proyecto_cr/presentation/pages/model/user.dart';
import 'package:proyecto_cr/presentation/pages/principal/edit_note_page.dart';
import 'package:proyecto_cr/presentation/pages/principal/note_detail_page.dart';
import 'package:proyecto_cr/presentation/pages/principal/principal.dart';
import 'package:proyecto_cr/presentation/pages/widget/note_card_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/riverpod.dart';

//final notificacionStateProvider = StateProvider<bool>((ref) {return notificationv;});
//final bloqueoStateProvider = StateProvider<bool>((refe) {return bloqueov;});

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

    Timer.periodic(Duration(seconds: 1), (Timer t) => _getTime());
    Timer.periodic(Duration(seconds: 1), (Timer t2) => notaTime(_timeString));

    NotificationApi.init();

    iniciarbools();

    user = widget.usuario;
    idUser = widget.usuario.id;
    nomUser = widget.usuario.name;
    nomCorreo = widget.usuario.correo;
    nomContra = widget.usuario.contra;
  }

  void iniciarbools(){
    setState(() {
      booln = bools.notificationv.toString();
    });
    setState(() {
      boolb = bools.bloqueov.toString();
    });
  }

  void NotificacionAviso() => NotificationApi.ShowNotification(title: "Dia programado", body: "llegó la hora, ahora yo tengo el control :D", payload: "UwU");
  
  void PantallaBloqueo() => Navigator.push(context, MaterialPageRoute(builder: (context) => Bloqueo(usuario: user,)));

      //Navigator.push(context, MaterialPageRoute(builder: (context) => Principal()));

  void notaTime(String tiempo) {
    String t;
    String at;
    for (var i = 0; i < notes.length; i++) {
      DateTime tiempoNota = notes[i].createdTime;
      t = DateFormat('yyyy-MM-dd kk:mm').format(tiempoNota);

      DateTime antesTiempo = notes[i].createdTime.subtract(Duration(minutes: 1));
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
        PantallaBloqueo();
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

  /*void getTiempos(String tiempoActual) async {
    var dbClient = await NotesDatabase.instance.database;
    var res = await dbClient
        .rawQuery("SELECT * FROM notes WHERE time = '$tiempoActual'");

    setState(() {
      p = res.length.toString();
    });

    if (res.length > 0) {
      setState(() {
        p = "Ya llegó al tiempo";
      });
      //p = "Ya llegó al tiempo";
      //onClickNotification();
      //Navigator.push(context, MaterialPageRoute(builder: (context) => Profile()));
      //return Note.fromJson(res.first);
    }

    //return null;
  }*/

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
                Builder(
              builder: (context) =>IconButton(
                onPressed: () => Scaffold.of(context).openDrawer(), 
                icon: Icon(Icons.person_outline_outlined,  color: Colors.blue,)
                ),
              ),
              Container(
                width: 280,
                child: Center(
                child: Text("Hola $nomUser ;)"),
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
              SizedBox(height: 18,),
              Text(
                idUser.toString(),
                textAlign: TextAlign.center,          
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 28 
                ),
                ),
              SizedBox(height: 18,),
              Text(
                nomUser, 
                textAlign: TextAlign.center,          
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 28 
                ),
                ),
                SizedBox(height: 20,),
                Text(
                nomCorreo, 
                textAlign: TextAlign.center,          
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 15 
                ),
                ),
                SizedBox(height: 20,),
                Text(
                "Dias programados: $numNotes", 
                textAlign: TextAlign.center,          
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 15 
                ),
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
