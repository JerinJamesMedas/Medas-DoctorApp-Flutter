import 'package:flutter/material.dart';

class BuildDiagnosisTile extends StatelessWidget {
  const BuildDiagnosisTile({
    super.key,
    required this.diagnosis,
    required this.icd,
    required this.category,
    required this.isPrimary,
  });

  final String diagnosis;
  final String icd;
  final String category;
  final bool isPrimary;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(
        isPrimary ? Icons.star_rounded : Icons.check_circle_outline,
        color: isPrimary ? Colors.blue : Colors.black54,
      ),
      title: Text(
        diagnosis,
        style: TextStyle(
          fontWeight: isPrimary ? FontWeight.bold : FontWeight.normal,
          color: isPrimary ? Colors.blue : Colors.black,
        ),
      ),
      subtitle: Text("ICD: $icd • $category"),
      trailing: IconButton(
        icon: const Icon(Icons.delete_outline, color: Colors.red,size: 21,),
        onPressed: () {},
      ),
    );
  }
}
