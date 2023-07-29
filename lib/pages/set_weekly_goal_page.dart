import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:fitness_app/blocs/set_weekly_goal_bloc/set_weekly_goal_bloc.dart';
import 'package:fitness_app/repository/isar_repo/isar_set_weekly.dart';
import 'package:fitness_app/utils/assets_util.dart';
import 'package:fitness_app/widgets/custom_bold_title.dart';
import 'package:fitness_app/widgets/custom_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SetWeeklyGoalPage extends StatefulWidget {
  const SetWeeklyGoalPage({super.key});

  @override
  State<SetWeeklyGoalPage> createState() => _SetWeeklyGoalPageState();
}

class _SetWeeklyGoalPageState extends State<SetWeeklyGoalPage> {
  @override
  Widget build(BuildContext context) {
    final List<String> daysValue = [
      '1 Day',
      '2 Day',
      '3 Day',
      '4 Day',
      '5 Day',
      '6 Day',
      '7 Day'
    ];

    return BlocBuilder<SetWeeklyGoalBloc, SetWeeklyGoalState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(AssetsUtil.peopleExerciseForWeekly,
                      height: 100, width: 100, fit: BoxFit.cover),
                  const CustomBoldTitle(title: "SET YOUR WEEKLY GOAL"),
                  const SizedBox(height: 10),
                  SizedBox(
                      width: 350,
                      child: Text(
                          "We recommend training at least 3 days weekly for a better results",
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(color: Colors.grey))),
                  const SizedBox(height: 30),
                  if (state is SetWeeklyGoalSetWeekState) ...[
                    Text("Training Days",
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 5),
                    DropdownButtonHideUnderline(
                      child: DropdownButton2<String>(
                          isExpanded: true,
                          hint: Text(
                            'Set Day!',
                            style: TextStyle(
                              fontSize: 14,
                              color: Theme.of(context).hintColor,
                            ),
                          ),
                          items: daysValue
                              .map((String day) => DropdownMenuItem<String>(
                                    value: day,
                                    child: Text(
                                      day,
                                      style: const TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ))
                              .toList(),
                          value: state.selectedDay,
                          onChanged: (String? value) {
                            context
                                .read<SetWeeklyGoalBloc>()
                                .add(SetWeeklyGoalSetup(selectedDay: value!));
                          },
                          buttonStyleData: const ButtonStyleData(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              height: 40,
                              width: 140),
                          menuItemStyleData:
                              const MenuItemStyleData(height: 40)),
                    ),
                  ],
                  const SizedBox(height: 10.0),
                  if (state is SetWeeklyGoalLoading) ...[
                    const Center(child: CircularProgressIndicator())
                  ],
                  if (state is SetWeeklyGoalSetWeekState) ...[
                    CustomButtonWidget(
                      labelButton: "Set",
                      icon: Icons.arrow_right_alt_outlined,
                      onPressed: () async {
                        if ((state).selectedDay != null) {
                          final data = await IsarSetWeekly().getAllIsar();
                          if (!mounted) {
                            return;
                          }
                          if (data.isEmpty) {
                            context.read<SetWeeklyGoalBloc>().add(
                                SaveWeeklyGoal(daySet: (state).selectedDay!));
                          }
                          if (data.isNotEmpty) {
                            context.read<SetWeeklyGoalBloc>().add(
                                UpdateSetWeekly(daySet: (state).selectedDay!));
                          }
                          Navigator.pushNamedAndRemoveUntil(
                              context, '/bottom', (route) => false);
                        }
                        if ((state).selectedDay == null) {
                          if (!mounted) {
                            return;
                          }
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Set your weekly goal first")));
                        }
                      },
                    )
                  ]
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
