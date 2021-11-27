import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:proyecto_cr/api/notification_api.dart';
import 'package:proyecto_cr/presentation/pages/db/notes_database.dart';
import 'package:proyecto_cr/presentation/pages/model/note.dart';
import 'package:proyecto_cr/presentation/pages/principal/edit_note_page.dart';
import 'package:proyecto_cr/presentation/pages/principal/note_detail_page.dart';
import 'package:proyecto_cr/presentation/pages/widget/note_card_widget.dart';

class NotesPage extends StatefulWidget {
  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  late List<Note> notes;
  bool isLoading = false;
  DateTime tiempo = DateTime.now();

  //Inicializa, lee las notas existentes
  @override
  void initState() {
    super.initState();

    refreshNotes();
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
  }

  //Inicia lo grafico
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Center(
            child: Image.asset(
              "assets/images/tclogo.png",
              width: 250,
              height: 250,
            ),
          ),

          //actions: [IconButton(onPressed: onPressed, icon: icon)],
          //actions: [Icon(Icons.search), SizedBox(width: 12)],
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
                        Text('$tiempo'),
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
