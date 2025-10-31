import 'package:flutter/material.dart';

class buildmedicationcard extends StatelessWidget {
  const buildmedicationcard({
    super.key,
    required this.name,
    required this.ingredients,
    required this.dosage,
    required this.remarks,
  });

  final String name;
  final String ingredients;
  final String dosage;
  final String remarks;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: const Icon(Icons.medication_outlined, color: Colors.blue),
      title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(
        "$ingredients\n$dosage\nRemarks: $remarks",
        style: const TextStyle(height: 1.4),
      ),
      trailing: IconButton(
        icon: const Icon(Icons.edit_note_outlined, color: Colors.blue),
        onPressed: () {},
      ),
    );
  }
}
