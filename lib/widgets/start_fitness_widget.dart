import 'package:flutter/material.dart';

import '../utils/export_utils.dart';

class StartFitnessWidget extends StatelessWidget {
  final void Function()? onTap;
  const StartFitnessWidget({
    this.onTap,
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
          height: 160.h,
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
                        Text("Day 01 - Fitness",
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .copyWith(color: Colors.white)),
                        SizedBox(height: 3.h),
                        Text("Mon 26 Apr",
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .copyWith(color: Colors.white)),
                        Container(
                            margin: EdgeInsets.only(top: 10.0.h, left: 20.0.w),
                            padding: EdgeInsets.symmetric(
                                horizontal: 40.w, vertical: 5.h),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                color: Colors.white),
                            child: Text("Start",
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium!
                                    .copyWith(
                                        color: AppUtils.appbarBackgroundColor)))
                      ],
                    ),
                  ),
                  Container(
                      width: 150.w,
                      height: 150.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          image: const DecorationImage(
                              fit: BoxFit.cover,
                              image:
                                  AssetImage(AssetsUtil.exerciseTransparent)))),
                ]),
          ),
        ),
      ),
    );
  }
}
