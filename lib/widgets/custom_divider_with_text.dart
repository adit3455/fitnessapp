import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDividerWithText extends StatelessWidget {
  final String text;
  const CustomDividerWithText({
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      const Expanded(child: Divider()),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: Text(text),
      ),
      const Expanded(child: Divider()),
    ]);
  }
}
