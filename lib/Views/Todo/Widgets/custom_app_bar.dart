import 'package:flutter/material.dart';
import 'package:todonew/Const/const.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: whiteColor.withOpacity(0.5),
            offset: const Offset(0, 3),
            blurRadius: 15,
          )
        ],
      ),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Padding(
              padding: EdgeInsets.all(15),
              child: Icon(
                Icons.arrow_back,
                color: primaryColor,
                size: 30,
              ),
            ),
          )
        ],
      ),
    );
  }
}
