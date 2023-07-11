import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnBoardingWidget extends StatelessWidget {
  final String headlineText;
  final String bodyText;
  final String imageAsset;
  const OnBoardingWidget(
      {required this.imageAsset,
      required this.headlineText,
      required this.bodyText,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 300.h,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(imageAsset), fit: BoxFit.cover)),
        ),
        Container(
          margin: const EdgeInsets.all(10.0),
          padding: EdgeInsets.all(5.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                headlineText,
                style: Theme.of(context)
                    .textTheme
                    .displayLarge!
                    .copyWith(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Text(bodyText),
            ],
          ),
        ),
      ],
    );
  }
}
