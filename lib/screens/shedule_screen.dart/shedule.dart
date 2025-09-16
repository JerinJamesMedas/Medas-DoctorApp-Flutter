import 'package:doctors_app/screens/shedule_screen.dart/features/doctor_appointment.dart';
import 'package:doctors_app/screens/shedule_screen.dart/features/doctor_appointment_data_source.dart';
import 'package:doctors_app/screens/shedule_screen.dart/features/shedule_skeletonizer.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:doctors_app/common_class/bloc/patient_bloc.dart';
import 'package:doctors_app/injection_container.dart' as di;

class DoctorSchedulePage extends StatefulWidget {
  const DoctorSchedulePage({super.key});

  @override
  State<DoctorSchedulePage> createState() => _DoctorSchedulePageState();
}

class _DoctorSchedulePageState extends State<DoctorSchedulePage> {
  DateTime _selectedDate = DateTime.now();
  bool _drawerOpenedOnce = false;

  /// 🔹 Show drawer with filtered appointments
  void _openAppointmentsDrawer(DateTime date, List patients) {
    final appointments = patients.map((p) {
      final rawDate = p.appointmentDate; // e.g. "2025-09-01"
      final rawTime = p.appointmentTime; // e.g. "12:15 PM"
      final inputFormat = DateFormat("yyyy-MM-dd h:mm a");
      final start = inputFormat.parse("$rawDate $rawTime");
      final end = start.add(const Duration(minutes: 30));

      return DoctorAppointment(
        patientName: p.name,
        type: p.title,
        status: p.type,
        time: p.appointmentTime,
        startTime: start,
        endTime: end,
        background: p.type == "Video Call"
            ? Colors.green
            : p.type == "On Spot"
            ? Colors.grey
            : Colors.blue,
      );
    }).toList();

    // 🔹 Filter by tapped/selected date
    final filteredAppointments = appointments.where((appt) {
      return appt.startTime.year == date.year &&
          appt.startTime.month == date.month &&
          appt.startTime.day == date.day;
    }).toList();

    showModalBottomSheet(
      context: context,
      isDismissible: true,
      enableDrag: true,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.45,
          padding: const EdgeInsets.all(12),
          color: Colors.white,
          child: filteredAppointments.isEmpty
              ? const Center(
                  child: Text(
                    "No Appointments",
                    style: TextStyle(fontSize: 18, color: Colors.black87),
                  ),
                )
              : ListView.builder(
                  itemCount: filteredAppointments.length,
                  itemBuilder: (context, index) {
                    final appt = filteredAppointments[index];
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 6,
                      margin: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 4,
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // 🔹 Background image
                          Ink.image(
                            image: const AssetImage("assets/images/card5.png"),
                            fit: BoxFit.cover,
                            height: 120,
                          ),
                          // 🔹 Overlay
                          Container(
                            height: 120,
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.15),
                            ),
                          ),
                          // 🔹 Patient Info
                          ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            title: Text(
                              "${appt.patientName} - ${appt.type}",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              "${appt.time} • ${appt.status}",
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.white70,
                              ),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(
                                    Icons.schedule,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    /* reschedule */
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.cancel,
                                    color: Colors.redAccent,
                                  ),
                                  onPressed: () {
                                    /* cancel */
                                  },
                                ),
                              ],
                            ),
                            onTap: () {
                              /* open patient preview */
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => di.gi<PatientBloc>()..add(LoadPatients()),
      child: BlocBuilder<PatientBloc, PatientState>(
        builder: (context, state) {
          if (state is PatientLoadingState) {
            return Scaffold(body: shedule_skeletonizer());
          }

          if (state is PatientLoadedState) {
            final patients = state.patients;

            // 🔹 Map patients → appointments for calendar display
            final appointments = patients.map((p) {
              final rawDate = p.appointmentDate;
              final rawTime = p.appointmentTime;
              final inputFormat = DateFormat("yyyy-MM-dd h:mm a");
              final start = inputFormat.parse("$rawDate $rawTime");
              final end = start.add(const Duration(minutes: 30));

              return DoctorAppointment(
                patientName: p.name,
                type: p.title,
                status: p.type,
                time: p.appointmentTime,
                startTime: start,
                endTime: end,
                background: p.type == "Video Call"
                    ? Colors.green
                    : p.type == "On Spot"
                    ? Colors.grey
                    : Colors.blue,
              );
            }).toList();

            if (!_drawerOpenedOnce) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                _openAppointmentsDrawer(_selectedDate, patients);
              });
              _drawerOpenedOnce = true; // ✅ only open once
            }

            return Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: Colors.blue.shade700, // Royal Blue
                title: const Text(
                  "Doctor Schedule",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                centerTitle: true,
              ),
              body: SfCalendar(
                view: CalendarView.schedule,
                dataSource: DoctorAppointmentDataSource(appointments),

                // 🔹 Header styling
                headerHeight: 60,
                headerStyle: CalendarHeaderStyle(
                  textAlign: TextAlign.center,
                  textStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                headerDateFormat: "y MMMM",

                // 🔹 Today highlight
                todayHighlightColor: Colors.lightBlueAccent,

                // 🔹 Blue circle around selected date
                selectionDecoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.blue, width: 2),
                  color: Colors.transparent,
                ),

                // 🔹 Appointment text style
                appointmentTextStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),

                // 🔹 Custom month header inside schedule view
                scheduleViewMonthHeaderBuilder: (context, details) {
                  return Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.calendar_month, color: Colors.blue),
                        const SizedBox(width: 8),
                        Text(
                          DateFormat.yMMMM().format(details.date),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                  );
                },

                // 🔹 Custom appointment card style
                appointmentBuilder: (context, details) {
                  final DoctorAppointment appt =
                      details.appointments.first as DoctorAppointment;
                  return Container(
                    decoration: BoxDecoration(
                      color: appt.background,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 4,
                          offset: Offset(2, 2),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(6),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          appt.patientName,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "${appt.time} • ${appt.type}",
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  );
                },

                allowDragAndDrop: true,

                // 🔹 Handle taps
                onTap: (CalendarTapDetails details) {
                  if (details.date != null) {
                    setState(() {
                      _selectedDate = details.date!;
                    });
                    _openAppointmentsDrawer(details.date!, patients);
                  }
                },

                onSelectionChanged: (CalendarSelectionDetails details) {
                  setState(() {
                    _selectedDate = details.date!;
                  });
                  _openAppointmentsDrawer(details.date!, patients);
                },
              ),
            );
          }

          if (state is PatientLoadError) {
            return Scaffold(
              body: const Center(
                child: Text(
                  "Error loading patients",
                  style: TextStyle(color: Colors.black87),
                ),
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
