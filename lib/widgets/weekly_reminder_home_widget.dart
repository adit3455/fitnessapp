import 'package:fitness_app/utils/export_utils.dart';
import 'package:flutter/material.dart';

class WeeklyReminderWidget extends StatelessWidget {
  final bool isAssetImage;
  final String image;
  final String title;
  final Widget? trailing;
  final BoxFit boxFit;

  const WeeklyReminderWidget({
    this.isAssetImage = true,
    required this.image,
    required this.title,
    this.trailing,
    this.boxFit = BoxFit.cover,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppUtils.appbarBackgroundColor,
      borderRadius: BorderRadius.circular(20.0.h),
      child: InkWell(
        borderRadius: BorderRadius.circular(20.0.h),
        onTap: () {},
        focusColor: AppUtils.gradientRightBackgroundColor,
        hoverColor: AppUtils.gradientRightBackgroundColor,
        splashColor: AppUtils.gradientRightBackgroundColor,
        child: Container(
          padding: EdgeInsets.all(10.0.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              isAssetImage == true
                  ? Container(
                      width: 70.w,
                      height: 70.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          image: DecorationImage(
                              fit: BoxFit.fitWidth, image: AssetImage(image))))
                  : Container(
                      width: 70.w,
                      height: 70.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          image: DecorationImage(
                              fit: boxFit, image: NetworkImage(image)))),
              Container(
                  padding: EdgeInsets.all(2.0.h),
                  width: 180.w,
                  child: Text(title,
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(color: Colors.white))),
              trailing ?? const SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}
