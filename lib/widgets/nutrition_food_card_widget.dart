import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_utils.dart';
import 'custom_container_button.dart';

class NutritionFoodCardWidget extends StatelessWidget {
  final String title;
  final String subTitle;
  final String image;
  final void Function()? onTap;
  final Widget? trailing;
  const NutritionFoodCardWidget(
      {super.key,
      required this.title,
      required this.subTitle,
      required this.image,
      this.onTap,
      this.trailing});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: ListTile(
        onTap: onTap,
        splashColor: AppUtils.gradientRightBackgroundColor,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        // tileColor: Colors.grey.shade300,
        contentPadding: const EdgeInsets.all(10.0),
        title: Text(title,
            style: Theme.of(context)
                .textTheme
                .headlineSmall!
                .copyWith(color: Colors.blueAccent)),
        subtitle: Text(subTitle,
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: Colors.black)),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child:
              Image.network(width: 50.w, height: 50.h, fit: BoxFit.fill, image),
        ),
        trailing: trailing ??
            const CustomContainerButton(iconData: Icons.arrow_right),
      ),
    );
  }
}
