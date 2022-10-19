import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TwitterPage extends StatefulWidget {
  const TwitterPage({Key? key}) : super(key: key);

  @override
  State<TwitterPage> createState() => _TwitterPageState();
}

class _TwitterPageState extends State<TwitterPage> {
  bool activar = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            activar = true;
          });
        },
        backgroundColor: Colors.pink,
        child: const FaIcon(FontAwesomeIcons.play),
      ),
      backgroundColor: const Color(0xff1DA1F2),
      body: Center(
          child: ZoomOut(
              from: 30,
              animate: activar,
              duration: const Duration(seconds: 1),
              child: const FaIcon(FontAwesomeIcons.twitter,
                  color: Colors.white, size: 40))),
    );
  }
}
