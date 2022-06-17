import 'package:app_designs/widgets/slideshow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SlideshowPage extends StatelessWidget {
  const SlideshowPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: const [
          Expanded(child: MySlide()),
          Expanded(child: MySlide()),
        ],
      ),
    );
  }
}

class MySlide extends StatelessWidget {
  const MySlide({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slideshow(
      puntosArriba: false,
      colorPrimario: Colors.green,
      colorSecundario: Colors.blueGrey,
      bulletPrimario: 15,
      bulletSecundario: 12,
      slides: [
        SvgPicture.asset("assets/svgs/slide-1.svg"),
        SvgPicture.asset("assets/svgs/slide-2.svg"),
        SvgPicture.asset("assets/svgs/slide-3.svg"),
        SvgPicture.asset("assets/svgs/slide-4.svg"),
        SvgPicture.asset("assets/svgs/slide-5.svg"),
      ],
    );
  }
}
