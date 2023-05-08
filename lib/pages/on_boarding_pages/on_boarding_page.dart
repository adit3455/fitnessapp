import 'package:fitness_app/utils/export_utils.dart';
import 'package:flutter/material.dart';
import 'package:onboarding/onboarding.dart';

import '../../widgets/export_widgets.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    int index = 0;
    final onBoardingPageList = [
      PageModel(
          widget: const OnBoardingWidget(
              headlineText: "Track Your Goals",
              imageAsset: AssetsUtil.senamGirl,
              bodyText:
                  "Don't worry if you have trouble determining your goals, We can help you determine your goals and track your goals")),
      PageModel(
          widget: const OnBoardingWidget(
              headlineText: "Get Burn",
              imageAsset: AssetsUtil.runBoy,
              bodyText:
                  "Let’s keep burning, to achive yours goals, it hurts only temporarily, if you give up now you will be in pain forever")),
      PageModel(
          widget: const OnBoardingWidget(
              headlineText: "Improve Sleep Quality",
              imageAsset: AssetsUtil.foodBoy,
              bodyText:
                  "Improve the quality of your sleep with us, good quality sleep can bring a good mood in the morning")),
    ];

    return Scaffold(
      body: SafeArea(
          child: Onboarding(
        onPageChange: (pageIndex) {
          index = pageIndex;
        },
        pages: onBoardingPageList,
        startPageIndex: 0,
        footerBuilder: (context, netDragDistance, pagesLength, setIndex) {
          return DecoratedBox(
            decoration: BoxDecoration(
              color: AppUtils.gradientRightBackgroundColor,
              border: Border.all(
                width: 0.0,
                color: AppUtils.gradientRightBackgroundColor,
              ),
            ),
            child: ColoredBox(
              color: AppUtils.gradientRightBackgroundColor,
              child: Padding(
                padding: const EdgeInsets.all(45.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomIndicator(
                      shouldPaint: true,
                      netDragPercent: netDragDistance,
                      pagesLength: pagesLength,
                      indicator: Indicator(
                        indicatorDesign: IndicatorDesign.line(
                          lineDesign: LineDesign(
                            lineSpacer: 24,
                            lineType: DesignType.line_nonuniform,
                          ),
                        ),
                      ),
                    ),
                    index == pagesLength - 1
                        ? TextButton(
                            onPressed: () =>
                                Navigator.pushNamed(context, '/login'),
                            child: const Text("Continue"))
                        : TextButton(
                            onPressed: () {
                              index = index + 1;
                              return setIndex(index);
                            },
                            child: const Text("Skip"))
                  ],
                ),
              ),
            ),
          );
        },
      )),
    );
  }
}
