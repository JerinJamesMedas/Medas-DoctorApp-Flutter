// import 'package:doctors_app/common_class/route.dart';
import 'package:doctors_app/domain/entities/patient.dart';
import 'package:doctors_app/model/home_model.dart';
import 'package:doctors_app/screens/Status/status_all.dart';
import 'package:doctors_app/screens/home/features/patients_statitics_card.dart';
import 'package:flutter/material.dart';

class TodaysStatus extends StatefulWidget {
  final List<ConsultationModel> patients;
  const TodaysStatus({required this.patients, super.key});

  @override
  State<TodaysStatus> createState() => _TodaysStatusState();
}

class _TodaysStatusState extends State<TodaysStatus> {
  int revisits = 0;
  int yescount = 0;
  int visitedcount = 0;

  @override
  void initState() {
    super.initState();
    _countcheck();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _countcheck() {
    revisits = widget.patients.where((a) => a.doctorVisitType == "REVISIT").length;
    yescount = widget.patients.where((a) => a.visitTypeNew== "WALK IN").length;
    visitedcount = widget.patients.where((a) => a.visited == "VISITED").length;
  }

  @override
  Widget build(BuildContext context) {
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
                    builder: (context) => StatusAll(
                      heading: "All Patients",
                      patient: widget.patients,
                      selection: "All",
                    ),
                  ),
                );
              },
              child: PatientsStatiticsCard(
                colrs: Colors.blue,
                heading: "ALL",
                count: widget.patients.length,
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
                    builder: (context) => StatusAll(
                      heading: "All Patients",
                      patient: widget.patients,
                      selection: "OP",
                    ),
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
                    builder: (context) => StatusAll(
                      heading: "All Patients",
                      patient: widget.patients,
                      selection: "Visited",
                    ),
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
                    builder: (context) => StatusAll(
                      heading: "All Patients",
                      patient: widget.patients,
                      selection: "Revisit",
                    ),
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