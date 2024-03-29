import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_utils.dart';
import 'custom_container_button.dart';

class CustomCardHomePage extends StatelessWidget {
  final String image;
  final String labelText;
  final void Function()? onPressed;

  const CustomCardHomePage({
    this.onPressed,
    required this.image,
    required this.labelText,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppUtils.appbarBackgroundColor,
      borderRadius: BorderRadius.circular(15.0),
      child: InkWell(
        splashColor: AppUtils.gradientRightBackgroundColor,
        onTap: onPressed,
        borderRadius: BorderRadius.circular(15.0),
        child: Container(
          padding: const EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(width: 5.w),
              const CustomContainerButton(iconData: Icons.info_outline_rounded),
              Container(
                width: 180.w,
                margin: EdgeInsets.all(10.h),
                padding: const EdgeInsets.all(1),
                child: Text(labelText,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Colors.white, fontWeight: FontWeight.w600)),
              ),
              Container(
                  width: 60.h,
                  height: 80.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18.0.h),
                      image: DecorationImage(
                          fit: BoxFit.cover, image: AssetImage(image))))
            ],
          ),
        ),
      ),
    );
  }
}
