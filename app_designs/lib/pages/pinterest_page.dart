import 'package:app_designs/theme/theme.dart';
import 'package:app_designs/widgets/pinterest_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class PinterestPage extends StatelessWidget {
  const PinterestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _MenuModel(),
      child: Scaffold(
          body: Stack(
        children: [PinterestGrid(), const _PinterestMenuLocation()],
      )
          // body: PinterestGrid(),
          // body: PinterestMenu()
          ),
    );
  }
}

class _PinterestMenuLocation extends StatelessWidget {
  const _PinterestMenuLocation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final widthScreen = MediaQuery.of(context).size.width;
    final mostrarMenu = Provider.of<_MenuModel>(context).mostrar;
    final appTheme = Provider.of<ThemeChanger>(context).currentTheme;

    return Positioned(
      child: SizedBox(
        width: widthScreen,
        child: Align(
            child: PinterestMenu(
          mostrar: mostrarMenu,
          backgroundColor: appTheme.scaffoldBackgroundColor,
          activeColor: appTheme.colorScheme.secondary,
          items: [
            PinterestButton(
                onPressed: () => print("icon.pie_chart"),
                icon: Icons.pie_chart),
            PinterestButton(
                onPressed: () => print("icon.search"), icon: Icons.search),
            PinterestButton(
                onPressed: () => print("icon.notifications"),
                icon: Icons.notifications),
            PinterestButton(
                onPressed: () => print("icon.supervised_user_circle"),
                icon: Icons.supervised_user_circle)
          ],
        )),
      ),
      bottom: 30,
    );
  }
}

class PinterestGrid extends StatefulWidget {
  const PinterestGrid({Key? key}) : super(key: key);

  @override
  State<PinterestGrid> createState() => _PinterestGridState();
}

class _PinterestGridState extends State<PinterestGrid> {
  final List<int> items = List.generate(200, (index) => index);
  ScrollController scrollController = ScrollController();
  double scrollAnterior = 0;

  @override
  void initState() {
    scrollController.addListener(() {
      if (scrollController.offset > scrollAnterior &&
          scrollController.offset > 150) {
        Provider.of<_MenuModel>(context, listen: false).mostrar = false;
      } else {
        Provider.of<_MenuModel>(context, listen: false).mostrar = true;
      }
      scrollAnterior = scrollController.offset;
    });
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.custom(
      controller: scrollController,
      gridDelegate: SliverQuiltedGridDelegate(
        crossAxisCount: 4,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        repeatPattern: QuiltedGridRepeatPattern.inverted,
        pattern: const [
          QuiltedGridTile(3, 2),
          QuiltedGridTile(2, 2),
        ],
      ),
      childrenDelegate: SliverChildBuilderDelegate(
          (context, index) => _PinterestItem(index),
          childCount: items.length),
    );
  }
}

class _PinterestItem extends StatelessWidget {
  const _PinterestItem(this.index);

  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      decoration: const BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.all(Radius.circular(30))),
      child: Center(
          child: CircleAvatar(
        backgroundColor: Colors.white,
        child: Text("$index"),
      )),
    );
  }
}

class _MenuModel with ChangeNotifier {
  bool _mostrar = true;

  bool get mostrar => _mostrar;
  set mostrar(bool value) {
    _mostrar = value;
    notifyListeners();
  }
}
