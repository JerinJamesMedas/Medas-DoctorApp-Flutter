// import 'package:doctors_app/common_class/route.dart';
import 'package:doctors_app/domain/entities/patient.dart';
import 'package:doctors_app/screens/Status/status_all.dart';
import 'package:doctors_app/screens/home/features/patients_statitics_card.dart';
import 'package:flutter/material.dart';

class TodaysStatus extends StatelessWidget {
  final List<Patient> patients;
  const TodaysStatus({required this.patients, super.key});

  @override
  Widget build(BuildContext context) {
    int revisits = patients.where((a) =>a.revisit == "yes").length;
    int yescount = patients.where((a) => a.op == "Yes").length;
    int visitedcount = patients.where((a) => a.visited == true).length;
    // int getTodayRevisitCount(List<dynamic> patients) {
    //   final today = DateTime.now();

    //   return patients.where((p) {
    //     // Parse appointment date
    //     final apptDate = DateTime.parse(p.appointmentDate);
    //     // Check if appointment is today
    //     final isToday =
    //         apptDate.year == today.year &&
    //         apptDate.month == today.month &&
    //         apptDate.day == today.day;
    //     // Check revisit
    //     final isRevisit = p.visitcount > 1;

    //     return isToday && isRevisit;
    //   }).length;
    // }

    // final revisitcount = getTodayRevisitCount(patients);

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StatusAll(heading: "All Patients", patient: patients,selection: "All",),
                  ),
                );
              },
              child: PatientsStatiticsCard(
                colrs: Colors.blue,
                heading: "ALL",
                count: patients.length,
                iconPath: "assets/images/totalAppointments.png",
                iconheight: 36,
                iconwidth: 36,
              ),
            ),
            GestureDetector(
                            onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StatusAll(heading: "All Patients", patient: patients,selection: "OP",),
                  ),
                );
              },
              child: PatientsStatiticsCard(
                
                colrs: Colors.blue,
                heading: "OP",
                count: yescount,
                iconPath: "assets/images/outPatient.png",
                iconheight: 36,
                iconwidth: 36,
              ),
            ),
            GestureDetector(
                            onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StatusAll(heading: "All Patients", patient: patients,selection: "Visited",),
                  ),
                );
              },
              child: PatientsStatiticsCard(
                colrs: Colors.blue,
                heading: "Visited",
                count: visitedcount,
                iconPath: "assets/images/visited.png",
                iconheight: 36,
                iconwidth: 36,
              ),
            ),
          ],
        ),
        SizedBox(height: 11),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(width: 48),
            GestureDetector(
                            onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StatusAll(heading: "All Patients", patient: patients,selection: "Revisit",),
                  ),
                );
              },
              child: PatientsStatiticsCard(
                colrs: Colors.blue,
                heading: "Revisits",
                count: revisits,
                iconPath: "assets/images/revisited.png",
                iconheight: 36,
                iconwidth: 39,
              ),
            ),
            GestureDetector(
              child: PatientsStatiticsCard(
                colrs: Colors.blue,
                heading: "Reffered",
                count: 10,
                iconPath: "assets/images/reffered.png",
                iconheight: 36,
                iconwidth: 38,
              ),
            ),
            SizedBox(width: 48),
          ],
        ),
      ],
    );
  }
}
