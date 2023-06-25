import 'package:fitness_app/utils/export_utils.dart';
import 'package:flutter/material.dart';

import '../../blocs/export_blocs.dart';
import '../../models/export_model.dart';
import '../../widgets/export_widgets.dart';

class OnExercisePage extends StatelessWidget {
  const OnExercisePage({super.key});
  String strDigits(int n) => n.toString().padLeft(2, '0');
  String minutes(Duration d) => strDigits(d.inMinutes.remainder(60));
  String seconds(Duration d) => strDigits(d.inSeconds.remainder(60));

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StartExerciseBloc, StartExerciseState>(
        listener: (context, state) {
      if (state is DoneExerciseState) {
        Navigator.pushNamed(context, '/doneExercise',
            arguments: state.accomodateExercise);
      }
    }, builder: (context, state) {
      if (state is NavigateExercise) {
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      }
      if (state is DoneExerciseState) {
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      }
      if (state is StartExerciseInitial) {
        return _onExercise(context,
            onPressedInfo: () {},
            onPressed: () => context.read<StartExerciseBloc>().add(StopExercise(
                duration: state.duration,
                index: state.index,
                exercises: state.exercises)),
            duration: state.duration,
            index: state.index,
            exercises: state.exercises);
      }
      if (state is PauseExercise) {
        return _onExercise(context,
            onPressed: () => context.read<StartExerciseBloc>().add(
                ResumeExercise(
                    duration: state.duration,
                    index: state.index,
                    exercises: state.exercises)),
            duration: state.duration,
            index: state.index,
            isPaused: true,
            onPressedInfo: () {},
            exercises: state.exercises);
      }
      if (state is RestExerciseState) {
        return Scaffold(
          backgroundColor: AppUtils.appbarBackgroundColor,
          body: SafeArea(
              child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(children: [
                SizedBox(
                    height: 300.h,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const CustomBoldTitle(
                              title: "REST", textColor: Colors.white),
                          Text(
                              "${minutes(state.duration)}:${seconds(state.duration)}",
                              style: Theme.of(context)
                                  .textTheme
                                  .displayLarge!
                                  .copyWith(color: Colors.white)),
                          SizedBox(height: 20.h),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                TextButton(
                                    onPressed: () => context
                                        .read<StartExerciseBloc>()
                                        .add(IncrementRestDuration(
                                            duration: state.duration,
                                            exercises: state.exercises,
                                            index: state.index)),
                                    child: const Text("+ 20 S")),
                                TextButton(
                                    onPressed: () => context
                                        .read<StartExerciseBloc>()
                                        .add(SkipExercise(
                                            exercises: state.exercises,
                                            index: state.index)),
                                    child: const Text("Skip")),
                              ])
                        ])),
                SizedBox(height: 50.h),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                "Next ${state.index + 1} / ${state.exercises.length}",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(color: Colors.white)),
                            Text(state.exercises[state.index].name,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(color: Colors.white))
                          ]),
                      Text(
                          state.exercises[state.index].duration!
                              .replaceAll(".", ":"),
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge!
                              .copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white))
                    ]),
                Container(
                    height: 220.h,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade400,
                        borderRadius: BorderRadius.circular(20.0)),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Image.network(state.exercises[state.index].image,
                            fit: BoxFit.fill, width: 200.w))),
              ]),
            ),
          )),
        );
      }
      return const Scaffold(
        body: Center(child: Text("Theres Something Wrong")),
      );
    });
  }

  WillPopScope _onExercise(BuildContext context,
      {required void Function()? onPressed,
      required Duration duration,
      required int index,
      bool isPaused = false,
      required void Function()? onPressedInfo,
      required List<ExerciseModel> exercises}) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
            leading: const SizedBox(),
            centerTitle: true,
            title: const TitleAppBar(leftText: "Ready to", rightText: "GO !!")),
        floatingActionButton:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          TextButton(
              onPressed: () => context
                  .read<StartExerciseBloc>()
                  .add(PreviousExercise(exercises: exercises, index: index)),
              child: const Text("Previous")),
          exercises.length - 1 != index
              ? TextButton(
                  onPressed: () => context
                      .read<StartExerciseBloc>()
                      .add(NextExercise(exercises: exercises, index: index)),
                  child: const Text("Next"))
              : TextButton(
                  onPressed: () => context
                      .read<StartExerciseBloc>()
                      .add(NextExercise(exercises: exercises, index: index)),
                  child: const Text("Done"))
        ]),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Container(
                  height: 300.h,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(20.0)),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Image.network(exercises[index].image,
                          fit: BoxFit.cover, height: 200.h, width: 200.w))),
              const SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      constraints: BoxConstraints(maxWidth: 280.w),
                      padding: const EdgeInsets.all(1),
                      child: CustomBoldTitle(title: exercises[index].name)),
                  IconButton(
                      onPressed: onPressedInfo,
                      icon: const Icon(Icons.info_outline,
                          color: AppUtils.appbarBackgroundColor))
                ],
              ),
              const SizedBox(height: 15.0),
              CustomBoldTitle(
                  title: "${minutes(duration)} : ${seconds(duration)}",
                  fontSize: 40,
                  fontWeight: FontWeight.w400),
              const SizedBox(height: 15.0),
              isPaused == false
                  ? CustomButtonWidget(
                      labelButton: "Paused",
                      icon: Icons.pause,
                      width: 150.w,
                      onPressed: onPressed)
                  : CustomButtonWidget(
                      labelButton: "Resumed",
                      icon: Icons.play_arrow,
                      width: 150.w,
                      onPressed: onPressed),
            ],
          ),
        ),
      ),
    );
  }
}
