
import 'package:flutter/material.dart';

Color appointmentColor(String appointmentDate, String appointmentTime) {
  try {
    // Parse appointment date & time
    final DateTime startDateTime = DateTime.parse(
        "$appointmentDate ${_convertTo24Hour(appointmentTime)}");

    // End time = start + 1 hour
    final DateTime endDateTime = startDateTime.add(const Duration(hours: 1));

    final DateTime now = DateTime.now();

    // Check if current time is within start and end
    if (now.isAfter(startDateTime) && now.isBefore(endDateTime)) {
      return const Color.fromARGB(255, 181, 255, 96); // green
    }  else if (now.isAfter(endDateTime)){
      return Colors.red;
    }
    else if (now.isBefore(startDateTime)){
      return Colors.yellow;
    }
    else {
      return Colors.orange;
    }
  } catch (e) {
    return Colors.white; // fallback color
  }
}

// Helper: convert "hh:mm AM/PM" to "HH:mm"
String _convertTo24Hour(String time) {
  final format = time.split(" ");
  final hm = format[0].split(":");
  int hour = int.parse(hm[0]);
  final minute = int.parse(hm[1]);
  final isPM = format[1].toUpperCase() == "PM";

  if (isPM && hour != 12) hour += 12;
  if (!isPM && hour == 12) hour = 0;

  return "${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}";
}
