import 'package:flutter/material.dart';
import 'package:todonew/generated/assets.dart';

class AttachList extends StatelessWidget {
  AttachList({
    super.key,
    required this.size,
  });

  final Size size;
  double width = 0;
  @override
  Widget build(BuildContext context) {
    width = size.width;
    if (width > 500) {
      width = 500;
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(
        (width - 40) ~/ 40,
        (index) => Image.asset(Assets.imagesImg, width: 40, height: 40),
      ),
    );
  }
}
