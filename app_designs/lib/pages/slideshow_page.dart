import 'package:app_designs/widgets/slideshow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../theme/theme.dart';

class SlideshowPage extends StatelessWidget {
  const SlideshowPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isLarge = MediaQuery.of(context).size.height > 500;

    const children = [
      Expanded(child: MySlide()),
      Expanded(child: MySlide()),
    ];
    return Scaffold(
      body: isLarge
          ? Column(
              children: children,
            )
          : Row(children: children),
    );
  }
}

class MySlide extends StatelessWidget {
  const MySlide({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appTheme = Provider.of<ThemeChanger>(context);
    final accentColor = appTheme.currentTheme.colorScheme.secondary;

    return Slideshow(
      puntosArriba: false,
      colorPrimario: appTheme.darkTheme ? accentColor : const Color(0xffFF5A7E),
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
