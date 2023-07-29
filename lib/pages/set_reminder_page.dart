import 'package:fitness_app/repository/isar_repo/isar_set_reminder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../config/notification_config.dart';
import '../models/reminder_timer.dart';
import '../utils/assets_util.dart';
import '../widgets/custom_bold_title.dart';
import '../widgets/custom_button_widget.dart';
import '../widgets/title_app_bar.dart';

class SetReminderPage extends StatefulWidget {
  const SetReminderPage({super.key});

  @override
  State<SetReminderPage> createState() => _SetReminderPageState();
}

class _SetReminderPageState extends State<SetReminderPage> {
  @override
  Widget build(BuildContext context) {
    Duration initialTimer = const Duration();

    NotificationConfig notif = NotificationConfig();
    IsarSetReminder isar = IsarSetReminder();

    return Scaffold(
        appBar: AppBar(
            title: const TitleAppBar(leftText: "Reminder", rightText: "")),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Image.asset(AssetsUtil.peopleExerciseForWeekly,
                  height: 100, width: 100, fit: BoxFit.cover),
              const CustomBoldTitle(title: "SET YOUR REMINDER"),
              const SizedBox(height: 10),
              SizedBox(
                  width: 350,
                  child: Text(
                      "We recommend you to to take reminder so you don't forget to do your exercises",
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: Colors.grey))),
              const SizedBox(height: 30.0),
              CustomButtonWidget(
                labelButton: "Set Reminder",
                icon: Icons.timer_outlined,
                onPressed: () async {
                  await showCupertinoModalPopup(
                    context: context,
                    builder: (context) {
                      return Container(
                        width: MediaQuery.sizeOf(context).width,
                        height: 300.h,
                        padding: const EdgeInsets.all(10),
                        color: Colors.white,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CupertinoTimerPicker(
                              mode: CupertinoTimerPickerMode.hms,
                              minuteInterval: 1,
                              secondInterval: 1,
                              initialTimerDuration: initialTimer,
                              onTimerDurationChanged: (Duration changeTimer) {
                                initialTimer = changeTimer;
                              },
                            ),
                            CustomButtonWidget(
                              labelButton: "Set Reminder",
                              icon: Icons.timer_outlined,
                              onPressed: () async {
                                if (initialTimer.inHours == 0) {
                                  Navigator.pop(context);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              "You must input the hours!")));
                                }
                                final isarData = await isar.getAllIsar();

                                if (isarData.isNotEmpty) {
                                  final data = isarData
                                      .firstWhere((element) => element.id == 1);

                                  await isar.updateIsar(
                                      notif
                                          .durationToDateTime(
                                              initialTimer.toString())
                                          .toString(),
                                      data);
                                  if (!mounted) {
                                    return;
                                  }
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              "Succes set for reminder!")));
                                }
                                if (isarData.isEmpty) {
                                  final rdata = ReminderTimerModel(
                                      duration: notif
                                          .durationToDateTime(
                                              initialTimer.toString())
                                          .toString());

                                  await IsarSetReminder().saveIsar(rdata);
                                  if (!mounted) {
                                    return;
                                  }
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              "Succes set for reminder!")));
                                }
                              },
                            )
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ));
  }
}
