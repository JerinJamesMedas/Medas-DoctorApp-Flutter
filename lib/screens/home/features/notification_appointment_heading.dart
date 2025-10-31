

String getAppointmentTitle(String appointmentDate, String appointmentTime) {

  try {
    // Combine date and time
    final DateTime startDateTime = DateTime.parse(
        "$appointmentDate ${_convertTo24Hour(appointmentTime)}");

    final DateTime endDateTime = startDateTime.add(const Duration(hours: 1));
    final DateTime now = DateTime.now();

    // Case 1: Current ongoing appointment
    if (now.isAfter(startDateTime) && now.isBefore(endDateTime)) {
      return "Current Appointment";
    }

    // Case 2: Upcoming appointment later today
    if (startDateTime.day == now.day &&
        startDateTime.month == now.month &&
        startDateTime.year == now.year &&
        startDateTime.isAfter(now)) {
      return "Upcoming Appointment";
    }

    // Default
    return "Appointment on $appointmentDate";
  } catch (e) {
    // print(" there are errors $e");
    return "Appointment $appointmentDate";
    
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
