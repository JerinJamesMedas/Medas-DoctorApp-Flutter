import 'package:flutter/material.dart';

class VitalEditPage extends StatefulWidget {
  final List<Map<String, dynamic>> vitals;

  const VitalEditPage({super.key, required this.vitals});

  @override
  State<VitalEditPage> createState() => _VitalEditPageState();
}

class _VitalEditPageState extends State<VitalEditPage> {
  late Map<String, TextEditingController> controllers;
  bool isSaving = false;

  // Simple icon mapping per vital name
  // IconData _iconForVital(String name) {
  //   switch (name.toLowerCase()) {
  //     case 'heart rate':
  //       return Icons.favorite;
  //     case 'blood pressure':
  //       return Icons.bloodtype;
  //     case 'temperature':
  //       return Icons.thermostat;
  //     case 'respiratory rate':
  //       return Icons.air;
  //     case 'spo2':
  //       return Icons.bubble_chart;
  //     default:
  //       return Icons.expand_more;
  //   }
  // }

  // Determine input type
  TextInputType _inputTypeForVital(String name) {
    return name.toLowerCase().contains('rate') || name.toLowerCase().contains('pressure') || name.toLowerCase().contains('temp')
        ? TextInputType.number
        : TextInputType.text;
  }

  @override
  void initState() {
    super.initState();
    controllers = {
      for (var vital in widget.vitals)
        vital["name"]: TextEditingController(text: vital["value"]),
    };
  }

  @override
  void dispose() {
    for (var c in controllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _saveVitals() async {
    setState(() => isSaving = true);
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      for (var vital in widget.vitals) {
        vital["value"] = controllers[vital["name"]]!.text;
      }
      isSaving = false;
    });

    Navigator.pop(context, widget.vitals);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      appBar: AppBar(
        title: const Text(
          "Edit Vital Signs",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Update the patient’s vital signs. Click save when you're done.",
              style: TextStyle(color: Colors.black54, fontSize: 14),
            ),
            const SizedBox(height: 18),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  int crossAxisCount = constraints.maxWidth > 600 ? 3 : 2;
                  return GridView.count(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 14,
                    mainAxisSpacing: 14,
                    childAspectRatio: 2.8,
                    children: widget.vitals.map((vital) {
                      return Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                          child: Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: const Color(0xFFEEF4FE),
                                child: vital["icon"],
                                radius: 18,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: TextField(
                                  controller: controllers[vital["name"]],
                                  keyboardType: _inputTypeForVital(vital["name"]),
                                  decoration: InputDecoration(
                                    labelText: vital["name"],
                                    floatingLabelBehavior: FloatingLabelBehavior.never,
                                    border: InputBorder.none,
                                    hintText: 'Enter value',
                                    hintStyle: TextStyle(color: Colors.grey),
                                  ),
                                  style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  );
                }
              ),
            ),
            const SizedBox(height: 18),
            Align(
              alignment: Alignment.centerRight,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: isSaving
                    ? const SizedBox(
                        key: ValueKey('loading'),
                        width: 34,
                        height: 34,
                        child: CircularProgressIndicator(
                          color: Color(0xFF0066FF),
                          strokeWidth: 3,
                        ),
                      )
                    : ElevatedButton(
                        key: const ValueKey('button'),
                        onPressed: _saveVitals,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF0066FF),
                          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          elevation: 1,
                        ),
                        child: const Text(
                          "Save Changes",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 0.4,
                          ),
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
