import 'package:doctors_app/screens/shedule_screen.dart/features/doctor_appointment.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class DoctorAppointmentDataSource extends CalendarDataSource {
  DoctorAppointmentDataSource(List<DoctorAppointment> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) => appointments![index].startTime;
  @override
  DateTime getEndTime(int index) => appointments![index].endTime;
  @override
  String getSubject(int index) =>
      "${appointments![index].patientName} - ${appointments![index].type}";
  @override
  Color getColor(int index) => appointments![index].background;
  @override
  bool isAllDay(int index) => false;
}
