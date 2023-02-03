import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoes_app/src/models/shoe_model.dart';
import 'package:shoes_app/src/pages/shoe_details_page.dart';

class ShoeSizePreview extends StatelessWidget {
  const ShoeSizePreview({Key? key, this.fullScreen = false}) : super(key: key);

  final bool fullScreen;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: fullScreen
          ? null
          : () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          const ShoeDetailsPage()));
            },
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: fullScreen ? 5 : 20, vertical: fullScreen ? 5 : 5),
        child: Container(
          width: double.infinity,
          height: fullScreen ? 400 : 430,
          decoration: BoxDecoration(
              color: const Color(0xffFFCF53),
              borderRadius: fullScreen
                  ? const BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50),
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))
                  : BorderRadius.circular(40)),
          child: Column(children: [
            const _ShoeWithShadow(),
            if (!fullScreen) const _ShoeSizes()
          ]),
        ),
      ),
    );
  }
}

class _ShoeSizes extends StatelessWidget {
  const _ShoeSizes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: const [
          _ShoeSizeBox(
            size: 7,
          ),
          _ShoeSizeBox(
            size: 7.5,
          ),
          _ShoeSizeBox(
            size: 8,
          ),
          _ShoeSizeBox(
            size: 8.5,
          ),
          _ShoeSizeBox(
            size: 9,
          ),
          _ShoeSizeBox(
            size: 9.5,
          ),
        ],
      ),
    );
  }
}

class _ShoeSizeBox extends StatelessWidget {
  final double size;

  const _ShoeSizeBox({
    Key? key,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final shoeModel = Provider.of<ShoeModel>(context);
    final selected = size == shoeModel.size;
    return GestureDetector(
      onTap: () {
        shoeModel.size = size;
      },
      child: Container(
        width: 45,
        height: 45,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: selected ? const Color(0xffEAA14E) : Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              if (selected)
                const BoxShadow(
                    color: Color(0xffF1A23A),
                    blurRadius: 14,
                    offset: Offset(0, 6))
            ]),
        child: Text(
          size.toString().replaceAll('.0', ''),
          style: TextStyle(
              color: selected ? Colors.white : const Color(0xffF1A23A),
              fontSize: 16,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class _ShoeWithShadow extends StatelessWidget {
  const _ShoeWithShadow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final shoeModel = Provider.of<ShoeModel>(context);
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Stack(
        children: [
          const Positioned(bottom: 10, right: 0, child: _ShoeShadow()),
          Image(image: AssetImage(shoeModel.assetImage))
        ],
      ),
    );
  }
}

class _ShoeShadow extends StatelessWidget {
  const _ShoeShadow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: -0.5,
      child: Container(
        width: 230,
        height: 100,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            boxShadow: const [
              BoxShadow(color: Color(0xffEAA14E), blurRadius: 40)
            ]),
      ),
    );
  }
}
