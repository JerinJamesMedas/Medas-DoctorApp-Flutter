import 'package:flutter/material.dart';

class DoctorAppointment {
  DoctorAppointment({
    required this.patientName,
    required this.type,
    required this.status,
    required this.time,
    required this.startTime,
    required this.endTime,
    required this.background,
  });

  final String patientName;
  final String type;
  final String status;
  final String time;
  final DateTime startTime;
  final DateTime endTime;
  final Color background;
}
