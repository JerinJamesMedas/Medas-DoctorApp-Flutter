import 'package:doctors_app/common_class/animations/slider.dart';
import 'package:doctors_app/common_class/textStyle.dart';
import 'package:doctors_app/features/home/presentation/model/home_model.dart';
import 'package:doctors_app/features/home/presentation/widgets/patient_details.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StatusAll extends StatefulWidget {
  final String selection;
  final String heading;
  final List<ConsultationModel> patient;
  const StatusAll({super.key, required this.heading, required this.patient, required this.selection});

  @override
  State<StatusAll> createState() => _StatusAllState();
}

class _StatusAllState extends State<StatusAll> {
  String selectedpatients= "";
  int num = 1;
  // Dummy event data

  @override
  Widget build(BuildContext context) {
    if (num == 1) {
  selectedpatients = widget.selection;
  num = 0;
}
    // Filter events based on selected filter
final filteredpatient = selectedpatients == "All"
    ? widget.patient
    : widget.patient.where((e) {
        switch (selectedpatients) {
          case "OP":
            return e.visitTypeNew == "WALK IN";
          case "Visited":
            return e.visited == "VISITED";
          case "Revisit":
            return e.doctorVisitType == "REVISIT";
          // case "TotalAppointment":
          //   return widget.patient.isNotEmpty;
          // case "Referred":
          //   return e.referred == true;
          default:
            return true;
        }
      }).toList();

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back_ios),
        ),
        title: Text(
          widget.heading,
          style: const TextStyle(
            color: Colors.blue,
            fontSize: 19,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.search),
                SizedBox(width: 12),
                Icon(Icons.more_vert_outlined),
              ],
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Small filter chips
            Wrap(
              spacing: 8,
              children: [
                _buildFilterChip("All"),
                _buildFilterChip("OP"),
                _buildFilterChip("Visited"),
                _buildFilterChip("Revisit"),
                _buildFilterChip("Reffered"),
              ],
            ),

            const SizedBox(height: 20),

            // Filtered events list
            Expanded(
              child: ListView.builder(
                itemCount: filteredpatient.length,
                itemBuilder: (context, index) {
                  final p = filteredpatient[index];
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
                          p.patientName,
                          style: GoogleFonts.spaceGrotesk(
                            fontSize: AppFontSize.h3,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            shadows: [
                              Shadow(
                                offset: Offset(1.0, 1.0),
                                blurRadius: 2.0,
                                color: Colors.black.withOpacity(0.2),
                              ),
                            ],
                          ),
                        ),
                        subtitle: Text(
                          "${p.opNumber} | ${p.dateOfBirth} | ${p.visitTypeNew}",
                          style: GoogleFonts.spaceGrotesk(
                            fontSize: AppFontSize.body,
                            fontWeight: FontWeight.w500,
                            color: Colors.white70,
                          ),
                        ),
                        trailing: Icon(Icons.open_in_new, size: 21,color:  const Color.fromARGB(224, 255, 255, 255),),
                        onTap: () {
                          Navigator.push(
                            context,
                            SlideRightRoute(
                              page: PatientDetailsPage(patient: p),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label) {
    return ChoiceChip(
      label: Text(label),
      selected: selectedpatients == label,
      selectedColor: Colors.blue,
      backgroundColor: Colors.grey[200],
      labelStyle: TextStyle(
        color: selectedpatients == label ? Colors.white : Colors.black,
      ),
      onSelected: (bool selected) {
        setState(() {
          selectedpatients = label;
        });
      },
    );
  }
}
