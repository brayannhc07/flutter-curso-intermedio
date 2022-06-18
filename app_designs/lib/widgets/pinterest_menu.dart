import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PinterestButton {
  PinterestButton({required this.onPressed, required this.icon});

  final Function onPressed;
  final IconData icon;
}

class PinterestMenu extends StatelessWidget {
  PinterestMenu(
      {Key? key,
      this.mostrar = true,
      this.backgroundColor = Colors.white,
      this.activeColor = Colors.black,
      this.secondaryColor = Colors.blueGrey,
      required this.items})
      : super(key: key);

  final bool mostrar;

  final List<PinterestButton> items;
  final Color backgroundColor;
  final Color activeColor;
  final Color secondaryColor;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => _MenuModel(),
        child: AnimatedOpacity(
            opacity: mostrar ? 1 : 0,
            duration: const Duration(milliseconds: 250),
            child: _PinterestMenuBackground(
              child: _MenuItems(items, activeColor, secondaryColor),
              backgroundColor: backgroundColor,
            )));
  }
}

class _PinterestMenuBackground extends StatelessWidget {
  const _PinterestMenuBackground(
      {required this.child, required this.backgroundColor});

  final Widget child;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: child,
        width: 250,
        height: 60,
        decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: const BorderRadius.all(Radius.circular(100)),
            boxShadow: const [
              BoxShadow(
                  color: Colors.black38,
                  offset: Offset(0, 0),
                  blurRadius: 10,
                  spreadRadius: -5)
            ]));
  }
}

class _MenuItems extends StatelessWidget {
  const _MenuItems(this.menuItems, this.activeColor, this.secondaryColor);

  final List<PinterestButton> menuItems;
  final Color activeColor;
  final Color secondaryColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(
          menuItems.length,
          (index) => _PinterestMenuButton(
              index, menuItems[index], activeColor, secondaryColor)),
    );
  }
}

class _PinterestMenuButton extends StatelessWidget {
  const _PinterestMenuButton(
      this.index, this.item, this.activeColor, this.secondaryColor);

  final int index;
  final PinterestButton item;
  final Color activeColor;
  final Color secondaryColor;

  @override
  Widget build(BuildContext context) {
    final itemSeleccionado = Provider.of<_MenuModel>(context).indexSeleccionado;
    final isCurrentItem = itemSeleccionado == index;

    return GestureDetector(
      onTap: () {
        Provider.of<_MenuModel>(context, listen: false).indexSeleccionado =
            index;
        item.onPressed();
      },
      behavior: HitTestBehavior.translucent,
      child: Icon(
        item.icon,
        size: isCurrentItem ? 32 : 26,
        color: isCurrentItem ? activeColor : secondaryColor,
      ),
    );
  }
}

class _MenuModel with ChangeNotifier {
  int _indexSeleccionado = 0;

  int get indexSeleccionado => _indexSeleccionado;
  set indexSeleccionado(int value) {
    _indexSeleccionado = value;
    notifyListeners();
  }
}
