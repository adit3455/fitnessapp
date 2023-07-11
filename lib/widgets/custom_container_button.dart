import 'package:fitness_app/utils/app_utils.dart';
import 'package:flutter/material.dart';

class CustomContainerButton extends StatelessWidget {
  final IconData iconData;
  final Color? colorData;
  final Color? backgroundColor;
  const CustomContainerButton({
    this.backgroundColor,
    this.colorData,
    required this.iconData,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: backgroundColor ?? Colors.white),
      child: Icon(
        iconData,
        color: colorData ?? AppUtils.appbarBackgroundColor,
      ),
    );
  }
}
