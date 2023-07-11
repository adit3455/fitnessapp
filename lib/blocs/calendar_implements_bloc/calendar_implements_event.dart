// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'calendar_implements_bloc.dart';

abstract class CalendarImplementsEvent extends Equatable {
  const CalendarImplementsEvent();

  @override
  List<Object> get props => [];
}

class StartingCalendarImplements extends CalendarImplementsEvent {}

class ChangingCalendarFormat extends CalendarImplementsEvent {
  final CalendarFormat calendarFormat;
  final DateTime timeNow;
  const ChangingCalendarFormat(
      {required this.calendarFormat, required this.timeNow});
  @override
  List<Object> get props => [calendarFormat];
  ChangingCalendarFormat copyWith({
    final DateTime? dateTime,
    final CalendarFormat? calendarFormat,
  }) {
    return ChangingCalendarFormat(
        timeNow: timeNow,
        calendarFormat: calendarFormat ?? this.calendarFormat);
  }
}

class ChangeDayFormat extends CalendarImplementsEvent {
  final DateTime selectedDay;
  final DateTime timeNow;
  final CalendarFormat calendarFormat;
  const ChangeDayFormat({
    required this.selectedDay,
    required this.timeNow,
    required this.calendarFormat,
  });
  @override
  List<Object> get props => [selectedDay, timeNow, calendarFormat];
}

class SeeAllHistory extends CalendarImplementsEvent {
  final CalendarFormat calendarFormat;
  final DateTime timeNow;
  final DateTime selectedDate;
  const SeeAllHistory({
    required this.calendarFormat,
    required this.timeNow,
    required this.selectedDate,
  });

  @override
  List<Object> get props => [selectedDate, timeNow, calendarFormat];
}
