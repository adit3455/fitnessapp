import 'package:flutter/material.dart';

class CustomBoldTitle extends StatelessWidget {
  final String title;
  final double? fontSize;
  final FontWeight? fontWeight;

  const CustomBoldTitle(
      {super.key, required this.title, this.fontSize, this.fontWeight});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Text(title,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
              fontWeight: fontWeight ?? FontWeight.bold,
              fontSize: fontSize ?? 27)),
    );
  }
}
