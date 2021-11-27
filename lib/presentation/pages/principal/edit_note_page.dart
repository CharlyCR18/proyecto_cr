import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:proyecto_cr/presentation/pages/db/notes_database.dart';
import 'package:proyecto_cr/presentation/pages/model/note.dart';
import 'package:proyecto_cr/presentation/pages/widget/note_form_widget.dart';

class AddEditNotePage extends StatefulWidget {
  final Note? note;

  const AddEditNotePage({
    Key? key,
    this.note,
  }) : super(key: key);
  @override
  _AddEditNotePageState createState() => _AddEditNotePageState();
}

class _AddEditNotePageState extends State<AddEditNotePage> {
  final _formKey = GlobalKey<FormState>();
  late bool isImportant;
  late int number;
  late String title;
  late String description;
  late DateTime fecha;

  var _fechaSeleccionada;
  var _tiempoSeleccionado;
  String fechaCompleta = "";

  @override
  void initState() {
    super.initState();

    isImportant = widget.note?.isImportant ?? false;
    number = widget.note?.number ?? 0;
    title = widget.note?.title ?? '';
    description = widget.note?.description ?? '';
  }

//fecha
  void callDatePicker() async {
    var selectedDate = await getDatePickerWidget();
    setState(() {
      _fechaSeleccionada = selectedDate;
    });
  }

  Future <DateTime?> getDatePickerWidget() {
    return showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(data: ThemeData.dark(), child: Container(child: child));
      },
    );
  }

//Tiempo

  void callTimePicker() async {
    var selectedTime = await getTimerPickerWidget();
    setState(() {
      _tiempoSeleccionado = selectedTime;
    });
  }

  Future<TimeOfDay?> getTimerPickerWidget() {
    return showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return Theme(data: ThemeData.dark(), child: Container(child: child));
      },
    );
  }

  DateTime join(DateTime _fechaSeleccionada, TimeOfDay _tiempoSeleccionado) {
  return new DateTime(_fechaSeleccionada.year, _fechaSeleccionada.month, _fechaSeleccionada.day, _tiempoSeleccionado.hour, _tiempoSeleccionado.minute);
  }

  
  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        actions: [buildButton()],
      ),
      body: Column(
        children: [
          Form(
            key: _formKey,
            child: NoteFormWidget(
              isImportant: isImportant,
              number: number,
              title: title,
              description: description,
              onChangedImportant: (isImportant) =>
                  setState(() => this.isImportant = isImportant),
              onChangedNumber: (number) => setState(() => this.number = number),
              onChangedTitle: (title) => setState(() => this.title = title),
              onChangedDescription: (description) =>
                  setState(() => this.description = description),
            ),
          ),
          Text("Seleccione la fecha"),
          SizedBox(height: 18,),
          ElevatedButton.icon(
            onPressed: callDatePicker, 
            icon: Icon(Icons.calendar_today_rounded), 
            label: Text("Seleccionar")
          ),
          SizedBox(height: 18,),
          Text(
            //"$_fechaSeleccionada",
            _fechaSeleccionada == null
                ? 'Sin fecha seleccionada'
                : DateFormat.yMMMd().format(_fechaSeleccionada ?? DateTime.now()),
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text("Seleccione la Hora"),
          ElevatedButton.icon(
            onPressed: callTimePicker, 
            icon: Icon(Icons.watch_later_outlined),
            label: Text("Seleccionar")
          ),
          Text(
            //"$_tiempoSeleccionado",
            _tiempoSeleccionado == null
                ? 'Sin hora seleccionada'
                : _tiempoSeleccionado.toString(),
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      )
      );

  Widget buildButton() {
    final isFormValid = title.isNotEmpty && description.isNotEmpty;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          onPrimary: Colors.white,
          primary: isFormValid ? null : Colors.blue,
        ),
        onPressed: addOrUpdateNote,
        child: Text('Guardar'),
      ),
    );
  }

  void addOrUpdateNote() async {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      final isUpdating = widget.note != null;

      if (isUpdating) {
        await updateNote();
      } else {
        await addNote();
      }

      Navigator.of(context).pop();
    }
  }

  Future updateNote() async {
    final note = widget.note!.copy(
      isImportant: isImportant,
      number: number,
      title: title,
      description: description,
    );

    await NotesDatabase.instance.update(note);
  }

  //Crea la nota con los atributos definidos por el usuario
  Future addNote() async {
    final note = Note(
      title: title,
      isImportant: true,
      number: number,
      description: description,
      createdTime: join(_fechaSeleccionada, _tiempoSeleccionado),
    );

    await NotesDatabase.instance.create(note);
  }
}