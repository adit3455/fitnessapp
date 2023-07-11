import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../models/export_model.dart';
import '../utils/app_utils.dart';
import 'custom_bold_title.dart';

class MoreFoodsDetailWidget extends StatelessWidget {
  const MoreFoodsDetailWidget(
      {super.key, required this.listFood, required this.index, this.onTap});

  final int index;
  final List<FoodModel> listFood;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: AppUtils.gradientRightBackgroundColor,
      child: Container(
          padding: EdgeInsets.all(3.h),
          margin: EdgeInsets.symmetric(horizontal: 5.w),
          width: 250.w,
          child: Stack(children: [
            Container(
                padding: const EdgeInsets.all(5.0),
                decoration:
                    const BoxDecoration(color: AppUtils.appbarBackgroundColor),
                child: Image.network(listFood[index].image,
                    width: 240.w, height: 120.h, fit: BoxFit.cover)),
            Positioned(
                // bottom: 8.h,
                top: 140.h,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 240.w,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomBoldTitle(
                                title: listFood[index].name, paddingSize: 0),
                            CustomBoldTitle(
                                title: listFood[index].type, paddingSize: 0),
                          ],
                        ),
                      ),
                      const SizedBox(height: 5),
                      SizedBox(
                        width: 240.w,
                        child: Text(listFood[index].calories,
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(letterSpacing: 0)),
                      ),
                    ]))
          ])),
    );
  }
}
