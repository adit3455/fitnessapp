import 'package:flutter/material.dart';

import '../utils/export_utils.dart';

class StartFitnessWidget extends StatelessWidget {
  final void Function()? onTap;
  final String? imageNetwork;
  final String? title;
  final Widget? subTitle;
  final String? labelButton;
  final bool isUserImageNetwork;
  const StartFitnessWidget({
    this.isUserImageNetwork = false,
    this.onTap,
    this.title,
    this.subTitle,
    this.imageNetwork,
    this.labelButton,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppUtils.appbarBackgroundColor,
      borderRadius: BorderRadius.circular(20.0),
      child: InkWell(
        splashColor: AppUtils.gradientRightBackgroundColor,
        borderRadius: BorderRadius.circular(20.0),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(1.0),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
          child: Container(
            margin: EdgeInsets.all(5.h),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      margin: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 160.w,
                              child: Text(title ?? "Day 01 - Fitness",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall!
                                      .copyWith(color: Colors.white)),
                            ),
                            SizedBox(height: 3.h),
                            subTitle ??
                                Text("Mon 26 Apr",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall!
                                        .copyWith(color: Colors.white)),
                            Container(
                                margin:
                                    EdgeInsets.only(top: 10.0.h, left: 20.0.w),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 40.w, vertical: 5.h),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.0),
                                    color: Colors.white),
                                child: Text(labelButton ?? "Start",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium!
                                        .copyWith(
                                            color: AppUtils
                                                .appbarBackgroundColor)))
                          ])),
                  isUserImageNetwork == true
                      ? Container(
                          width: 150.w,
                          height: 150.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image:
                                      NetworkImage(imageNetwork.toString()))))
                      : Container(
                          width: 150.w,
                          height: 150.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              image: const DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                      AssetsUtil.exerciseTransparent)))),
                ]),
          ),
        ),
      ),
    );
  }
}
