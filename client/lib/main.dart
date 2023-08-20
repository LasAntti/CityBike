import 'package:flutter/material.dart';
import 'pages/homepage.dart';
import 'package:flutter_config/flutter_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); 
  await FlutterConfig.loadEnvVariables();
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
