import 'package:flutter/material.dart';
import 'pages/homepage.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        //onGenerateRoute: route.controller,
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        //darkTheme: ThemeData.dark(),
        //themeMode: currentTheme.currentTheme(),
        //initialRoute: 
        home: const HomePage(),
      );
  }
}