import 'package:flutter/material.dart';

import '../../../utils/export_utils.dart';
import '../../../widgets/export_widgets.dart';

class FitnessDetail extends StatelessWidget {
  const FitnessDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const TitleAppBar(leftText: "Fitness", rightText: "Details"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                width: MediaQuery.of(context).size.width,
                height: 200.h,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(colors: [
                  AppUtils.appbarBackgroundColor,
                  AppUtils.gradientRightBackgroundColorDetailNutrition
                ])),
                child: Stack(children: [
                  Positioned(
                      top: 20.h,
                      left: 30.w,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: Image.asset(
                              fit: BoxFit.cover,
                              height: 200.h,
                              width: 300.w,
                              AssetsUtil.stopSmoking))),
                  Positioned(
                      bottom: -5.h,
                      child: Container(
                        height: 25.h,
                        width: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(30.0)),
                            color: Colors.white),
                      ))
                ])),
            Padding(
              padding: EdgeInsets.all(10.0.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomBoldTitle(title: "Fitness Detail"),
                  ...List.generate(
                      2, (index) => const BulletText(text: "adit Prasetia")),
                  const SizedBox(height: 5.0),
                  Container(
                      margin: EdgeInsets.all(5.h),
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Colors.grey.shade300),
                      child: Text("abcdefghijklmnopqrstuvwxyz",
                          style: Theme.of(context).textTheme.bodyLarge)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
