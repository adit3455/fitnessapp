import 'package:fitness_app/utils/export_utils.dart';
import 'package:flutter/material.dart';

import 'export_widgets.dart';

class WeeklyReminderWidget extends StatelessWidget {
  const WeeklyReminderWidget({
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
              Container(
                  width: 70.w,
                  height: 70.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      image: const DecorationImage(
                          fit: BoxFit.fitWidth,
                          image:
                              AssetImage(AssetsUtil.peopleExerciseForWeekly)))),
              Container(
                  padding: EdgeInsets.all(2.0.h),
                  width: 180.w,
                  child: Text("Set weekly goal for your Workout to max!",
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(color: Colors.white))),
              const CustomContainerButton(
                iconData: Icons.add,
              )
            ],
          ),
        ),
      ),
    );
  }
}
