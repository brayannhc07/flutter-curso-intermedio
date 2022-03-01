import 'package:app_designs/pages/animaciones_page.dart';
import 'package:app_designs/retos/cuadrado_animado_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Diseños APP',
      home: CuadradoAnimadoPage(),
    );
  }
}
