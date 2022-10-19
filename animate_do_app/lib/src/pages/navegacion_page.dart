import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class NavegacionPage extends StatelessWidget {
  const NavegacionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _NotificationModel(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Notifications Page"),
          backgroundColor: Colors.pink,
        ),
        floatingActionButton: const BotonFlotante(),
        bottomNavigationBar: const BottomNavigation(),
      ),
    );
  }
}

class BotonFlotante extends StatelessWidget {
  const BotonFlotante({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        final notificationModel =
            Provider.of<_NotificationModel>(context, listen: false);
        notificationModel.numero++;

        if (notificationModel.numero >= 2) {
          notificationModel.bounceController.forward(from: 0.0);
        }
      },
      backgroundColor: Colors.pink,
      child: const FaIcon(FontAwesomeIcons.play),
    );
  }
}

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final int numero = Provider.of<_NotificationModel>(context).numero;

    return BottomNavigationBar(
      currentIndex: 0,
      selectedItemColor: Colors.pink,
      items: [
        const BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.bone), label: "Bones"),
        BottomNavigationBarItem(
            icon: Stack(
              children: [
                const FaIcon(FontAwesomeIcons.bell),
                Positioned(
                    top: 0.0,
                    right: 0.0,
                    child: BounceInDown(
                      from: 10,
                      duration: const Duration(milliseconds: 600),
                      animate: numero > 0,
                      child: Bounce(
                        from: 10,
                        duration: const Duration(milliseconds: 600),
                        controller: (AnimationController controller) =>
                            Provider.of<_NotificationModel>(context)
                                .bounceController = controller,
                        child: Container(
                          alignment: Alignment.center,
                          width: 12,
                          height: 12,
                          decoration: const BoxDecoration(
                              color: Colors.redAccent, shape: BoxShape.circle),
                          child: Text("$numero",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 8,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ))
              ],
            ),
            label: "Notificationss"),
        const BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.dog), label: "My Dog")
      ],
    );
  }
}

class _NotificationModel extends ChangeNotifier {
  int _numero = 0;
  late AnimationController bounceController;

  int get numero => _numero;

  set numero(int valor) {
    _numero = valor;
    notifyListeners();
  }
}
