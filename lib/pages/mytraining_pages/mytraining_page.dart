import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:fitness_app/blocs/my_training_bloc/my_training_bloc.dart';
import 'package:fitness_app/utils/app_utils.dart';
import 'package:fitness_app/utils/assets_util.dart';
import 'package:fitness_app/widgets/custom_container_button.dart';
import 'package:fitness_app/widgets/title_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../models/exercises_model.dart';
import '../../models/menu_item.dart';
import '../../models/training_model.dart';
import '../../widgets/custom_button_widget.dart';
import '../../widgets/custom_text_form_field_widget.dart';

class MyTrainingPage extends StatefulWidget {
  final List<ExerciseModel> exercises;
  const MyTrainingPage({required this.exercises, super.key});

  @override
  State<MyTrainingPage> createState() => _MyTrainingPageState();
}

class _MyTrainingPageState extends State<MyTrainingPage> {
  TextEditingController tController = TextEditingController();
  @override
  void dispose() {
    tController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyTrainingBloc, MyTrainingState>(
      builder: (context, state) {
        return Scaffold(
            floatingActionButton: (state is MyTrainigGet)
                ? state.lTraining.isNotEmpty
                    ? CustomButtonWidget(
                        labelButton: "Add Exercises",
                        icon: Icons.add,
                        onPressed: () {
                          context
                              .read<MyTrainingBloc>()
                              .add(NavigateToAddExercise());
                          Navigator.pushNamed(context, '/addExercises',
                              arguments: widget.exercises);
                        })
                    : const SizedBox()
                : const SizedBox(),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            appBar: AppBar(
                title:
                    const TitleAppBar(leftText: "My", rightText: "Training")),
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (state is MyTrainingLoading) ...[
                    const Center(child: CircularProgressIndicator())
                  ],
                  if (state is MyTrainigGet) ...[
                    state.lTraining.isEmpty
                        ? Column(children: [
                            _alertTop(context),
                            const SizedBox(height: 250.0),
                            InkWell(
                                onTap: () {
                                  context
                                      .read<MyTrainingBloc>()
                                      .add(NavigateToAddExercise());
                                  Navigator.pushNamed(context, '/addExercises',
                                      arguments: widget.exercises);
                                },
                                child: const CustomContainerButton(
                                    iconData: Icons.add,
                                    backgroundColor:
                                        AppUtils.appbarBackgroundColor,
                                    colorData: Colors.white)),
                            const SizedBox(height: 10),
                            Text("Add Exercises",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                        color: Colors.grey.shade500,
                                        fontWeight: FontWeight.bold))
                          ])
                        : Column(
                            children: [
                              _alertTop(context),
                              ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: state.lTraining.length,
                                  itemBuilder: (context, index) =>
                                      _cardMyTraining(
                                        state,
                                        index,
                                        context,
                                        () {
                                          Navigator.pushNamed(
                                              context, '/startExercise',
                                              arguments: state
                                                  .lTraining[index].lExercises
                                                  .map((e) => e)
                                                  .toList());
                                        },
                                      )),
                            ],
                          )
                  ]
                ],
              ),
            ));
      },
    );
  }

  Material _cardMyTraining(
    MyTrainigGet state,
    int index,
    BuildContext context,
    void Function()? onTap,
  ) {
    return Material(
      color: Theme.of(context).colorScheme.surface,
      borderRadius: BorderRadius.circular(20.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(20.0),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(children: [
            Expanded(
              flex: 2,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Image.asset(AssetsUtil.runBoy,
                      fit: BoxFit.fill, height: 70.h, width: 70.w)),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              flex: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(state.lTraining[index].name,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontWeight: FontWeight.bold, fontSize: 20)),
                  Text("${state.lTraining[index].lExercises.length} Exercises",
                      style: Theme.of(context).textTheme.bodyLarge),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: DropdownButtonHideUnderline(
                  child: DropdownButton2(
                      customButton: const Icon(Icons.more_vert_outlined,
                          size: 25, color: Colors.grey),
                      items: MenuItemsMyTraining.firstItems
                          .map(
                            (item) => DropdownMenuItem<MenuItem>(
                              value: item,
                              child: MenuItemsMyTraining.buildItem(item),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        MenuItemsMyTraining().onChanged(context, value!,
                            state.lTraining[index], tController, index);
                      },
                      dropdownStyleData: DropdownStyleData(
                          width: 160,
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: Colors.white),
                          offset: const Offset(0, 8)),
                      menuItemStyleData: MenuItemStyleData(
                          customHeights: List<double>.filled(
                                  MenuItemsMyTraining.firstItems.length, 48)
                              .toList(),
                          padding:
                              const EdgeInsets.only(left: 16, right: 16)))),
            )
          ]),
        ),
      ),
    );
  }

  Card _alertTop(BuildContext context) {
    return Card(
        margin: const EdgeInsets.all(10.0),
        child: Container(
            padding: const EdgeInsets.all(10.0),
            width: MediaQuery.of(context).size.width,
            child: Row(children: [
              const Expanded(
                  flex: 1,
                  child:
                      Icon(Icons.notification_important_outlined, size: 30.0)),
              SizedBox(width: 10.w),
              Expanded(
                flex: 6,
                child: Container(
                    width: 270.w,
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      "Customize your own training plans base on your preferences!",
                      style: Theme.of(context).textTheme.bodyLarge,
                    )),
              )
            ])));
  }
}

class MenuItemsMyTraining {
  static const List<MenuItem> firstItems = [name, remove];

  static const name = MenuItem(text: 'Change Name', icon: Icons.person);
  static const remove =
      MenuItem(text: 'Remove', icon: Icons.remove_circle_outline);

  static Widget buildItem(MenuItem item) {
    return Row(
      children: [
        Icon(item.icon, color: AppUtils.appbarBackgroundColor, size: 22),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Text(
            item.text,
            style: const TextStyle(
              color: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }

  void onChanged(BuildContext context, MenuItem item, TrainingModel tModel,
      TextEditingController tController, int index) {
    switch (item) {
      case MenuItemsMyTraining.name:
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
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("you must fill the form!")));
                        }
                        if (tController.text.isNotEmpty) {
                          Navigator.pop(context);
                          context.read<MyTrainingBloc>().add(ChangeTrainingName(
                              name: tController.text, tModel: tModel));
                        }
                      },
                    ),
                  ],
                ),
              ]),
        );
        break;
      case MenuItemsMyTraining.remove:
        context.read<MyTrainingBloc>().add(RemoveGetTraininng(tModel: tModel));
        break;
    }
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
