import 'package:flutter/material.dart';
import 'package:transicion_app/pages/page2.dart';

class Page1 extends StatelessWidget {
  const Page1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Página 1")),
        body: const Center(child: Text("Page 1")),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(context, _createRoute());
            },
            child: const Icon(Icons.access_alarm)));
  }

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) =>
          const Page2(),
      transitionDuration: const Duration(milliseconds: 300),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final curvedAnimation =
            CurvedAnimation(parent: animation, curve: Curves.easeInOut);

        // return SlideTransition(
        //   position: Tween<Offset>(begin: Offset(0.5, 1.0), end: Offset.zero)
        //       .animate(curvedAnimation),
        //   child: child,
        // );

        // return ScaleTransition(
        //     scale: Tween<double>(begin: 0.0, end: 1.0).animate(curvedAnimation),
        //     child: child);

        // return RotationTransition(
        //     turns: Tween<double>(begin: 0.0, end: 1.0).animate(curvedAnimation),
        //     child: child);

        return FadeTransition(
          opacity: Tween<double>(begin: 0, end: 1.0).animate(curvedAnimation),
          child: child,
        );
      },
    );
  }
}
