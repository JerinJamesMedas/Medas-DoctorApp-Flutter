import 'package:doctors_app/common_class/textstyle.dart';
import 'package:doctors_app/screens/workbench/diagnosis/build_diagnosis_tile.dart';
import 'package:doctors_app/screens/workbench/diagnosis/buildcard.dart';
import 'package:doctors_app/screens/workbench/diagnosis/buildmedicationcard.dart';
import 'package:doctors_app/screens/workbench/diagnosis/final_diagnosis.dart';
// import 'package:doctors_app/screens/workbench/diagnosis/final_diagnosis.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class Diagnosis extends StatefulWidget {
  const Diagnosis({super.key});

  @override
  State<Diagnosis> createState() => _DiagnosisState();
}

class _DiagnosisState extends State<Diagnosis> {
  final List<String> selectedDiagnoses = [];
  final List<String> provisionalDiagnoses = [
    "Cholera, unspecified",
    "Typhoid fever",
    "Malaria",
    "Dengue",
    "Influenza",
    "Pneumonia",
    "Tuberculosis",
    "Hepatitis A",
    "Hepatitis B",
    "Diabetes Mellitus",
    "Hypertension",
    "Asthma",
    "COPD",
    "Migraine",
    "Anemia",
    "Arthritis",
    "Gastritis",
    "Appendicitis",
    "Bronchitis",
    "Urinary Tract Infection",
    "COVID-19",
    "Hypothyroidism",
  ];

  final finalDiagnosis = [
    {
      "diagnosis": "Typhoid arthritis",
      "icd": "A01.04",
      "category": "Primary",
      "isPrimary": true,
    },
    {
      "diagnosis": "Cholera, unspecified",
      "icd": "A00.9",
      "category": "Secondary",
      "isPrimary": false,
    },
  ];

  void _deleteItem(int index) {
    setState(() {
      finalDiagnosis.removeAt(index);
    });
  }

  void _changePriority(int index) async {
    if (index > 0) {
      // Show confirmation dialog
      bool? confirm = await showDialog<bool>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Change Primary Diagnosis"),
            content: const Text(
              "Do you really want to make this diagnosis the primary?",
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text(
                  "Cancel",
                  style: TextStyle(color: Colors.blueAccent),
                ),
              ),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text(
                  "Yes",
                  style: TextStyle(color: Colors.blueAccent),
                ),
              ),
            ],
          );
        },
      );

      // If user confirmed
      if (confirm == true) {
        setState(() {
          final item = finalDiagnosis.removeAt(index);
          finalDiagnosis.insert(index - 1, item); // move up by 1
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Shared dynamic data (temporary, later we can move to provider/db)
    final provisionalDiagnosis = [
      {
        "diagnosis": "Cholera, unspecified",
        "icd": "A00.9",
        "category": "Secondary",
        "isPrimary": false,
      },
    ];

    final medications = [
      {
        "name": "Panda Extra Caplets",
        "ingredients": "Paracetamol, Caffeine Citrate",
        "dosage": "1 Tablet • Oral • 2x daily • 10 days",
        "remarks": "Take 1 capsule after meal daily for 10 days (1-0-1)",
      },
    ];

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        title: const Text(
          "Patient Diagnosis",
          style: TextStyle(
            color: Colors.white,
            fontWeight: AppFontWeight.medium,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(LucideIcons.save, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Provisional Diagnosis
          buildcard(
            title: "Provisional / Differential Diagnosis",
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (var item in provisionalDiagnosis)
                  BuildDiagnosisTile(
                    diagnosis: item["diagnosis"]! as String,
                    icd: item["icd"]! as String,
                    category: item["category"]! as String,
                    isPrimary: item["isPrimary"] as bool,
                  ),
                const SizedBox(height: 8),
                OutlinedButton.icon(
                  onPressed: () {
                    privisional_dialouge(context);
                  },
                  icon: const Icon(Icons.add),
                  label: const Text("Add Diagnosis"),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.blueAccent, // Text & Icon color
                    side: const BorderSide(
                      color: Colors.blueAccent,
                    ), // Button border
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        18,
                      ), // Rounded corners
                    ),
                  ),
                ),
              ],
            ),
          ),

          //final diagnosis new

          // Final Diagnosis
          buildcard(
            title: "Final Diagnosis",
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (var entry in finalDiagnosis.asMap().entries)
                  BuildfinalDiagnosisCard(
                    title: entry.value["diagnosis"]! as String,
                    onChangePriority: () => _changePriority(entry.key),
                    onDelete: () => _deleteItem(entry.key),
                    priority: entry.key,
                    child: Text(entry.value["icd"] as String),
                  ),
                const SizedBox(height: 8),
                OutlinedButton.icon(
                  onPressed: () {
                    // Add your logic here
                  },
                  icon: const Icon(Icons.add),
                  label: const Text("Add Final Diagnosis"),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.blueAccent, // Text & Icon color
                    side: const BorderSide(
                      color: Colors.blueAccent,
                    ), // Button border
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        18,
                      ), // Rounded corners
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Management Plan
          buildcard(
            title: "Management Plan",
            child: const Text(
              "No records found",
              style: TextStyle(color: Colors.grey),
            ),
          ),

          // Medications
          buildcard(
            title: "Medications",
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (var med in medications)
                  buildmedicationcard(
                    name: med["name"]!,
                    ingredients: med["ingredients"]!,
                    dosage: med["dosage"]!,
                    remarks: med["remarks"]!,
                  ),
                const SizedBox(height: 8),
                OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.add),
                  label: const Text("Add Medication"),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.blueAccent, // Text & Icon color
                    side: const BorderSide(
                      color: Colors.blueAccent,
                    ), // Button border
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        18,
                      ), // Rounded corners
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<dynamic> privisional_dialouge(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          backgroundColor: Colors.white,
          title: const Text(
            "Add Provisional Diagnosis",
            style: TextStyle(
              color: Colors.blueAccent,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          content: SizedBox(
            width: double.maxFinite,
            height: 428,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 230,
                  child: Expanded(
                    child: Card(
                      elevation: 3,
                      child: Scrollbar(
                        child: ListView.builder(
                          itemCount: provisionalDiagnoses.length,
                          itemBuilder: (context, index) {
                            final diagnosis = provisionalDiagnoses[index];
                            final isSelected = selectedDiagnoses.contains(
                              diagnosis,
                            );
                            return ListTile(
                              title: Text(
                                diagnosis,
                                style: TextStyle(
                                  color: isSelected
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                              tileColor: isSelected ? Colors.blueAccent : null,
                              onTap: () {
                                setState(() {
                                  if (isSelected) {
                                    selectedDiagnoses.remove(diagnosis);
                                  } else {
                                    selectedDiagnoses.add(diagnosis);
                                  }
                                });
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Selected Diagnosis",
                  style: TextStyle(
                    color: Colors.blueAccent,
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                  
                ),
                const SizedBox(height: 6),
                if (selectedDiagnoses.isNotEmpty)
                  SizedBox(
                    height: 162,
                    width: 280,
                    child: Card(
                      color: const Color.fromARGB(
                        255,
                        245,
                        245,
                        245,
                      ).withOpacity(0.8),
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Scrollbar(
                          thumbVisibility:
                              true, // optional: always show scrollbar
                          child: SingleChildScrollView(
                            child: Wrap(
                              direction: Axis.horizontal,
                              spacing: 8,
                              runSpacing: 6,
                              alignment: WrapAlignment.start,
                              runAlignment: WrapAlignment.start,
                              children: selectedDiagnoses
                                  .map(
                                    (d) => Container(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 6,
                                        horizontal: 12,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.blueAccent,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Text(
                                        d,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                "Cancel",
                style: TextStyle(color: Colors.blueAccent),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
              ),
              onPressed: selectedDiagnoses.isNotEmpty
                  ? () {
                      // Handle adding selected diagnoses
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "${selectedDiagnoses.join(', ')} added successfully",
                          ),
                          backgroundColor: Colors.blueAccent,
                        ),
                      );
                    }
                  : null,
              child: const Text("Add", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
