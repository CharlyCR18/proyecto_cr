import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:proyecto_cr/api/notification_api.dart';
import 'package:proyecto_cr/presentation/pages/login/sesion.dart';
import 'package:proyecto_cr/presentation/pages/on_board/onboard.dart';
import 'package:proyecto_cr/presentation/pages/principal/notes_page.dart';
import 'package:proyecto_cr/presentation/pages/principal/principal.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver{

  @override
  initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
    
    NotificationApi.init();
    //listenNotifications();
  }
  
  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.inactive || 
    state == AppLifecycleState.detached) return;
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Material App',
      home: OnBoard(),
    );
  }
}