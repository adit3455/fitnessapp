import 'package:flutter/material.dart';

class CustomBoldTitle extends StatelessWidget {
  final String title;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final double paddingSize;
  final Color? textColor;
  const CustomBoldTitle(
      {super.key,
      this.textColor,
      this.paddingSize = 8,
      required this.title,
      this.textAlign,
      this.fontSize,
      this.fontWeight});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(paddingSize),
      child: Text(title,
          textAlign: textAlign ?? TextAlign.start,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
              fontWeight: fontWeight ?? FontWeight.bold,
              fontSize: fontSize ?? 27,
              color: textColor ?? Colors.black)),
    );
  }
}
