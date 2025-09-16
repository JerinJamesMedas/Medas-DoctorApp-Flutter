import 'package:doctors_app/common_class/animations/slider.dart';
import 'package:doctors_app/common_class/textStyle.dart';
import 'package:doctors_app/domain/entities/patient.dart';
import 'package:doctors_app/screens/home/features/patient_details.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PatientCardList extends StatelessWidget {
  const PatientCardList({super.key, required this.patients});

  final List<Patient> patients;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: patients.length > 3 ? 3 : patients.length,
      itemBuilder: (context, index) {
        final p = patients[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Container(
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: const DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage("assets/images/card5.png"),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 4,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: ListTile(
              leading: const Icon(
                Icons.person_pin,
                size: 36,
                color: Colors.white,
              ),
              title: Text(
                p.name,
                style: GoogleFonts.spaceGrotesk(
                  fontSize: AppFontSize.h3,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      offset: Offset(1.0, 1.0),
                      blurRadius: 2.0,
                      color: Colors.black.withOpacity(0.3),
                    ),
                  ],
                ),
              ),
              subtitle: Text(
                "${p.mr} | ${p.dob} | ${p.type}",
                style: GoogleFonts.spaceGrotesk(
                  fontSize: AppFontSize.body,
                  fontWeight: FontWeight.w500,
                  color: Colors.white70,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  SlideRightRoute(page: PatientDetailsPage(patient: p)),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
