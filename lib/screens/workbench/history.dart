import 'package:flutter/material.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
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
      "data": ["Hypertension (since 2010)", "Diabetes (Type 2)"],
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

  final List<String> _categories = [
    "Medical Alerts",
    "Sensitivity or Allergy",
    "Past Medical History",
    "Nutritional History",
    "Surgical History",
    "Family History",
    "Social History",
    "Other History",
  ];

  final TextEditingController _detailsController = TextEditingController();
  String? _selectedCategory;

  @override
  void dispose() {
    _detailsController.dispose();
    super.dispose();
  }

   void _showAddHistoryDialog(String catogory) {
    _selectedCategory = null;
    _detailsController.clear();

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                 Text(
                 "Add $catogory",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: "Select Category",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                  ),
                  value: catogory.isNotEmpty && catogory != "History"?_selectedCategory = catogory : _selectedCategory,
                  items: _categories.map((category) {
                    return DropdownMenuItem(
                      value: category,
                      child: Text(category),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() => _selectedCategory = value);
                  },
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _detailsController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    labelText: "Details",
                    hintText: "Enter new history details...",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text("Cancel"),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      icon: const Icon(Icons.save, size: 18, color: Colors.white,),
                      label: const Text("Add",style: TextStyle(color: Colors.white),),
                      onPressed: () {
                        if (_selectedCategory != null &&
                            _detailsController.text.isNotEmpty) {
                          setState(() {
                            final category = _historyData.firstWhere(
                              (element) => element["name"] == _selectedCategory,
                            );
                            category["data"].add(_detailsController.text);
                          });
                          Navigator.of(context).pop();
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHistoryCard(Map<String, dynamic> item) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          childrenPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          leading: Icon(Icons.history, color: Colors.blue[700]),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    item["name"],
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  SizedBox(width: 8),
                  item["data"].isNotEmpty
                      ? Text(
                          "*",
                          style: TextStyle(color: Colors.red, fontSize: 25),
                        )
                      : SizedBox(width: 4),
                ],
              ),
              item["data"].isNotEmpty
                  ? SizedBox()
                  : Card(elevation: 0,
                  color: Colors.transparent,
                      clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(39),
                      ),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(32),
                        radius: 30,
                        onTap: () {
                          _showAddHistoryDialog( item["name"]);
                          print(item["name"]);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Icon(Icons.edit, size: 25, color: Colors.grey),
                        ),
                      ),
                    ),
            ],
          ),
          children: item["data"].isNotEmpty
              ? item["data"].map<Widget>((detail) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 6.0),
                    child: Row(
                      children: [
                        const Icon(Icons.circle, size: 8, color: Colors.blue),
                        const SizedBox(width: 8),
                        Expanded(child: Text(detail)),
                      ],
                    ),
                  );
                }).toList()
              : [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "No data available.",
                      style: TextStyle(
                        color: Colors.black38,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
        ),
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            onPressed:(){_showAddHistoryDialog("History");} ,
            icon: const Icon(Icons.add_circle_outline),
            tooltip: 'Add new history',
          ),
        ],
        backgroundColor: Colors.blue[700],
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: _historyData.length,
        itemBuilder: (context, index) {
          return _buildHistoryCard(_historyData[index]);
        },
      ),
    );
  }
}
