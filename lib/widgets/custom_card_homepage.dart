import 'package:flutter/material.dart';

import '../utils/export_utils.dart';
import 'export_widgets.dart';

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
      borderRadius: BorderRadius.circular(20.0),
      child: InkWell(
        splashColor: AppUtils.gradientRightBackgroundColor,
        onTap: onPressed,
        borderRadius: BorderRadius.circular(20.0),
        child: Container(
          height: 130.h,
          padding: const EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 180.w,
                margin: EdgeInsets.all(10.h),
                padding: const EdgeInsets.all(1),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomContainerButton(
                        iconData: Icons.info_outline_rounded),
                    SizedBox(height: 10.h),
                    Text(labelText,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Colors.white, fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
              Container(
                  width: 100.h,
                  height: 120.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0.h),
                      image: DecorationImage(
                          fit: BoxFit.cover, image: AssetImage(image))))
            ],
          ),
        ),
      ),
    );
  }
}
