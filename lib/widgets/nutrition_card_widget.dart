import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_utils.dart';

class NutritionCardWidget extends StatelessWidget {
  final String image;
  final String title;
  final void Function()? onTap;
  const NutritionCardWidget(
      {required this.image,
      required this.title,
      required this.onTap,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5.0),
      child: Material(
        color: AppUtils.appbarBackgroundColor,
        borderRadius: BorderRadius.circular(20.0),
        child: InkWell(
          borderRadius: BorderRadius.circular(20.0),
          splashColor: AppUtils.gradientRightBackgroundColor,
          onTap: onTap,
          child: Container(
            width: 90.w,
            decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    width: 60.w,
                    height: 60.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        image: DecorationImage(
                            fit: BoxFit.fill, image: NetworkImage(image)))),
                const SizedBox(height: 10.0),
                Text(title,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
