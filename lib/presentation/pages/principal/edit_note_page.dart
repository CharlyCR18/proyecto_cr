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
  DateTime aux = DateTime.now();

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

  Future<DateTime?> getDatePickerWidget() {
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

  DateTime hora(DateTime aux, TimeOfDay _tiempoSeleccionado) {
    return new DateTime(aux.year, aux.month, aux.day, _tiempoSeleccionado.hour,
        _tiempoSeleccionado.minute);
  }

  DateTime join(DateTime _fechaSeleccionada, TimeOfDay _tiempoSeleccionado) {
    return new DateTime(
        _fechaSeleccionada.year,
        _fechaSeleccionada.month,
        _fechaSeleccionada.day,
        _tiempoSeleccionado.hour,
        _tiempoSeleccionado.minute);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: Text(
          "Configurar",
          textAlign: TextAlign.center,
        ),
        actions: [buildButton()],
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: SingleChildScrollView(
            child: Column(
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
                onChangedNumber: (number) =>
                    setState(() => this.number = number),
                onChangedTitle: (title) => setState(() => this.title = title),
                onChangedDescription: (description) =>
                    setState(() => this.description = description),
              ),
            ),
            Text(
              "Seleccione la fecha",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white70,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 18,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: callDatePicker,
                  icon: Icon(
                    Icons.calendar_today_rounded,
                  ),
                  label: Icon(Icons.search_outlined),
                ),
                SizedBox(
                  width: 18,
                ),
                Text(
                  //"$_fechaSeleccionada",
                  _fechaSeleccionada == null
                      ? 'Sin fecha seleccionada'
                      : DateFormat.yMMMd()
                          .format(_fechaSeleccionada ?? DateTime.now()),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 25,
            ),
            Text(
              "Seleccione la hora",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white70,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: callTimePicker,
                  icon: Icon(Icons.watch_later_outlined),
                  label: Icon(Icons.search_outlined),
                ),
                SizedBox(
                  width: 18,
                ),
                Text(
                  //"$_tiempoSeleccionado",
                  _tiempoSeleccionado == null
                      ? 'Sin hora seleccionada'
                      : DateFormat('kk:mm')
                          .format(hora(aux, _tiempoSeleccionado)),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        )),
      ));

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
