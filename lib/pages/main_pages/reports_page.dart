import 'dart:collection';

import 'package:fitness_app/config/calendar_config.dart';
import 'package:fitness_app/models/done_exercise_model.dart';
import 'package:fitness_app/pages/exercises_pages/history_exercises_page.dart';
import 'package:fitness_app/repository/firebase_exercise_module.dart/firebase_exercise_module.dart';
import 'package:fitness_app/widgets/custom_bold_title.dart';
import 'package:fitness_app/widgets/custom_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../blocs/reports_exercise_bloc/reports_exercise_bloc.dart';
import '../../utils/app_utils.dart';
import '../../utils/assets_util.dart';
import '../exercises_pages/exercise_tracker_page.dart';

class ReportsPage extends StatelessWidget {
  const ReportsPage({super.key});

  int getHashCode(DateTime key) =>
      key.day * 1000000 + key.month * 10000 + key.year;

  @override
  Widget build(BuildContext context) {
    final mQuery = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) =>
          ReportsExerciseBloc(firebaseExerciseModule: FirebaseExerciseModule())
            ..add(LoadExerciseReports()),
      child: Scaffold(
          appBar: AppBar(
              backgroundColor: AppUtils.appbarBackgroundColor,
              systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarBrightness: Brightness.dark,
              )),
          body: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Stack(
              children: [
                Container(
                    color: AppUtils.appbarBackgroundColor,
                    width: mQuery.width,
                    height: mQuery.height * 0.4),
                Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 5.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("KEEP IT UP!",
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall!
                                          .copyWith(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 10.0),
                                  Text("REPORTS!",
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall!
                                          .copyWith(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold)),
                                ],
                              ),
                              Container(
                                  margin: EdgeInsets.only(right: 20.w),
                                  alignment: Alignment.topRight,
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(50.0),
                                      child: Image.asset(AssetsUtil.runBoy,
                                          fit: BoxFit.cover,
                                          width: 100.w,
                                          height: 100.h))),
                            ],
                          ),
                          const SizedBox(height: 20.0),
                          const CustomBoldTitle(
                              title: "All of your Excercises",
                              textColor: Colors.white,
                              paddingSize: 0),
                          const SizedBox(height: 10.0),
                          BlocConsumer<ReportsExerciseBloc,
                              ReportsExerciseState>(
                            listener: (context, state) {},
                            builder: (context, state) {
                              if (state is ReportsExerciseInitial) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                              if (state is ReportsIsEmptyState) {
                                return Center(
                                    child: Column(
                                  children: [
                                    SizedBox(height: 140.0.h),
                                    const CustomBoldTitle(
                                        title: "You Havent Done Any Exercises",
                                        textColor: Colors.black,
                                        fontSize: 20,
                                        paddingSize: 0),
                                    SizedBox(height: 20.h),
                                    CustomButtonWidget(
                                      labelButton:
                                          "Start Your First Exercises?",
                                      icon: Icons.arrow_right,
                                      onPressed: () => PersistentNavBarNavigator
                                          .pushNewScreen(context,
                                              screen:
                                                  const ExerciseTrackerPage(),
                                              withNavBar: false),
                                    )
                                  ],
                                ));
                              }
                              if (state is ReportsLoaded) {
                                final CalendarConfig calendarConfig =
                                    CalendarConfig(l: state.doneExerciseModel!);

                                final events = LinkedHashMap<DateTime,
                                        List<DoneExerciseModel>>(
                                    equals: isSameDay, hashCode: getHashCode)
                                  ..addAll(state.mapDone);

                                List getEventForDay(DateTime day) {
                                  return events[day] ?? [];
                                }

                                final cardData =
                                    calendarConfig.allCardExercises;

                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Card(
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: IntrinsicHeight(
                                            child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                              stackColumn(
                                                  context,
                                                  "${cardData['exercises']}",
                                                  "Exercises"),
                                              const VerticalDivider(),
                                              stackColumn(
                                                  context,
                                                  "${cardData['kcal']}",
                                                  "Kcal"),
                                              const VerticalDivider(),
                                              stackColumn(
                                                  context,
                                                  "${cardData['duration']}",
                                                  "Duration"),
                                            ])),
                                      ),
                                    ),
                                    const SizedBox(height: 10.0),
                                    Card(
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Column(children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const CustomBoldTitle(
                                                  title: "This Week",
                                                  paddingSize: 0,
                                                  fontSize: 20),
                                              InkWell(
                                                borderRadius:
                                                    BorderRadius.circular(20.0),
                                                onTap: () => Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          HistoryExercisesPage(
                                                              mapDone:
                                                                  state.mapDone,
                                                              doneExercisesList:
                                                                  state
                                                                      .doneExerciseModel!),
                                                    )),
                                                child: const Row(
                                                  children: [
                                                    Text("History"),
                                                    Icon(Icons.arrow_right)
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                          TableCalendar(
                                            locale: "en_US",
                                            rowHeight: 43,
                                            eventLoader: getEventForDay,
                                            headerStyle: HeaderStyle(
                                                leftChevronIcon:
                                                    const SizedBox(),
                                                rightChevronIcon:
                                                    const SizedBox(),
                                                formatButtonVisible: false,
                                                titleCentered: true,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            29.9))),
                                            firstDay:
                                                DateTime.utc(2010, 10, 16),
                                            startingDayOfWeek:
                                                StartingDayOfWeek.monday,
                                            lastDay: DateTime.utc(2030, 3, 14),
                                            focusedDay: state.dateTimeNow,
                                            calendarFormat: CalendarFormat.week,
                                            calendarStyle:
                                                const CalendarStyle(),
                                          ),
                                        ]),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    const SizedBox(height: 10.0),
                                    Card(
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: SfCartesianChart(
                                          enableAxisAnimation: true,
                                          primaryXAxis: CategoryAxis(),
                                          title: ChartTitle(
                                              text: "Your Monthly Activity!"),
                                          selectionType: SelectionType.cluster,
                                          series: <ChartSeries>[
                                            LineSeries<ChartData, dynamic>(
                                                dataLabelSettings:
                                                    const DataLabelSettings(
                                                  isVisible: true,
                                                  margin: EdgeInsets.all(10.0),
                                                ),
                                                dataSource:
                                                    calendarConfig.lineChartSet,
                                                xValueMapper:
                                                    (ChartData data, index) =>
                                                        data.x,
                                                yValueMapper:
                                                    (ChartData data, index) =>
                                                        data.y)
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              } else {
                                return const Text("Theres Something Wrong");
                              }
                            },
                          )
                        ])),
              ],
            ),
          )),
    );
  }

  Column stackColumn(
      BuildContext context, final String upperText, final String downText) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(upperText,
            style: Theme.of(context)
                .textTheme
                .headlineMedium!
                .copyWith(color: Colors.black, fontWeight: FontWeight.bold)),
        Text(downText,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: Colors.grey.shade400)),
      ],
    );
  }
}

class ChartData {
  final String x;
  final int y;
  const ChartData(this.x, this.y);
}
