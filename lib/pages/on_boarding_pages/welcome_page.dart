import 'package:fitness_app/utils/export_utils.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [
            AppUtils.appbarBackgroundColor,
            AppUtils.gradientRightBackgroundColor
          ]))),
          Positioned(
              bottom: 300.h,
              left: 90.w,
              child: Column(children: [
                RichText(
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.start,
                    text: TextSpan(
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium!
                            .copyWith(fontWeight: FontWeight.bold),
                        text: "Fitness",
                        children: [
                          TextSpan(
                              style: TextStyle(
                                  color: Colors.white, fontSize: 30.h),
                              text: ' App')
                        ])),
                Text("Everybody Can Train",
                    style: TextStyle(fontSize: 20.h, color: Colors.grey[700])),
              ])),
          Positioned(
              left: 40.w,
              right: 40.w,
              bottom: 50.h,
              child: Container(
                margin: const EdgeInsets.all(10),
                child: TextButton(
                    onPressed: () => Navigator.pushNamed(context, '/boarding'),
                    child: const Text("Get Started")),
              )),
        ],
      ),
    );
  }
}
