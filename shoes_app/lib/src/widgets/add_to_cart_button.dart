import 'package:flutter/material.dart';
import 'package:shoes_app/src/widgets/widgets.dart';

class AddToCartButton extends StatelessWidget {
  final double ammount;
  const AddToCartButton({Key? key, required this.ammount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        height: 80,
        decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.1),
            borderRadius: BorderRadius.circular(100)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "\$$ammount",
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const OrangeButton(text: "Add to cart")
          ],
        ),
      ),
    );
  }
}
