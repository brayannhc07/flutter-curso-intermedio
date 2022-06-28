import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BotonGrande extends StatelessWidget {
  const BotonGrande(
      {Key? key,
      this.icon = FontAwesomeIcons.circle,
      required this.texto,
      this.colorPrimario = Colors.indigoAccent,
      this.colorSecundario = Colors.deepPurple,
      required this.onPress})
      : super(key: key);

  final IconData icon;
  final String texto;
  final Color colorPrimario;
  final Color colorSecundario;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPress(),
      child: Stack(
        children: [
          _BotonGrandeBackground(
              icon: icon,
              colorPrimario: colorPrimario,
              colorSecundario: colorSecundario),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 140,
                width: 40,
              ),
              FaIcon(
                icon,
                color: Colors.white,
                size: 40,
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Text(
                  texto,
                  style: const TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
              const FaIcon(FontAwesomeIcons.chevronRight, color: Colors.white),
              const SizedBox(width: 40)
            ],
          )
        ],
      ),
    );
  }
}

class _BotonGrandeBackground extends StatelessWidget {
  const _BotonGrandeBackground({
    Key? key,
    required this.icon,
    required this.colorPrimario,
    required this.colorSecundario,
  }) : super(key: key);

  final IconData icon;
  final Color colorPrimario;
  final Color colorSecundario;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Stack(
            children: [
              Positioned(
                  right: -20,
                  top: -20,
                  child: FaIcon(icon,
                      size: 150, color: Colors.white.withOpacity(0.2)))
            ],
          ),
        ),
        width: double.infinity,
        height: 100,
        margin: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  offset: const Offset(4, 6),
                  blurRadius: 10)
            ],
            borderRadius: BorderRadius.circular(15),
            gradient:
                LinearGradient(colors: [colorPrimario, colorSecundario])));
  }
}
