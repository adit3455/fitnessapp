import 'package:fitness_app/blocs/export_blocs.dart';
import 'package:fitness_app/repository/firebase_service/workout_before_18_service.dart';
import 'package:fitness_app/widgets/export_widgets.dart';
import 'package:flutter/material.dart';

import '../../utils/export_utils.dart';

class WorkOutBeforeEighteenPage extends StatelessWidget {
  const WorkOutBeforeEighteenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const TitleAppBar(leftText: "WorkOut Before", rightText: "18"),
      ),
      body: SingleChildScrollView(
        child: BlocProvider(
          create: (context) => FetchWorkOutBeforeEighteenBloc(
              beforeEighteenService: WorkoutBeforeEighteenService())
            ..add(LoadBefore18()),
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
                                AssetsUtil.eighteenPerson))),
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
                  child: BlocConsumer<FetchWorkOutBeforeEighteenBloc,
                      FetchWorkOutBeforeEighteenState>(
                    listener: (context, state) {
                      if (state is Before18Error) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text(state.error)));
                      }
                    },
                    builder: (context, state) {
                      if (state is Before18Loading) {
                        return const LoadingWidget(count: 10);
                      }
                      if (state is Before18Loaded) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const CustomBoldTitle(title: "Work Out Before 18"),
                            ...List.generate(
                                state.before18model.bennefitBullet!.length,
                                (index) => BulletText(
                                    text: state
                                        .before18model.bennefitBullet![index])),
                            const SizedBox(height: 5.0),
                            Container(
                                margin: EdgeInsets.all(5.h),
                                padding: const EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.0),
                                    color: Colors.grey.shade300),
                                child: Text(
                                    "${state.before18model.description}",
                                    style:
                                        Theme.of(context).textTheme.bodyLarge)),
                          ],
                        );
                      }
                      return const Text("Theres Something Wrong");
                    },
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
