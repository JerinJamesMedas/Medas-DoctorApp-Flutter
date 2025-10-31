import 'package:flutter/material.dart';

class EditableCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final TextEditingController controller;
  final List<String> points;
  final VoidCallback onSave;
  final ValueChanged<String>? onChanged;

  const EditableCard({
    super.key,
    required this.title,
    required this.icon,
    required this.controller,
    required this.points,
    required this.onSave,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 6),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Icon(icon, color: Colors.blueAccent),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            TextField(
              controller: controller,
              maxLines: null,
              onChanged: onChanged,
              decoration: InputDecoration(
                hintText: "Enter $title...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Colors.blue, // change to your desired color
                    width: 2,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: onSave,
              icon: const Icon(Icons.save, color: Colors.blueAccent),
              label: const Text(
                "Save",
                style: TextStyle(color: Colors.blueAccent),
              ),
            ),
            if (points.isNotEmpty) const Divider(),
            ...points.map(
              (p) => Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("• "),
                    Expanded(child: Text(p)),
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
