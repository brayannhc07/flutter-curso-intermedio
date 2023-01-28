import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:app_designs/pages/animaciones_page.dart';
import 'package:app_designs/pages/emergency_page.dart';
import 'package:app_designs/pages/graficas_circulares_page.dart';
import 'package:app_designs/pages/headers_page.dart';
import 'package:app_designs/pages/pinterest_page.dart';
import 'package:app_designs/pages/slideshow_page.dart';
import 'package:app_designs/pages/sliver_list_page.dart';

final pageRoutes = <_Route>[
  _Route(FontAwesomeIcons.slideshare, "Slideshow", const SlideshowPage()),
  _Route(FontAwesomeIcons.truckMedical, "Emergencia", const EmergencyPage()),
  _Route(FontAwesomeIcons.heading, "Encabezados", const HeadersPage()),
  _Route(FontAwesomeIcons.peopleCarryBox, "Cuadro animado",
      const CuadradoAnimado()),
  _Route(FontAwesomeIcons.circleNotch, "Barra Progreso",
      const GraficasCircularesPage()),
  _Route(FontAwesomeIcons.pinterest, "Pinterest", const PinterestPage()),
  _Route(FontAwesomeIcons.mobile, "Slivers", const SliverListPage()),
];

class _Route {
  final IconData icon;
  final String titulo;
  final Widget page;

  _Route(this.icon, this.titulo, this.page);
}
