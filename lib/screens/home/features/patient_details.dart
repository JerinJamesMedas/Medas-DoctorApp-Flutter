import 'package:doctors_app/common_class/animations/icon_blink.dart';
import 'package:doctors_app/common_class/route.dart';
import 'package:doctors_app/common_class/textStyle.dart';
import 'package:doctors_app/domain/entities/patient.dart';
import 'package:doctors_app/screens/home/features/workbenchcard.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PatientDetailsPage extends StatelessWidget {
  final Patient patient;
  const PatientDetailsPage({super.key, required this.patient});

  @override
  Widget build(BuildContext context) {
    // print(patient.allergies);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "WORKBENCH",
          style: GoogleFonts.spaceGrotesk(
            fontSize: AppFontSize.h1,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(left: 12.0, right: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  borderRadius: BorderRadius.circular(39),
                  onTap: () {
                    print("hiii caller");
                  },
                  child: Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: Colors.transparent, // transparent circle
                      borderRadius: BorderRadius.circular(35 / 2),
                    ),
                    child: Icon(
                      Icons.video_chat_outlined,
                      color: Colors.blue,
                      size: 28,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                InkWell(
                  borderRadius: BorderRadius.circular(39),
                  onTap: () {
                    print("helo caller");
                  },
                  child: Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: Colors.transparent, // transparent circle
                      borderRadius: BorderRadius.circular(35 / 2),
                    ),
                    child: Icon(Icons.phone, color: Colors.blue, size: 28),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

      // body: Padding(
      //   padding: const EdgeInsets.all(16.0),
      //   child: Column(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: [
      //       Text("Name: ${patient.name}"),
      //       Text("MR: ${patient.mr}"),
      //       Text("DOB: ${patient.dob}"),
      //       Text("Type: ${patient.type}"),
      //     ],
      //   ),
      // ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsetsGeometry.all(8.0),
              child: Container(
                width: double.infinity,
                height: 168,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16), // rounded border
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5), // shadow color
                      spreadRadius: 1, // how wide it spreads
                      blurRadius: 8, // how soft it is
                      offset: const Offset(0, 4), // shadow at bottom
                    ),
                  ],
                  image: const DecorationImage(
                    image: AssetImage("assets/images/card6.png"),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Name: ${patient.patientName}",
                                style: GoogleFonts.spaceGrotesk(
                                  fontSize: AppFontSize.h2,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              patient.visitType == "F"
                                  ? BlinkingIcon(
                                      icon: Icon(
                                        Icons.r_mobiledata_outlined,
                                        size: 36,
                                        color: Colors.red,
                                      ),
                                    )
                                  : SizedBox(),
                            ],
                          ),
                          patient.appointType == "Video Call"
                              ? Icon(
                                  Icons.videocam_outlined,
                                  color: Colors.white,
                                  size: 36,
                                )
                              : patient.appointType == "On Spot"
                              ? Icon(
                                  Icons.location_on,
                                  color: Colors.white,
                                  size: 36,
                                )
                              : patient.appointType == "Home Visit"
                              ? Icon(
                                  Icons.home_filled,
                                  color: Colors.white,
                                  size: 36,
                                )
                              : SizedBox(),
                        ],
                      ),
                      Text(
                        "MR: ${patient.opNumber}",
                        style: GoogleFonts.spaceGrotesk(
                          fontSize: AppFontSize.h3,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "DOB: ${patient.dateOfBirth}",
                        style: GoogleFonts.spaceGrotesk(
                          fontSize: AppFontSize.h3,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "Gender: ${patient.sex}",
                        style: GoogleFonts.spaceGrotesk(
                          fontSize: AppFontSize.h3,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "Reason: ${patient.appointPurpose}",
                        style: GoogleFonts.spaceGrotesk(
                          fontSize: AppFontSize.h3,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // work bench functions
            const SizedBox(height: 20),

            GridView.count(
              crossAxisCount: 4,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 28,
              crossAxisSpacing: 4,
              children: [
                Workbenchcard(
                  icon: Icons.local_hospital,
                  title: "Nurse's Sheet",
                  color: Colors.white,
                  route: AppRouter.nurseSheet,
                ),
                Workbenchcard(
                  icon: Icons.history,
                  title: "History",
                  color: Colors.white,
                  route: AppRouter.patientHistory,
                ),
                Workbenchcard(
                  icon: Icons.monitor_heart,
                  title: "Examination",
                  color: Colors.white,
                  route: AppRouter.examination,
                ),
                Workbenchcard(
                  icon: Icons.assignment,
                  title: "Diagnosis",
                  color: Colors.white,
                  route: AppRouter.diagnosis,
                ),
                Workbenchcard(
                  icon: Icons.vaccines,
                  title: "Treatment",
                  color: Colors.white,
                  route: AppRouter.treatment,
                ),
                Workbenchcard(
                  icon: Icons.medical_information,
                  title: "Follow-Up",
                  color: Colors.white,
                  route: AppRouter.followup,
                ),
                Workbenchcard(
                  icon: Icons.edit_note,
                  title: "Remarks",
                  color: Colors.white,
                  route: AppRouter.remarks,
                ),
                Workbenchcard(
                  icon: Icons.recent_actors_sharp,
                  title: "Reports",
                  color: Colors.white,
                  route: AppRouter.reports,
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Alerts & Allergies Card
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.blue.shade200, width: 1.2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.warning_amber_rounded,
                              color: Colors.red,
                              size: 28,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              "Alerts & Allergies",
                              style: GoogleFonts.spaceGrotesk(
                                fontSize: AppFontSize.h2,
                                fontWeight: FontWeight.bold,
                                color: Colors.red.shade700,
                              ),
                            ),
                          ],
                        ),
                  SizedBox(
                    height: 40,
                    width: 40,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(40),
                    onTap: (){
                      print("hoo");
                    }
                      ,child: Icon(Icons.edit,size: 23,color: Colors.red,)),
                  )
                      ],
                    ),
                    const SizedBox(height: 10),

                    // Example allergy list
                    if (patient.allergies.isNotEmpty) ...[
                      Text(
                        "⚠️ Allergies:",
                        style: GoogleFonts.varelaRound(
                          fontSize: AppFontSize.h3,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 6),
                      ...patient.allergies.map(
                        (allergy) => Padding(
                          padding: const EdgeInsets.only(left: 12.0, bottom: 4),
                          child: Row(
                            children: [
                              Icon(Icons.circle, size: 8, color: Colors.red),
                              const SizedBox(width: 6),
                              Text(
                                allergy,
                                style: GoogleFonts.varelaRound(
                                  fontSize: AppFontSize.h3,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ] else
                      Text(
                        "No known allergies.",
                        style: GoogleFonts.varelaRound(
                          fontSize: AppFontSize.h3,
                          color: Colors.grey[700],
                        ),
                      ),

                    const SizedBox(height: 12),

                    // Important Notes
                    if (patient.notes.isNotEmpty) ...[
                      Text(
                        "📝 Important Notes:",
                        style: GoogleFonts.varelaRound(
                          fontSize: AppFontSize.h3,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 6),

                      // loop through notes list
                      ...patient.notes.map(
                        (note) => Padding(
                          padding: const EdgeInsets.only(left: 8.0, bottom: 4),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "• ",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black87,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  note,
                                  style: GoogleFonts.varelaRound(
                                    fontSize: AppFontSize.h3,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ] else ...[
                      Text(
                        "📝 Important Notes: None",
                        style: GoogleFonts.varelaRound(
                          fontSize: AppFontSize.h3,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
