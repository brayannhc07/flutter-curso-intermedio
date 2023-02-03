import 'package:flutter/material.dart';

class OrangeButton extends StatelessWidget {
  final String text;
  final double width;
  final double height;
  final Color color;

  const OrangeButton(
      {Key? key,
      required this.text,
      this.width = 150,
      this.height = 50,
      this.color = Colors.orange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: width,
      height: height,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(100), color: color),
      child: Text(
        text,
        style:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
      ),
    );
  }
}
