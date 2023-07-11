// import 'dart:collection';

// import 'package:flutter/material.dart';
// import 'package:table_calendar/table_calendar.dart';

// class TableEventsExample extends StatefulWidget {
//   const TableEventsExample({super.key});

//   @override
//   State<TableEventsExample> createState() => _TableEventsExampleState();
// }

// class _TableEventsExampleState extends State<TableEventsExample> {
//   DateTime _focusedDay = DateTime.now();
//   CalendarFormat _calendarFormat = CalendarFormat.week;
//   DateTime? _selectedDate;
//   Map<DateTime, List> _eventsList = {};

// int getHashCode(DateTime key) {
//   return key.day * 1000000 + key.month * 10000 + key.year;
// }

//   @override
//   void initState() {
//     super.initState();

//     _selectedDate = _focusedDay;
//     _eventsList = {
//       DateTime.now().subtract(const Duration(days: 2)): [
//         'Event A1',
//         'Event B1'
//       ],
//       DateTime.now(): ['Event A2', 'Event B2', 'Event C1', 'Event D1'],
//       DateTime.now().add(const Duration(days: 1)): [
//         'Event A3',
//         'Event B3',
//         'Event C2',
//         'Event D2'
//       ],
//       DateTime.now().add(const Duration(days: 3)):
//           {'Event A4', 'Event A5', 'Event B4'}.toList(),
//       DateTime.now().add(const Duration(days: 7)): [
//         'Event A6',
//         'Event B5',
//         'Event C3'
//       ],
//     };
//   }

//   @override
//   Widget build(BuildContext context) {
//     final events = LinkedHashMap<DateTime, List>(
//       equals: isSameDay,
//       hashCode: getHashCode,
//     )..addAll(_eventsList);

//     List getEventForDay(DateTime day) {
//       return events[day] ?? [];
//     }

//     return Scaffold(
//         appBar: AppBar(title: const Text("Table Calender")),
//         body: Column(
//           children: [
//             TableCalendar(
//               calendarFormat: _calendarFormat,
//               focusedDay: _focusedDay,
//               eventLoader: getEventForDay,
//               onFormatChanged: (format) {
//                 setState(() {
//                   _calendarFormat = format;
//                 });
//               },
//               startingDayOfWeek: StartingDayOfWeek.monday,
//               onDaySelected: (selectedDay, focusedDay) {
//                 if (!isSameDay(_selectedDate, focusedDay)) {
//                   setState(() {
//                     _selectedDate = selectedDay;
//                     _focusedDay = focusedDay;
//                   });
//                 }
//               },
//               onPageChanged: (focusedDay) => _focusedDay = focusedDay,
//               selectedDayPredicate: (day) => isSameDay(_selectedDate, day),
// firstDay: DateTime.utc(2010, 10, 16),
// lastDay: DateTime.utc(2030, 3, 14),
//             ),
// ListView(
//               shrinkWrap: true,
//               children: getEventForDay(_selectedDate!)
//                   .map((event) => ListTile(
//                         title: Text(event.toString()),
//                       ))
//                   .toList(),
//             )
//           ],
//         ));
//   }
// }

import 'package:fitness_app/repository/firebase_exercise_module.dart/firebase_exercise_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';

import '../blocs/reports_exercise_bloc/reports_exercise_bloc.dart';

class TableEventsExample extends StatelessWidget {
  const TableEventsExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calendar"),
      ),
      body: BlocProvider(
        create: (context) => ReportsExerciseBloc(
            firebaseExerciseModule: FirebaseExerciseModule())
          ..add(LoadExerciseReports()),
        child: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  TableCalendar(
                    focusedDay: DateTime.now(),
                    onDaySelected: (selectedDay, focusedDay) {},
                    calendarFormat: CalendarFormat.week,
                    startingDayOfWeek: StartingDayOfWeek.monday,
                    headerStyle: const HeaderStyle(
                        titleCentered: true, formatButtonVisible: false),
                    onFormatChanged: (format) {},
                    firstDay: DateTime.utc(2010, 10, 16),
                    lastDay: DateTime.utc(2030, 3, 14),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
