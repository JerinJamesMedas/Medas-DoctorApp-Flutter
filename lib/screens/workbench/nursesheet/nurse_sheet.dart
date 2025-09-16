// import 'package:doctors_app/common_class/textstyle.dart';
import 'package:doctors_app/screens/workbench/nursesheet/vitaledit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthicons_flutter/healthicons_flutter.dart' as healthicons;
// import 'package:healthicons_flutter/filled/database.dart' as data;

class NurseSheet extends StatelessWidget {
  const NurseSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back, color: Colors.white),
          ),
          title: Text(
            "Nurse Sheet",
            style: GoogleFonts.spaceGrotesk(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          bottom: const TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            indicatorColor: Colors.white,
            tabs: [
              Tab(text: "Vital Signs"),
              Tab(text: "Pain Rate"),
            ],
          ),
        ),
        body: const TabBarView(children: [VitalSignsTab(), PainRateTab()]),
      ),
    );
  }
}

class VitalSignsTab extends StatefulWidget {
  const VitalSignsTab({super.key});

  @override
  State<VitalSignsTab> createState() => _VitalSignsTabState();
}

class _VitalSignsTabState extends State<VitalSignsTab> {
  List<Map<String, dynamic>> vitals = [
    {
      "name": "Temperature",
      "value": "98.6 °C",
      "danger": false,
      "icon": healthicons.Thermometer(
        height: 32,
        width: 32,
        color: Colors.blue,
      ),
    },
    {
      "name": "Blood Pressure",
      "value": "120/80 mmHg",
      "danger": false,
      "icon": healthicons.BloodPressure2(
        height: 32,
        width: 32,
        color: Colors.blue,
      ), // BP icon is not direct, stethoscope fits well
    },
    {
      "name": "Pulse",
      "value": "75 BPM",
      "danger": false,
      "icon": healthicons.Heart(height: 32, width: 32, color: Colors.blue),
    },
    {
      "name": "Respiratory Rate",
      "value": "16 rpm",
      "danger": false,
      "icon": healthicons.Respirator(height: 32, width: 32, color: Colors.blue),
    },
    {
      "name": "Oxygen Saturation",
      "value": "95%",
      "danger": false,
      "icon": healthicons.OxygenTank(height: 32, width: 32, color: Colors.blue),
    },
    {
      "name": "Blood Sugar",
      "value": "110 mg/dL",
      "danger": false,
      "icon": healthicons.Sugar(
        height: 32,
        width: 32,
        color: Colors.blue,
      ), // used for lab test/blood sugar
    },
    {
      "name": "Height",
      "value": "170 cm",
      "danger": false,
      "icon": healthicons.Height(height: 32, width: 32, color: Colors.blue),
    },
    {
      "name": "Weight",
      "value": "65 kg",
      "danger": false,
      "icon": healthicons.Weight(height: 32, width: 32, color: Colors.blue),
    },
    {
      "name": "BMI",
      "value": "22%",
      "danger": false,
      "icon": healthicons.BodyMassIndex(
        height: 32,
        width: 32,
        color: Colors.blue,
      ),
    },
    // {
    //   "name": "Duration of Illness",
    //   "value": "2 weeks",
    //   "danger": false,
    //   "icon": Icons.timelapse,
    // },
  ];

  // void _editVitals() {
  //   final controllers = {
  //     for (var vital in vitals)
  //       vital["name"]: TextEditingController(text: vital["value"]),
  //   };

  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return Dialog(
  //         insetPadding: const EdgeInsets.all(16),
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(20),
  //         ),
  //         child: Stack(
  //           children: [
  //             // Background image
  //             Positioned.fill(
  //               child: ClipRRect(
  //                 borderRadius: BorderRadius.circular(20),
  //                 child: Image.asset(
  //                   "assets/images/card8.png",
  //                   fit: BoxFit.cover,
  //                 ),
  //               ),
  //             ),

  //             // Foreground content
  //             Container(
  //               padding: const EdgeInsets.all(12),
  //               child: Column(
  //                 mainAxisSize: MainAxisSize.min,
  //                 children: [
  //                   // Title row
  //                   const Padding(
  //                     padding: EdgeInsets.only(top: 8, bottom: 12),
  //                     child: Text(
  //                       "Edit Vitals",
  //                       style: TextStyle(
  //                         fontSize: 22,
  //                         fontWeight: FontWeight.bold,
  //                         color: Color(0xFF003366),
  //                       ),
  //                     ),
  //                   ),

  //                   // Scrollable vitals list
  //                   Flexible(
  //                     child: SingleChildScrollView(
  //                       child: Column(
  //                         children: vitals.map((vital) {
  //                           return Card(
  //                             color: Colors.white.withOpacity(0.9),
  //                             elevation: 3,
  //                             margin: const EdgeInsets.symmetric(vertical: 8),
  //                             shape: RoundedRectangleBorder(
  //                               borderRadius: BorderRadius.circular(16),
  //                             ),
  //                             child: Padding(
  //                               padding: const EdgeInsets.symmetric(
  //                                 vertical: 8,
  //                                 horizontal: 16,
  //                               ),
  //                               child: TextField(
  //                                 controller: controllers[vital["name"]],
  //                                 decoration: InputDecoration(
  //                                   labelText: vital["name"],
  //                                   border: InputBorder.none,
  //                                   labelStyle: const TextStyle(
  //                                     fontSize: 16,
  //                                     fontWeight: FontWeight.w500,
  //                                     color: Color(0xFF003366),
  //                                   ),
  //                                 ),
  //                               ),
  //                             ),
  //                           );
  //                         }).toList(),
  //                       ),
  //                     ),
  //                   ),

  //                   const SizedBox(height: 16),

  //                   // Action buttons row (fixed at bottom)
  //                   Row(
  //                     mainAxisAlignment: MainAxisAlignment.end,
  //                     children: [
  //                       TextButton(
  //                         onPressed: () {
  //                           // controllers.forEach((_, c) => c.dispose());
  //                           Navigator.pop(context);
  //                         },
  //                         child: const Text(
  //                           "Cancel",
  //                           style: TextStyle(
  //                             color: Colors.black54,
  //                             fontSize: 16,
  //                           ),
  //                         ),
  //                       ),
  //                       const SizedBox(width: 12),
  //                       ElevatedButton(
  //                         onPressed: () {
  //                           setState(() {
  //                             for (var vital in vitals) {
  //                               vital["value"] =
  //                                   controllers[vital["name"]]!.text;
  //                             }
  //                           });
  //                           controllers.forEach((_, c) => c.dispose());
  //                           Navigator.pop(context);
  //                         },
  //                         style: ElevatedButton.styleFrom(
  //                           backgroundColor: const Color(0xFF0056B3),
  //                           shape: RoundedRectangleBorder(
  //                             borderRadius: BorderRadius.circular(12),
  //                           ),
  //                           padding: const EdgeInsets.symmetric(
  //                             horizontal: 24,
  //                             vertical: 12,
  //                           ),
  //                         ),
  //                         child: const Text(
  //                           "Save",
  //                           style: TextStyle(
  //                             color: Colors.white,
  //                             fontSize: 16,
  //                             fontWeight: FontWeight.bold,
  //                           ),
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔹 Header
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blueAccent, Colors.lightBlue],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(Icons.person, color: Colors.blue),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Nurse: Anna Smith",
                            style: GoogleFonts.varelaRound(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "09 Sep 2025, 10:20 AM",
                            style: GoogleFonts.varelaRound(
                              fontSize: 13,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.white),
                    onPressed: () async {
                      final updatedVitals = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => VitalEditPage(vitals: vitals),
                        ),
                      );

                      if (updatedVitals != null) {
                        setState(() {
                          vitals = updatedVitals;
                        });
                      }
                    },
                  ),
                ],
              ),
            ),

            // 🔹 Vitals List
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Column(
                children: vitals.map((vital) {
                  return Card(
                    elevation: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 12,
                        bottom: 12,
                        left: 9,
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              // Icon(
                              //  HealthIcons.CommunityHealthworker,
                              //   color: vital["danger"] == true
                              //       ? Colors.red
                              //       : Colors.blue,
                              //   size: 20,
                              // ),
                              vital["icon"],
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  vital["name"]!,
                                  style: GoogleFonts.varelaRound(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 5,
                                ),
                                decoration: BoxDecoration(
                                  color: vital["danger"] == true
                                      ? Colors.red.withOpacity(0.1)
                                      : Colors.blue.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  vital["value"]!,
                                  style: GoogleFonts.varelaRound(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: vital["danger"] == true
                                        ? Colors.red
                                        : Colors.blue,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PainRateTab extends StatelessWidget {
  const PainRateTab({super.key});

  @override
  Widget build(BuildContext context) {
    final painLevel = 6; // example value 0–10

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Wong-Baker Pain Scale",
            style: GoogleFonts.varelaRound(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          const SizedBox(height: 12),

          // Pain level visualization (faces scale placeholder)
          Center(
            child: Column(
              children: [
                Text(
                  "Pain Level: $painLevel / 10",
                  style: GoogleFonts.varelaRound(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: painLevel >= 7 ? Colors.red : Colors.blue,
                  ),
                ),
                const SizedBox(height: 16),
                Image.asset(
                  "assets/images/WongBaker.png", // your pain scale image
                  height: 150,
                  fit: BoxFit.contain,
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),
          Text(
            "Entered by: Nurse Michael",
            style: GoogleFonts.varelaRound(fontSize: 14, color: Colors.black87),
          ),
          Text(
            "Date: 2025-09-09, 11:00 AM",
            style: GoogleFonts.varelaRound(fontSize: 14, color: Colors.black54),
          ),
        ],
      ),
    );
  }
}
