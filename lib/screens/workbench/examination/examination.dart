import 'package:doctors_app/common_class/textStyle.dart';
import 'package:flutter/material.dart';
import 'ReadOnlyCard.dart';
import 'EditableCard.dart';
import 'ReviewOfSystemsCard.dart';

class Examination extends StatefulWidget {
  const Examination({super.key});

  @override
  State<Examination> createState() => _ExaminationState();
}

class _ExaminationState extends State<Examination> {
  final Map<String, List<String>> savedData = {
    "Confidential Statement": [],
    "Chief Complaint / HPI": [],
    "Review of Systems": [],
    "Significant Signs": [],
    "Examination Diagram": [],
    "Clinical Examination / Assessment": [],
    "Examination Notes": [],
    "Progress Notes": [],
  };

  final List<Map<String, dynamic>> _sections = const [
    {
      "title": "Confidential Statement",
      "icon": Icons.lock_outline,
      "readOnly": true,
    },
    {
      "title": "Chief Complaint / HPI",
      "icon": Icons.healing_outlined,
      "isEditable": true,
    },
    {
      "title": "Review of Systems",
      "icon": Icons.fact_check_outlined,
      "isEditable": true,
    }, // special dropdown logic
    {
      "title": "Significant Signs",
      "icon": Icons.warning_amber_rounded,
      "isEditable": true,
    },
    {"title": "Examination Diagram", "icon": Icons.insert_photo_outlined, },
    {
      "title": "Clinical Examination / Assessment",
      "icon": Icons.medical_services_outlined,
      "readOnly": true,
    },
    {"title": "Examination Notes", "icon": Icons.note_alt_outlined},
    {
      "title": "Progress Notes",
      "icon": Icons.timeline_outlined,
      "readOnly": true,
    },
  ];

  final Map<String, List<String>> systemIssues = {
    "Eyes": ["Dry eye", "Blind spot", "Tear eye", "Vision loss"],
    "Endocrine": ["Thyroid issue", "Diabetes", "Hormone imbalance"],
    "Respiratory": ["Asthma", "Cough", "Breathlessness"],
    "Neurological": ["Headache", "Seizures", "Memory loss"],
  };

  String? selectedSystem;
  String? selectedIssue;
  bool _hasChanges = false; // tracks any unsaved change

  final List<String> selectedIssues = [];

  final Map<String, TextEditingController> controllers = {};

  @override
  void initState() {
    super.initState();
    for (var section in _sections) {
      controllers[section["title"]] = TextEditingController();
    }
  }

  @override
  void dispose() {
    for (var c in controllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  void _saveAll(BuildContext context) async {
    bool confirmed =
        await showDialog<bool>(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text("Confirm Save"),
            content: const Text("Do you want to save all changes?"),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx, false),
                child: const Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(ctx, true),
                child: const Text("OK"),
              ),
            ],
          ),
        ) ??
        false;

    if (confirmed) {
      setState(() {
        // Save all text fields
        controllers.forEach((key, controller) {
          if (controller.text.trim().isNotEmpty) {
            savedData[key]?.add(controller.text.trim());
            controller.clear();
          }
        });

        // Save Review of Systems chips
        savedData["Review of Systems"] = List.from(selectedIssues);

        _hasChanges = false; // reset flag
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("All changes saved successfully!")),
      );
    }
  }

  void _saveData(String title, BuildContext context) async {
    final text = controllers[title]?.text.trim() ?? "";
    if (text.isEmpty) return;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Confirm Save"),
        content: Text("Do you want to save this entry to '$title'?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text("OK"),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      setState(() {
        savedData[title]?.add(text);
        controllers[title]?.clear();
        _hasChanges = false; // reset changes after save
      });

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("$title updated successfully!")));
    }
  }

  @override
  Widget build(BuildContext context) {
    // Reorder sections: readOnly first, others after
    final orderedSections = [
      ..._sections.where((s) => s["readOnly"] == true),
      ..._sections.where((s) => s["readOnly"] != true),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 70, 155, 225),
        title: const Text(
          "Examination",
          style: TextStyle(
            color: Colors.white,
            fontSize: AppFontSize.h1,
            fontWeight: AppFontWeight.semiBold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          if (_hasChanges)
            TextButton.icon(
              onPressed: () {
                // You can call a save all function here
                _saveAll(context);
              },
              icon: const Icon(Icons.save, color: Colors.white),
              label: const Text("Save", style: TextStyle(color: Colors.white)),
            ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: orderedSections.length,
        itemBuilder: (context, index) {
          final section = orderedSections[index];
          final title = section["title"];
          final icon = section["icon"];
          final readOnly = section["readOnly"] ?? false;
          final isEditable = section["isEditable"] ?? false;

          if (readOnly) {
            return ReadOnlyCard(
              title: title,
              icon: icon,
              points: savedData[title]!,
            );
          } else if (title == "Review of Systems") {
            return ReviewOfSystemsCard(
              title: title,
              icon: icon,
              selectedSystem: selectedSystem,
              selectedIssue: selectedIssue,
              selectedIssues: selectedIssues,
              systemIssues: systemIssues,
              onSystemChanged: (value) => setState(() {
                selectedSystem = value;
                selectedIssue = null;
              }),
              onIssueSelected: (value) {
                if (value != null && !selectedIssues.contains(value)) {
                  setState(() {
                    selectedIssue = value;
                    selectedIssues.add(value);
                    _hasChanges = true;
                  });
                }
              },
              onChipRemoved: (issue) => setState(() {
                selectedIssues.remove(issue);
                _hasChanges = true;
              }),
            );
          } else if (isEditable) {
            return EditableCard(
              title: title,
              icon: icon,
              controller: controllers[title]!,
              points: savedData[title]!,
              onSave: () => _saveData(title, context),
              onChanged: (_) => setState(() => _hasChanges = true),
            );
          }
          return null;
        },
      ),
    );
  }
}
