import 'package:flutter/material.dart';

class ReadOnlyCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<String> points;

  const ReadOnlyCard({
    super.key,
    required this.title,
    required this.icon,
    required this.points,
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: Colors.blueAccent),
                const SizedBox(width: 8),
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ],
            ),
            const SizedBox(height: 8),
            if (points.isEmpty) const Text("No data added yet."),
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
}
