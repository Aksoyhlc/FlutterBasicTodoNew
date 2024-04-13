import 'package:flutter/material.dart';
import 'package:todonew/Const/const.dart';

class CustomInput extends StatefulWidget {
  const CustomInput({
    super.key,
    required this.hintText,
    required this.onChanged,
    required this.validator,
    this.initialValue,
    this.maxLines = 1,
  });
  final String hintText;
  final Function(String value) onChanged;
  final String? Function(String value) validator;
  final String? initialValue;
  final int maxLines;

  @override
  State<CustomInput> createState() => _CustomInputState();
}

class _CustomInputState extends State<CustomInput> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: whiteColor,
        border: Border.all(
          color: primaryColor.withOpacity(.5),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: primaryColor.withOpacity(.2),
            offset: const Offset(0, 3),
            blurRadius: 3,
          )
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: TextFormField(
        initialValue: widget.initialValue,
        maxLines: widget.maxLines,
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: TextStyle(
            color: Colors.grey.withOpacity(.4),
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.zero,
          isDense: true,
        ),
        style: const TextStyle(
          color: primaryColor,
        ),
        onChanged: (value) {
          widget.onChanged(value);
        },
        validator: (value) {
          return widget.validator(value ?? "");
        },
      ),
    );
  }
}
