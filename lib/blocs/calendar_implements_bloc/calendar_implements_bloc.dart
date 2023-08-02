import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:table_calendar/table_calendar.dart';

part 'calendar_implements_event.dart';
part 'calendar_implements_state.dart';

class CalendarImplementsBloc
    extends Bloc<CalendarImplementsEvent, CalendarImplementsState> {
  final DateTime timeNow = DateTime.now();
  CalendarFormat calendarFormat = CalendarFormat.month;
  CalendarImplementsBloc() : super(CalendarImplementsInitial()) {
    on<StartingCalendarImplements>((event, emit) async {
      await Future.delayed(const Duration(seconds: 1));
      emit(ChangeCalendar(
          timeNow: timeNow,
          selectedDay: timeNow,
          calendarFormat: calendarFormat));
    });

    on<ChangingCalendarFormat>((event, emit) {
      emit(ChangeCalendarFormat(
          timeNow: event.timeNow,
          calendarFormat: event.calendarFormat,
          selectedDay: event.timeNow));
    });

    on<ChangeDayFormat>((event, emit) {
      emit(ChangeCalendarFormat(
          timeNow: event.timeNow,
          calendarFormat: event.calendarFormat,
          selectedDay: event.selectedDay));
    });

    on<SeeAllHistory>((event, emit) {
      emit(ChangeCalendar(
          selectedDay: event.selectedDate,
          timeNow: event.timeNow,
          calendarFormat: event.calendarFormat));
    });
  }
}
