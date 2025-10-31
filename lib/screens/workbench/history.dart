import 'package:flutter/material.dart';

class History extends StatelessWidget {
  History({super.key});

  final List<Map<String, dynamic>> _historyData = [
    {
      "name": "Medical Alerts",
      "data": ["Penicillin Allergy"],
    },
    {
      "name": "Sensitivity or Allergy",
      "data": ["Latex", "Tree Nuts"],
    },
    {
      "name": "Past Medical History",
      "data": ["Hypertension (since 2010)", "Diabetes (Type-2)"],
    },
    {"name": "Nutritional History", "data": []},
    {
      "name": "Surgical History",
      "data": ["Appendectomy (2015)"],
    },
    {
      "name": "Family History",
      "data": ["Mother: Heart Disease", "Father: High Cholesterol"],
    },
    {
      "name": "Social History",
      "data": ["Smoker (2-3 cigarettes daily)", "Social alcohol use"],
    },
    {"name": "Other History", "data": []},
  ];

  Widget _buildSection(Map<String, dynamic> item) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item["name"],
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          const SizedBox(height: 6),
          if (item["data"].isNotEmpty)
            ...item["data"].map<Widget>((detail) {
              return Padding(
                padding: const EdgeInsets.only(left: 12, bottom: 4),
                child: Row(
                  children: [
                    const Icon(Icons.circle, size: 8, color: Colors.black54),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        detail,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
              );
            }).toList()
          else
            const Padding(
              padding: EdgeInsets.only(left: 12, bottom: 4),
              child: Text(
                "No data available.",
                style: TextStyle(
                  color: Colors.black38,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          const Divider(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Patient History",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue[700],
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Card(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListView(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                alignment: Alignment.centerLeft,
                child: const Text(
                  "History Overview",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ),
              const Divider(),
              ..._historyData.map((item) => _buildSection(item)),
            ],
          ),
        ),
      ),
    );
  }
}
