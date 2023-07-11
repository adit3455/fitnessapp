import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButtonWidget extends StatelessWidget {
  final String labelButton;
  final IconData icon;
  final void Function()? onPressed;
  final double? width;
  const CustomButtonWidget({
    required this.labelButton,
    this.width,
    required this.icon,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? 280.w,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white),
            SizedBox(width: 10.w),
            Text(labelButton, style: const TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }
}
