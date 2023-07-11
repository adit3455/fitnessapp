import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BulletText extends StatelessWidget {
  final String text;
  const BulletText({
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text(
          "•",
          style: TextStyle(fontSize: 30.0),
        ),
        const SizedBox(width: 5.0),
        Container(
          width: 320.w,
          padding: const EdgeInsets.all(1.0),
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        )
      ],
    );
  }
}
