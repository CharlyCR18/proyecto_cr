import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_cr/presentation/pages/model/user.dart';
import 'package:proyecto_cr/presentation/pages/principal/notes_page.dart';

class Principal extends StatelessWidget {
  static final String title = 'Take Control';
  User usuario;
  Principal({Key? key, required this.usuario}) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        themeMode: ThemeMode.dark,
        theme: ThemeData(
          primaryColor: Colors.grey,
          scaffoldBackgroundColor: Colors.grey[800],
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
        ),
        home: NotesPage(usuario: usuario,),
      );
}