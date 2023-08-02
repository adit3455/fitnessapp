import 'package:fitness_app/widgets/custom_button_widget.dart';
import 'package:fitness_app/widgets/custom_text_form_field_widget.dart';
import 'package:fitness_app/widgets/title_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../blocs/my_training_bloc/my_training_bloc.dart';
import '../../utils/app_utils.dart';

class AccomodateExercisePage extends StatelessWidget {
  const AccomodateExercisePage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController tController = TextEditingController();
    return BlocBuilder<MyTrainingBloc, MyTrainingState>(
      builder: (context, state) {
        return Scaffold(
          floatingActionButton: CustomButtonWidget(
            labelButton: "Add",
            icon: Icons.add,
            onPressed: () => Navigator.pop(context),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          appBar: AppBar(
            centerTitle: true,
            leading: const SizedBox(),
            title: const TitleAppBar(leftText: "My", rightText: "Training"),
            actions: [
              InkWell(
                  onTap: () {
                    showDialog(
                      useSafeArea: true,
                      context: context,
                      builder: (context) => AlertDialog(
                          elevation: 2,
                          contentPadding: const EdgeInsets.all(20.0),
                          title: const Text("Name Your Plan"),
                          content: CustomTextFormFieldWidget(
                              label: "Name your plan",
                              textEditingController: tController,
                              icon: Icons.save_outlined),
                          actions: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _buttonProfile(
                                  context,
                                  labelButton: "Cancel",
                                  onPressed: () => Navigator.pop(context),
                                ),
                                const SizedBox(width: 10.0),
                                _buttonProfile(
                                  context,
                                  labelButton: "Save",
                                  onPressed: () {
                                    if (tController.text.isEmpty) {
                                      Navigator.pop(context);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content: Text(
                                                  "you must fill the form!")));
                                    }
                                    if ((state as AddExerciseState)
                                            .lAccomodateAdd
                                            .length <
                                        3) {
                                      Navigator.pop(context);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content: Text(
                                                  "Set your exercise more than 3 to make your exercise better")));
                                    }

                                    if (tController.text.isNotEmpty &&
                                        (state).lAccomodateAdd.length >= 3) {
                                      context.read<MyTrainingBloc>().add(
                                          SaveTraining(
                                              name: tController.text,
                                              lExercises:
                                                  (state).lAccomodateAdd));
                                      Navigator.pushNamedAndRemoveUntil(
                                          context, '/', (route) => false);
                                    }
                                  },
                                ),
                              ],
                            ),
                          ]),
                    );
                  },
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
          body: SingleChildScrollView(
            child: Column(
              children: [
                if (state is AddExerciseState) ...[
                  _rowTop(context, state.lAccomodateAdd.length),
                  ListView.separated(
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 10.0),
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: state.lAccomodateAdd.length,
                      itemBuilder: (context, index) {
                        final iAccomodate = state.lAccomodateAdd[index];

                        return _cardAccomodate(context,
                            image: iAccomodate.image,
                            title: iAccomodate.name,
                            subTitle: iAccomodate.duration!, function: () {
                          context.read<MyTrainingBloc>().add(
                              RemoveAccomodateExerciseEvent(
                                  exerciseModel: state.lAccomodateAdd[index]));
                        });
                      }),
                  const SizedBox(height: 100.0),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  Row _cardAccomodate(BuildContext context,
      {required String image,
      required String title,
      required String subTitle,
      required void Function()? function}) {
    return Row(mainAxisSize: MainAxisSize.max, children: [
      const SizedBox(width: 10.0),
      const SizedBox(width: 10.0),
      Expanded(
        flex: 3,
        child: ClipRRect(
            borderRadius: BorderRadius.circular(30.0),
            child: Image.network(image,
                height: 80.h, width: 80.w, fit: BoxFit.fill)),
      ),
      const SizedBox(width: 10.0),
      Expanded(
          flex: 6,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(title, style: Theme.of(context).textTheme.headlineSmall),
            Text(subTitle.replaceAll(".", ":"),
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: Colors.blue)),
          ])),
      Expanded(
          child: IconButton(
              onPressed: function,
              icon: const Icon(Icons.remove_circle_outline))),
      const SizedBox(width: 10.0),
    ]);
  }

  Padding _rowTop(BuildContext context, int length) {
    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(children: [
          Text("Exercises",
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(width: 5.0),
          Text("($length)",
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.bold, color: Colors.grey.shade500))
        ]));
  }

  TextButton _buttonProfile(BuildContext context,
      {void Function()? onPressed, required String labelButton}) {
    return TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
            backgroundColor: AppUtils.appbarBackgroundColor,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
        child: Text(labelButton,
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: Colors.white, fontWeight: FontWeight.bold)));
  }
}
