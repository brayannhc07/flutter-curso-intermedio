import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoes_app/src/helpers/helpers.dart';
import 'package:shoes_app/src/models/shoe_model.dart';
import 'package:shoes_app/src/widgets/widgets.dart';

class ShoeDetailsPage extends StatelessWidget {
  const ShoeDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    cambiarStatusLight();
    return Scaffold(
        body: Column(
      children: [
        Stack(children: [
          const Hero(
              tag: "shoe-preview-1", child: ShoeSizePreview(fullScreen: true)),
          Positioned(
              top: 60,
              child: FloatingActionButton(
                onPressed: () {
                  cambiarStatusDark();
                  Navigator.pop(context);
                },
                backgroundColor: Colors.transparent,
                elevation: 0,
                highlightElevation: 0,
                child: const Icon(
                  Icons.chevron_left,
                  color: Colors.white,
                  size: 60,
                ),
              ))
        ]),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: const [
                ShoeDescription(
                    title: "Nike Air Max 720",
                    description:
                        "The Nike Air Max 720 goes bigger than ever before with Nike's taller Air unit yet, offering more air underfoot for unimaginable, all-day "),
                _AmmountBuyNow(),
                _ColorsSelection(),
                _LikeCartSettings()
              ],
            ),
          ),
        )
      ],
    ));
  }
}

class _LikeCartSettings extends StatelessWidget {
  const _LikeCartSettings({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 30),
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        const _ShadowedButton(
            icon: Icon(Icons.star, color: Colors.red, size: 25)),
        _ShadowedButton(
            icon: Icon(Icons.add_shopping_cart,
                color: Colors.grey.withOpacity(0.4), size: 25)),
        _ShadowedButton(
            icon: Icon(Icons.settings,
                color: Colors.grey.withOpacity(0.4), size: 25))
      ]),
    );
  }
}

class _ShadowedButton extends StatelessWidget {
  final Icon icon;

  const _ShadowedButton({
    Key? key,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 55,
      height: 55,
      decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
                color: Colors.black12,
                spreadRadius: -5,
                blurRadius: 20,
                offset: Offset(0, 10))
          ]),
      child: icon,
    );
  }
}

class _ColorsSelection extends StatelessWidget {
  const _ColorsSelection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        children: [
          Expanded(
              child: Stack(
            children: const [
              Positioned(
                  left: 90,
                  child: _ColorButton(
                    color: Color(0xff364D56),
                    index: 3,
                    assetUrl: "assets/img/negro.png",
                  )),
              Positioned(
                  left: 60,
                  child: _ColorButton(
                    color: Color(0xff2099f1),
                    index: 3,
                    assetUrl: "assets/img/azul.png",
                  )),
              Positioned(
                  left: 30,
                  child: _ColorButton(
                    color: Color(0xffffad29),
                    index: 2,
                    assetUrl: "assets/img/amarillo.png",
                  )),
              _ColorButton(
                color: Color(0xffc6d642),
                index: 1,
                assetUrl: "assets/img/verde.png",
              ),
            ],
          )),
          const OrangeButton(
              text: "More related items",
              height: 30,
              width: 170,
              color: Color(0xffffc675))
        ],
      ),
    );
  }
}

class _ColorButton extends StatelessWidget {
  final Color color;
  final int index;
  final String assetUrl;

  const _ColorButton({
    Key? key,
    required this.color,
    required this.index,
    required this.assetUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final shoeModel = Provider.of<ShoeModel>(context);
    return FadeInLeft(
      delay: Duration(microseconds: index * 100),
      duration: const Duration(milliseconds: 300),
      child: GestureDetector(
        onTap: () {
          shoeModel.assetImage = assetUrl;
        },
        child: Container(
          width: 45,
          height: 45,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
      ),
    );
  }
}

class _AmmountBuyNow extends StatelessWidget {
  const _AmmountBuyNow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "\$180.0",
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          Bounce(
            delay: const Duration(microseconds: 500),
            from: 4,
            child: const OrangeButton(
              text: "Buy Now",
              width: 120,
              height: 40,
            ),
          )
        ],
      ),
    );
  }
}
