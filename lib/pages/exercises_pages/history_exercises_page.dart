import 'dart:collection';

import 'package:fitness_app/extension/extension.dart';
import 'package:fitness_app/models/done_exercise_model.dart';
import 'package:fitness_app/widgets/custom_bold_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../blocs/calendar_implements_bloc/calendar_implements_bloc.dart';

class HistoryExercisesPage extends StatelessWidget {
  final List<DoneExerciseModel> doneExercisesList;
  final Map<DateTime, List<DoneExerciseModel>> mapDone;

  const HistoryExercisesPage(
      {required this.doneExercisesList, required this.mapDone, super.key});

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

    return BlocProvider(
      create: (context) =>
          CalendarImplementsBloc()..add(StartingCalendarImplements()),
      child: Scaffold(
        appBar: AppBar(
          title: const CustomBoldTitle(title: "History"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                BlocBuilder<CalendarImplementsBloc, CalendarImplementsState>(
                  builder: (context, state) {
                    if (state is CalendarImplementsInitial) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (state is ChangeCalendar) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Card(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: TableCalendar(
                                locale: "en_US",
                                rowHeight: 43,
                                eventLoader: getEventForDay,
                                selectedDayPredicate: (day) =>
                                    isSameDay(state.selectedDay, day),
                                onDaySelected: (selectedDay, focusedDay) =>
                                    context.read<CalendarImplementsBloc>().add(
                                        ChangeDayFormat(
                                            selectedDay: selectedDay,
                                            timeNow: state.timeNow,
                                            calendarFormat:
                                                state.calendarFormat)),
                                headerStyle: HeaderStyle(
                                    titleCentered: true,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(29.9))),
                                firstDay: DateTime.utc(2010, 10, 16),
                                startingDayOfWeek: StartingDayOfWeek.monday,
                                lastDay: DateTime.utc(2030, 3, 14),
                                focusedDay: state.timeNow,
                                onFormatChanged: (format) {
                                  context.read<CalendarImplementsBloc>().add(
                                      ChangingCalendarFormat(
                                          timeNow: state.timeNow,
                                          calendarFormat: format));
                                },
                                calendarFormat: state.calendarFormat,
                                calendarStyle: const CalendarStyle(),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Text("All of your Exercises",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(color: Colors.black)),
                          ),
                          ListView(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            children: doneExercisesList
                                .map((e) => Card(
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(e.date,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge!
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.w600)),
                                            Text(
                                              "${e.accomodateExercises.length} Exercises",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .copyWith(
                                                      color:
                                                          Colors.grey.shade600),
                                            ),
                                            const Divider(),
                                            ...List.generate(
                                                e.accomodateExercises.length,
                                                (index) => ListTile(
                                                      contentPadding:
                                                          const EdgeInsets.all(
                                                              5.0),
                                                      leading: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20.0),
                                                        child: Image.network(
                                                            e
                                                                .accomodateExercises[
                                                                    index]
                                                                .image,
                                                            fit: BoxFit.fill),
                                                      ),
                                                      title: Text(e
                                                          .accomodateExercises[
                                                              index]
                                                          .name),
                                                      subtitle: Text(e
                                                          .accomodateExercises[
                                                              index]
                                                          .dificulities
                                                          .capitalize),
                                                    )),
                                          ],
                                        ),
                                      ),
                                    ))
                                .toList(),
                          )
                        ],
                      );
                    }
                    if (state is ChangeCalendarFormat) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Card(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: TableCalendar(
                                locale: "en_US",
                                rowHeight: 43,
                                onDaySelected: (selectedDay, focusedDay) {
                                  context.read<CalendarImplementsBloc>().add(
                                      ChangeDayFormat(
                                          selectedDay: selectedDay,
                                          timeNow: focusedDay,
                                          calendarFormat:
                                              state.calendarFormat));
                                },
                                eventLoader: getEventForDay,
                                headerStyle: HeaderStyle(
                                    titleCentered: true,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(29.9))),
                                firstDay: DateTime.utc(2010, 10, 16),
                                startingDayOfWeek: StartingDayOfWeek.monday,
                                lastDay: DateTime.utc(2030, 3, 14),
                                selectedDayPredicate: (day) =>
                                    isSameDay(state.selectedDay, day),
                                focusedDay: state.timeNow,
                                onFormatChanged: (format) {
                                  context.read<CalendarImplementsBloc>().add(
                                      ChangingCalendarFormat(
                                          timeNow: state.timeNow,
                                          calendarFormat: format));
                                },
                                calendarFormat: state.calendarFormat,
                                calendarStyle: const CalendarStyle(),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          state.calendarFormat == state.calendarFormat
                              ? ListView(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  children: doneExercisesList
                                      .map((e) => Card(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(e.date,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyLarge!
                                                          .copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600)),
                                                  Text(
                                                    "${e.accomodateExercises.length} Exercises",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium!
                                                        .copyWith(
                                                            color: Colors
                                                                .grey.shade600),
                                                  ),
                                                  const Divider(),
                                                  ...List.generate(
                                                      e.accomodateExercises
                                                          .length,
                                                      (index) => ListTile(
                                                            contentPadding:
                                                                const EdgeInsets
                                                                    .all(5.0),
                                                            leading: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20.0),
                                                              child: Image.network(
                                                                  e
                                                                      .accomodateExercises[
                                                                          index]
                                                                      .image,
                                                                  fit: BoxFit
                                                                      .fill),
                                                            ),
                                                            title: Text(e
                                                                .accomodateExercises[
                                                                    index]
                                                                .name),
                                                            subtitle: Text(e
                                                                .accomodateExercises[
                                                                    index]
                                                                .dificulities
                                                                .capitalize),
                                                          )),
                                                ],
                                              ),
                                            ),
                                          ))
                                      .toList(),
                                )
                              : getEventForDay(state.selectedDay).isNotEmpty
                                  ? ListView(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      children:
                                          getEventForDay(state.selectedDay)
                                              .map((e) => Card(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10.0),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(e.date,
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyLarge!
                                                                  .copyWith(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600)),
                                                          Text(
                                                            "${e.accomodateExercises.length} Exercises",
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyMedium!
                                                                .copyWith(
                                                                    color: Colors
                                                                        .grey
                                                                        .shade600),
                                                          ),
                                                          const Divider(),
                                                          ...List.generate(
                                                              e.accomodateExercises
                                                                  .length,
                                                              (index) =>
                                                                  ListTile(
                                                                    contentPadding:
                                                                        const EdgeInsets.all(
                                                                            5.0),
                                                                    leading:
                                                                        ClipRRect(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              20.0),
                                                                      child: Image.network(
                                                                          e.accomodateExercises[index]
                                                                              .image,
                                                                          fit: BoxFit.fill),
                                                                    ),
                                                                    title: Text(e
                                                                        .accomodateExercises[
                                                                            index]
                                                                        .name),
                                                                    subtitle: Text(e
                                                                        .accomodateExercises[
                                                                            index]
                                                                        .dificulities
                                                                        .capitalize),
                                                                  )),
                                                        ],
                                                      ),
                                                    ),
                                                  ))
                                              .toList(),
                                    )
                                  : Column(
                                      children: [
                                        Center(
                                            child: Text(
                                                "You Haven't done any exercises on this date :(",
                                                textAlign: TextAlign.center,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleLarge)),
                                        const SizedBox(height: 10.0),
                                        TextButton(
                                            onPressed: () => context
                                                .read<CalendarImplementsBloc>()
                                                .add(SeeAllHistory(
                                                    calendarFormat:
                                                        state.calendarFormat,
                                                    timeNow: state.timeNow,
                                                    selectedDate:
                                                        state.selectedDay)),
                                            child: const Text(
                                                "See All Exercises?"))
                                      ],
                                    )
                        ],
                      );
                    }
                    return const Text("Theres Something Wrong");
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
