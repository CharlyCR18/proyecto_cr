import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:proyecto_cr/presentation/pages/db/notes_database.dart';
import 'package:proyecto_cr/presentation/pages/model/note.dart';
import 'package:proyecto_cr/presentation/pages/principal/edit_note_page.dart';

class NoteDetailPage extends StatefulWidget {
  final int noteId;

  const NoteDetailPage({
    Key? key,
    required this.noteId,
  }) : super(key: key);

  @override
  _NoteDetailPageState createState() => _NoteDetailPageState();
}

class _NoteDetailPageState extends State<NoteDetailPage> {
  late Note note;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refreshNote();
  }

  Future refreshNote() async {
    setState(() => isLoading = true);

    this.note = await NotesDatabase.instance.readNote(widget.noteId);

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          actions: [deleteButton()],
        ),
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : Padding(
                padding: EdgeInsets.symmetric(horizontal: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    //Titulo de la nota
                    Container(
                      width: double.infinity,
                      child: Text(
                        note.title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 50),
                    //se btiene la fecha de creacion de la nota
                    Container(
                      width: double.infinity,
                      child: Text(
                        "Programada para el dia:",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.purple.shade300,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      child: Text(
                        DateFormat.yMMMd().format(note.createdTime),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.purple.shade200,
                          fontSize: 18,
                        ),
                      ),
                    ),

                    SizedBox(height: 50),
                    //Contenido de la nota
                    Container(
                      width: double.infinity,
                      child: Text(
                        "Te mensaje motivacional es:",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.blue.shade200, fontSize: 20),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      child: Text(
                        note.description,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.blue.shade100, fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ),
      );

  Widget editButton() => IconButton(
      icon: Icon(Icons.edit_outlined),
      onPressed: () async {
        if (isLoading) return;

        await Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => AddEditNotePage(note: note),
        ));

        refreshNote();
      });

  Widget deleteButton() => IconButton(
        icon: Icon(
          Icons.delete,
          color: Colors.red,
        ),
        onPressed: () async {
          await NotesDatabase.instance.delete(widget.noteId);

          Navigator.of(context).pop();
        },
      );
}
