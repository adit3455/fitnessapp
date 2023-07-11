import 'package:fitness_app/widgets/custom_button_widget.dart';
import 'package:fitness_app/widgets/title_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../models/exercises_model.dart';

class AccomodateExercisePage extends StatelessWidget {
  final List<ExerciseModel> exercises;
  const AccomodateExercisePage({required this.exercises, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: CustomButtonWidget(
        labelButton: "Add",
        icon: Icons.add,
        onPressed: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
        title: const TitleAppBar(leftText: "My", rightText: "Training"),
        actions: [
          InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(30.0),
              child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "Save",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: Colors.blue),
                  )))
        ],
      ),
      body: Column(
        children: [
          Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(children: [
                Text("Exercises",
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall!
                        .copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(width: 5.0),
                Text("(1)",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade500))
              ])),
          Row(mainAxisSize: MainAxisSize.max, children: [
            const SizedBox(width: 10.0),
            const SizedBox(width: 10.0),
            Expanded(
              flex: 3,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(30.0),
                  child: Image.network(
                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRK7-eUNpa8F3qc-24cF7NjWmENP9BnE7tnDnSdp7C20g&s",
                      height: 80.h,
                      width: 80.w,
                      fit: BoxFit.fill)),
            ),
            const SizedBox(width: 10.0),
            Expanded(
                flex: 6,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Something",
                          style: Theme.of(context).textTheme.headlineSmall),
                      Text("60.00".replaceAll(".", ":"),
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(color: Colors.blue)),
                    ])),
            Expanded(
                child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.remove_circle_outline))),
            const SizedBox(width: 10.0),
          ])
        ],
      ),
    );
  }
}
