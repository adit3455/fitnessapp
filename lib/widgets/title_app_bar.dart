import 'package:flutter/material.dart';

import '../utils/export_utils.dart';

class TitleAppBar extends StatelessWidget {
  final String leftText;
  final String rightText;
  final double? fontSize;
  const TitleAppBar({
    this.fontSize,
    required this.leftText,
    required this.rightText,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.start,
        text: TextSpan(
            style: Theme.of(context).textTheme.displaySmall!.copyWith(
                fontWeight: FontWeight.bold, fontSize: fontSize ?? 28.h),
            text: leftText,
            children: [
              TextSpan(
                  style: TextStyle(
                      color: AppUtils.appbarBackgroundColor,
                      fontSize: fontSize ?? 30.h),
                  text: ' $rightText')
            ]));
  }
}
