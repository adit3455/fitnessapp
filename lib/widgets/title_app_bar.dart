import 'package:flutter/material.dart';

import '../utils/export_utils.dart';

class TitleAppBar extends StatelessWidget {
  const TitleAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.start,
        text: TextSpan(
            style: Theme.of(context)
                .textTheme
                .displaySmall!
                .copyWith(fontWeight: FontWeight.bold),
            text: "Fitness",
            children: [
              TextSpan(
                  style: TextStyle(
                      color: AppUtils.appbarBackgroundColor, fontSize: 30.h),
                  text: ' App')
            ]));
  }
}
