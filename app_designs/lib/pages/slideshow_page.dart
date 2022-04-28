import 'package:app_designs/widgets/slideshow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SlideshowPage extends StatelessWidget {
  const SlideshowPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Slideshow(
        puntosArriba: false,
        colorPrimario: Colors.red,
        colorSecundario: Colors.blueGrey,
        slides: [
          SvgPicture.asset("assets/svgs/slide-1.svg"),
          SvgPicture.asset("assets/svgs/slide-2.svg"),
          SvgPicture.asset("assets/svgs/slide-3.svg"),
          SvgPicture.asset("assets/svgs/slide-4.svg"),
          SvgPicture.asset("assets/svgs/slide-5.svg"),
        ],
      ),
    );
  }
}
