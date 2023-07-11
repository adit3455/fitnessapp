part of 'calendar_implements_bloc.dart';

abstract class CalendarImplementsState extends Equatable {
  const CalendarImplementsState();

  @override
  List<Object> get props => [];
}

class CalendarImplementsInitial extends CalendarImplementsState {}

class ChangeCalendar extends CalendarImplementsState {
  final DateTime timeNow;
  final CalendarFormat calendarFormat;
  final DateTime selectedDay;

  const ChangeCalendar(
      {required this.selectedDay,
      required this.timeNow,
      this.calendarFormat = CalendarFormat.month});
  @override
  List<Object> get props => [timeNow];

  ChangeCalendar copyWith({
    final DateTime? dateTime,
    final CalendarFormat? calendarFormat,
    final DateTime? selectedDay,
  }) {
    return ChangeCalendar(
        selectedDay: selectedDay ?? this.selectedDay,
        timeNow: timeNow,
        calendarFormat: calendarFormat ?? this.calendarFormat);
  }
}

class ChangeCalendarFormat extends CalendarImplementsState {
  final DateTime timeNow;
  final CalendarFormat calendarFormat;
  final DateTime selectedDay;

  const ChangeCalendarFormat(
      {required this.timeNow,
      this.calendarFormat = CalendarFormat.month,
      required this.selectedDay});

  @override
  List<Object> get props => [timeNow, calendarFormat, selectedDay];
}
