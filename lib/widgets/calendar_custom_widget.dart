import 'dart:collection';

import 'package:fitness_app/widgets/custom_bold_title.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../models/done_exercise_model.dart';

class CalendarCustomWidget extends StatelessWidget {
  final int eDoneThisWeek;
  final int totalDaySet;
  final Map<DateTime, List<DoneExerciseModel>> mapDone;
  const CalendarCustomWidget(
      {required this.totalDaySet,
      required this.eDoneThisWeek,
      required this.mapDone,
      super.key});

  String strDigits(int n) => n.toString().padLeft(2, '0');
  String hours(Duration d) => strDigits(d.inHours.remainder(24));
  String minutes(Duration d) => strDigits(d.inMinutes.remainder(60));
  String seconds(Duration d) => strDigits(d.inSeconds.remainder(60));

  @override
  Widget build(BuildContext context) {
    int getHashCode(DateTime key) =>
        key.day * 1000000 + key.month * 10000 + key.year;
    final events = LinkedHashMap<DateTime, List<DoneExerciseModel>>(
        equals: isSameDay, hashCode: getHashCode)
      ..addAll(mapDone);

    List<DoneExerciseModel> getEventForDay(DateTime day) {
      return events[day] ?? [];
    }

    final lDone = mapDone.values.toList().expand((element) => element).toList();

    final tCalories = lDone.fold(
        0,
        (previousValue, element) =>
            previousValue + element.totalCalories.toInt());

    final tDuration = lDone.fold(
        0, (previousValue, element) => previousValue + element.duration);

    final Duration d = Duration(seconds: tDuration);

    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const CustomBoldTitle(title: "Total", paddingSize: 0),
            const SizedBox(height: 5),
            Row(
              children: [
                Row(
                  children: [
                    CustomBoldTitle(title: "$tCalories", paddingSize: 0),
                    Text(" Kcal", style: Theme.of(context).textTheme.bodyLarge),
                  ],
                ),
                const SizedBox(width: 20.0),
                CustomBoldTitle(
                    title: "${hours(d)}:${minutes(d)}:${seconds(d)}",
                    paddingSize: 0),
                Text(" Duration", style: Theme.of(context).textTheme.bodyLarge),
              ],
            )
          ]),
          Card(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("WEEKLY GOALS",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(fontWeight: FontWeight.bold)),
                        Row(
                          children: [
                            Text("$eDoneThisWeek",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold)),
                            Text("/$totalDaySet",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(color: Colors.black)),
                            eDoneThisWeek >= totalDaySet
                                ? const Icon(Icons.check,
                                    color: Colors.green, size: 25)
                                : const Icon(
                                    Icons.close,
                                    color: Colors.red,
                                    size: 25,
                                  )
                          ],
                        ),
                      ]),
                  const SizedBox(height: 10),
                  TableCalendar(
                      calendarFormat: CalendarFormat.week,
                      eventLoader: getEventForDay,
                      locale: "en_US",
                      headerVisible: false,
                      rowHeight: 43,
                      focusedDay: DateTime.now(),
                      startingDayOfWeek: StartingDayOfWeek.monday,
                      firstDay: DateTime.utc(2010, 10, 16),
                      lastDay: DateTime.utc(2030, 3, 14)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
