import 'package:bored/bloc/boredBloc.dart';
import 'package:bored/services/service_locator.dart';
import 'package:bored/splashScreen.dart';
import 'package:bored/views/homepage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shared_preferences/shared_preferences.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupServiceLocator();
  
    runApp(
      MyApp()
    );


  // runApp(new MyApp());
}

class MyApp extends StatefulWidget {
  ThemeData data;
  MyApp({Key key, this.data}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        
        ChangeNotifierProvider<BoredBloc>(create: (_) => BoredBloc()),
      ],
      child: MaterialAppWithBloc(),
    );
  }
}

class MaterialAppWithBloc extends StatelessWidget {
  const MaterialAppWithBloc({Key key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
   
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'RNDM',
      routes: <String, WidgetBuilder>{
        '/homepage': (BuildContext context) => HomePage(),
      },
     
      home: SplashScreen(),
    );
  }
}
