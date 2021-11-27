import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:proyecto_cr/api/notification_api.dart';
import 'package:proyecto_cr/presentation/pages/login/sesion.dart';
import 'package:proyecto_cr/presentation/pages/on_board/onboard.dart';
import 'package:proyecto_cr/presentation/pages/principal/notes_page.dart';
import 'package:proyecto_cr/presentation/pages/principal/principal.dart';
import 'package:proyecto_cr/presentation/pages/profile/profile.dart';

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

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
    
    NotificationApi.init();
    listenNotifications();
  }
  

  void listenNotifications() => NotificationApi.onNotifications.stream.listen(onClickedNotification);
  
  void onClickedNotification(String? payload) => 
  Navigator.of(context).push(MaterialPageRoute(
    builder: (context) => Profile(payload: payload,),
    ));

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Material App',
      home: OnBoard(),
    );
  }
}