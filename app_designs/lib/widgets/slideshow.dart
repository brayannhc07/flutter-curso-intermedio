import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Slideshow extends StatelessWidget {
  final List<Widget> slides;
  final bool puntosArriba;
  final Color colorPrimario;
  final Color colorSecundario;
  final double bulletPrimario;
  final double bulletSecundario;

  const Slideshow(
      {Key? key,
      required this.slides,
      this.puntosArriba = false,
      this.colorPrimario = Colors.indigo,
      this.colorSecundario = Colors.grey,
      this.bulletPrimario = 12,
      this.bulletSecundario = 12})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => _SlidershowModel(
            colorPrimario, colorSecundario, bulletPrimario, bulletSecundario),
        child: SafeArea(
          child: Center(
            child: Builder(builder: (context) {
              // Provider.of<_SlidershowModel>(context).colorPrimario =
              //     ;
              // Provider.of<_SlidershowModel>(context).colorSecundario =
              //     ;
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

    final isCurrent = (slideshowModel.currentPage >= index - 0.5 &&
        slideshowModel.currentPage <= index + 0.5);

    final bulletSize = isCurrent
        ? slideshowModel.bulletPrimario
        : slideshowModel.bulletSecundario;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: bulletSize,
      height: bulletSize,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
          color: isCurrent
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
  _SlidershowModel(this._colorPrimario, this._colorSecundario,
      this._bulletPrimario, this._bulletSecundario);

  double _currentPage = 0;
  Color _colorPrimario = Colors.blue;
  Color _colorSecundario = Colors.grey;
  double _bulletPrimario = 12;
  double _bulletSecundario = 12;

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

  double get bulletPrimario => _bulletPrimario;
  set bulletPrimario(double value) {
    _bulletPrimario = value;
    notifyListeners();
  }

  double get bulletSecundario => _bulletSecundario;
  set bulletSecundario(double value) {
    _bulletSecundario = value;
    notifyListeners();
  }
}
