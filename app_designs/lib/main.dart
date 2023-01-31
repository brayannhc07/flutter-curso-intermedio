import 'package:app_designs/models/layout_model.dart';
import 'package:app_designs/pages/launcher_page.dart';
import 'package:app_designs/pages/launcher_tablet_page.dart';
import 'package:app_designs/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<ThemeChanger>(create: (_) => ThemeChanger(2)),
    ChangeNotifierProvider<LayoutModel>(create: (_) => LayoutModel()),
  ], child: const MyApp()));
}

// void main() {
//   runApp(ChangeNotifierProvider(
//       create: (_) => ThemeChanger(2), child: const MyApp()));
// }

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final appTheme = Provider.of<ThemeChanger>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme.currentTheme,
      title: 'Diseños App',
      home: OrientationBuilder(
        builder: (context, Orientation orientation) {
          final screenSize = MediaQuery.of(context).size;

          if (screenSize.width > 500) {
            return const LauncherTabletPage();
          }

          return const LauncherPage();
        },
      ),
    );
  }
}
