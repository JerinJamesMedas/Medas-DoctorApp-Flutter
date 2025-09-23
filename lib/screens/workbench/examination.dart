import 'package:doctors_app/common_class/textStyle.dart';
import 'package:flutter/material.dart';

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
    {"title": "Confidential Statement", "icon": Icons.lock_outline, "readOnly": true},
    {"title": "Chief Complaint / HPI", "icon": Icons.healing_outlined, "readOnly": true},
    {"title": "Review of Systems", "icon": Icons.fact_check_outlined},
    {"title": "Significant Signs", "icon": Icons.warning_amber_rounded},
    {"title": "Examination Diagram", "icon": Icons.insert_photo_outlined},
    {"title": "Clinical Examination / Assessment", "icon": Icons.medical_services_outlined},
    {"title": "Examination Notes", "icon": Icons.note_alt_outlined},
    {"title": "Progress Notes", "icon": Icons.timeline_outlined, "readOnly": true},
  ];

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

  void _saveData(String title, BuildContext context) async {
    final text = controllers[title]?.text.trim() ?? "";
    if (text.isEmpty) return;

    // Show confirmation dialog
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Confirm Save"),
        content: Text("Do you want to save this entry to '$title'?"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text("Cancel")),
          ElevatedButton(onPressed: () => Navigator.pop(ctx, true), child: const Text("OK")),
        ],
      ),
    );

    if (confirmed == true) {
      setState(() {
        savedData[title]?.add(text);
        controllers[title]?.clear();
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("$title updated successfully!")),
      );
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
    ),
    body: ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: orderedSections.length,
      itemBuilder: (context, index) {
        final section = orderedSections[index];
        final title = section["title"];
        final icon = section["icon"];
        final readOnly = section["readOnly"] ?? false;

        if (readOnly) {
          return _buildReadOnlyCard(title, icon);
        } else {
          return _buildExpansionTile(title, icon, context);
        }
      },
    ),
  );
}

  Widget _buildReadOnlyCard(String title, IconData icon) {
    final points = savedData[title] ?? [];
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 6),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: Colors.blueAccent),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ],
            ),
            Theme(data: Theme.of(context).copyWith(dividerColor: Colors.transparent),child: const Divider(color:  Colors.transparent,)),
            if (points.isEmpty)
              const Text("No data added yet."),
            ...points.map((p) => Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("• "),
                      Expanded(child: Text(p)),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildExpansionTile(String title, IconData icon, BuildContext context) {
    final points = savedData[title] ?? [];
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 6),
      elevation: 2,
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          leading: Icon(icon, color: Colors.blueAccent),
          title: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  TextField(
                    controller: controllers[title],
                    maxLines: null,
                    decoration: InputDecoration(
                      hintText: "Enter $title...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton.icon(
                    onPressed: () => _saveData(title, context),
                    icon: const Icon(Icons.save),
                    label: const Text("Save"),
                  ),
                  if (points.isNotEmpty) const Divider(),
                  ...points.map((p) => Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("• "),
                            Expanded(child: Text(p)),
                          ],
                        ),
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
