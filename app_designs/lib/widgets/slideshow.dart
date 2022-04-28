import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/slider_model.dart';

class Slideshow extends StatelessWidget {
  final List<Widget> slides;
  final bool puntosArriba;
  final Color colorPrimario;
  final Color colorSecundario;

  const Slideshow(
      {Key? key,
      required this.slides,
      this.puntosArriba = false,
      this.colorPrimario = Colors.indigo,
      this.colorSecundario = Colors.grey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => _SlidershowModel(),
        child: SafeArea(
          child: Center(
            child: Builder(builder: (context) {
              Provider.of<_SlidershowModel>(context).colorPrimario =
                  colorPrimario;
              Provider.of<_SlidershowModel>(context).colorSecundario =
                  colorSecundario;
              return _CrearEstructuraSlideshow(
                  puntosArriba: puntosArriba, slides: slides);
            }),
          ),
        ));
  }
}

class _CrearEstructuraSlideshow extends StatelessWidget {
  const _CrearEstructuraSlideshow({
    Key? key,
    required this.puntosArriba,
    required this.slides,
  }) : super(key: key);

  final bool puntosArriba;
  final List<Widget> slides;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (puntosArriba)
          _Dots(
            totalSlides: slides.length,
          ),
        Expanded(
          child: _Slides(slides: slides),
        ),
        if (!puntosArriba)
          _Dots(
            totalSlides: slides.length,
          ),
      ],
    );
  }
}

class _Dots extends StatelessWidget {
  final int totalSlides;

  const _Dots({Key? key, required this.totalSlides}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 70,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
              totalSlides,
              (index) => _Dot(
                    index: index,
                  ))),
    );
  }
}

class _Dot extends StatelessWidget {
  final int index;

  const _Dot({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final slideshowModel = Provider.of<_SlidershowModel>(context);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: 12,
      height: 12,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
          color: (slideshowModel.currentPage >= index - 0.5 &&
                  slideshowModel.currentPage <= index + 0.5)
              ? slideshowModel.colorPrimario
              : slideshowModel.colorSecundario,
          shape: BoxShape.circle),
    );
  }
}

class _Slides extends StatefulWidget {
  final List<Widget> slides;

  const _Slides({Key? key, required this.slides}) : super(key: key);

  @override
  State<_Slides> createState() => _SlidesState();
}

class _SlidesState extends State<_Slides> {
  final pageViewController = PageController();

  @override
  void initState() {
    super.initState();

    pageViewController.addListener(() {
      // Se cambia la página
      Provider.of<_SlidershowModel>(context, listen: false).currentPage =
          pageViewController.page ?? 0;
    });
  }

  @override
  void dispose() {
    pageViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: pageViewController,
      children: widget.slides.map((slide) => _Slide(slide: slide)).toList(),
    );
  }
}

class _Slide extends StatelessWidget {
  final Widget slide;

  const _Slide({Key? key, required this.slide}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: const EdgeInsets.all(30),
      child: slide,
    );
  }
}

class _SlidershowModel with ChangeNotifier {
  double _currentPage = 0;
  Color _colorPrimario = Colors.blue;
  Color _colorSecundario = Colors.grey;

  double get currentPage => _currentPage;

  set currentPage(double value) {
    _currentPage = value;
    notifyListeners();
  }

  Color get colorPrimario => _colorPrimario;

  set colorPrimario(Color value) {
    _colorPrimario = value;
    notifyListeners();
  }

  Color get colorSecundario => _colorSecundario;

  set colorSecundario(Color value) {
    _colorSecundario = value;
    notifyListeners();
  }
}
