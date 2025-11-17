import 'package:doctors_app/common_class/route.dart';
import 'package:flutter/material.dart';

class PatientHistory extends StatefulWidget {
  const PatientHistory({super.key});

  @override
  State<PatientHistory> createState() => _PatientHistoryState();
}

class _PatientHistoryState extends State<PatientHistory> {
  final List<Map<String, dynamic>> _historyData = [
    // {
    //   "name": "Medical Alerts",
    //   "data": ["Penicillin Allergy"],
    // },
    {
      "name": "Sensitivity or Allergy",
      "data": ["Latex", "Tree Nuts"],
      "id" : "1"
    },
    // {
    //   "name": "Past Medical History",
    //   "data": ["Hypertension (since 2010)", "Diabetes (Type-2)"],
    // },
    // {"name": "Nutritional History", "data": []},
    // {
    //   "name": "Surgical History",
    //   "data": ["Appendectomy (2015)"],
    // },
    // {
    //   "name": "Family History",
    //   "data": ["Mother: Heart Disease", "Father: High Cholesterol"],
    // },
    // {
    //   "name": "Social History",
    //   "data": ["Smoker (2-3 cigarettes daily)", "Social alcohol use"],
    // },
    // {"name": "Other History", "data": []},
  ];

  bool _addSectionExpanded = false;

  @override
  void _onpage(String id){
    switch(id){
      case "1":
        Navigator.pushNamed(context, AppRouter.addllergy);
        break;
    }
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
        child: ListView(
          children: [
            // ------------------------------------------------------
            // Card #1: Add New Data Section (Collapsible)
            // ------------------------------------------------------
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Theme(
                data: Theme.of(context).copyWith(
                  dividerColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                ),
                child: ExpansionTile(
                  initiallyExpanded: false,
                  onExpansionChanged: (v) => setState(() {
                    _addSectionExpanded = v;
                  }),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        "Add History",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      Icon(Icons.add, color: Colors.blue),
                    ],
                  ),
                  children: [
                    const SizedBox(height: 10),

                    ..._historyData.map((item) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 2,
                          child: ListTile(
                            title: Text(
                              item["name"],
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                            trailing: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: Colors.blue.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: Colors.blue,
                                  width: 1,
                                ),
                              ),
                              child: const Icon(
                                Icons.add,
                                color: Colors.blue,
                                size: 20,
                              ),
                            ),
                            onTap: () {
                             _onpage(item["id"]);
                             print("hii");
                            },
                          ),
                        ),
                      );
                    }).toList(),

                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // ------------------------------------------------------
            // Card #2: Existing Stored Data (NOT collapsible)
            // ------------------------------------------------------
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      "Existing History",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ),

                  const Divider(height: 1),

                  ..._historyData.map((item) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        color: Colors.grey.shade100,
                        elevation: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item["name"],
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 8),

                              if (item["data"].isNotEmpty)
                                ...item["data"].map<Widget>((detail) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 4,
                                    ),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.circle,
                                          size: 8,
                                          color: Colors.black54,
                                        ),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: Text(
                                            detail,
                                            style: const TextStyle(
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList()
                              else
                                const Text(
                                  "No data available",
                                  style: TextStyle(
                                    color: Colors.black38,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
