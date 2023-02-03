import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoes_app/src/models/shoe_model.dart';
import 'package:shoes_app/src/pages/shoe_page.dart';

void main() {
  return runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (_) => ShoeModel())],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        title: 'ShoesApp', debugShowCheckedModeBanner: false, home: ShoePage());
  }
}
