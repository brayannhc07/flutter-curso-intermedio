import 'package:flutter/material.dart';
import 'package:shoes_app/src/helpers/helpers.dart';
import 'package:shoes_app/src/widgets/widgets.dart';

class ShoePage extends StatelessWidget {
  const ShoePage({super.key});

  @override
  Widget build(BuildContext context) {
    cambiarStatusDark();
    return Scaffold(
        body: Column(
      children: [
        const CustomAppbar(
          text: "For you",
        ),
        const SizedBox(
          height: 10,
        ),
        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: const [
                Hero(tag: "shoe-preview-1", child: ShoeSizePreview()),
                ShoeDescription(
                    title: "Nike Air Max 720",
                    description:
                        "The Nike Air Max 720 goes bigger than ever before with Nike's taller Air unit yet, offering more air underfoot for unimaginable, all-day ")
              ],
            ),
          ),
        ),
        const AddToCartButton(ammount: 180.0)
      ],
    ));
  }
}
