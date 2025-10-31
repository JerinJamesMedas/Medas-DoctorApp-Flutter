import 'package:flutter/material.dart';

class ReviewOfSystemsCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final String? selectedSystem;
  final String? selectedIssue;
  final List<String> selectedIssues;
  final Map<String, List<String>> systemIssues;
  final ValueChanged<String?> onSystemChanged;
  final ValueChanged<String?> onIssueSelected;
  final ValueChanged<String> onChipRemoved;

  const ReviewOfSystemsCard({
    super.key,
    required this.title,
    required this.icon,
    this.selectedSystem,
    this.selectedIssue,
    required this.selectedIssues,
    required this.systemIssues,
    required this.onSystemChanged,
    required this.onIssueSelected,
    required this.onChipRemoved,
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
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            SizedBox(height: 7),
            Theme(
              data: Theme.of(
                context,
              ).copyWith(dividerColor: Colors.transparent),
              child: DropdownButtonFormField<String>(
                value: selectedSystem,
                hint: const Text("Select System"),
                onChanged: onSystemChanged,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12), // Rounded corners
                    borderSide: const BorderSide(color: Colors.grey, width: 1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.grey, width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.blue, width: 2),
                  ),
                ),
                items: systemIssues.keys
                    .map(
                      (system) =>
                          DropdownMenuItem(value: system, child: Text(system)),
                    )
                    .toList(),
              ),
            ),

            const SizedBox(height: 18),
            if (selectedSystem != null)
              Theme(
                data: Theme.of(context).copyWith(
                  dividerColor:
                      Colors.transparent, // remove internal dropdown dividers
                ),
                child: DropdownButtonFormField<String>(
                  value: selectedIssue,
                  hint: const Text("Select Issue"),
                  onChanged: onIssueSelected,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        12,
                      ), // Rounded corners
                      borderSide: const BorderSide(
                        color: Colors.grey,
                        width: 1,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: Colors.grey,
                        width: 1,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: Colors.blue,
                        width: 2,
                      ),
                    ),
                  ),
                  items: (systemIssues[selectedSystem] ?? [])
                      .map(
                        (issue) =>
                            DropdownMenuItem(value: issue, child: Text(issue)),
                      )
                      .toList(),
                ),
              ),

            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              children: selectedIssues.map((issue) {
                return Chip(
                  label: Text(issue),
                  deleteIcon: const Icon(Icons.close),
                  onDeleted: () => onChipRemoved(issue),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
