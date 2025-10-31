import 'package:doctors_app/common_class/textstyle.dart';
import 'package:flutter/material.dart';

class Treatment extends StatefulWidget {
  const Treatment({super.key});

  @override
  State<Treatment> createState() => _TreatmentState();
}

class _TreatmentState extends State<Treatment> {
 double total = 0;
  // Current lists for display
  List<Package> packages = [
    Package(
      slNo: 1,
      packageName: "Comprehensive analysis package",
      activeFrom: "23-09-2025",
      qty: 1,
      gross: 1608.85,
      netAmount: 1608.85,
      balanceDue: 1608.85,
    ),
    Package(
      slNo: 2,
      packageName: "Test package",
      activeFrom: "23-09-2025",
      qty: 1,
      gross: 0.00,
      netAmount: 0.00,
      balanceDue: 0.00,
    ),
  ];

  List<Test> labTests = [
    Test(
      slNo: 1,
      testName: "ABDOMINAL PLAN X-RAY - STANDING POSITION",
      quantity: 1,
      price: 132.35,
      deductible: 132.35,
      remarks: "Sample Not Collected",
    ),
  ];

  List<Procedure> procedures = [
    Procedure(
      slNo: 1,
      procedureName: "Comprehensive analysis package",
      quantity: 1,
      price: 0.00,
      deductible: 0.00,
      remarks: "Not Done",
    ),
    Procedure(
      slNo: 2,
      procedureName: "Partial mandibular denture - resin base",
      quantity: 1,
      price: 617.65,
      deductible: 617.65,
      remarks: "Not Done",
    ),
  ];

  // Available packages to select in the dropdown
  List<Package> allPackages = [
    Package(
      packageName: "Basic",
      slNo: 3,
      activeFrom: "2025-01-01",
      qty: 1,
      gross: 100,
      netAmount: 90,
      balanceDue: 10,
    ),
    Package(
      packageName: "Standard",
      slNo: 4,
      activeFrom: "2025-01-01",
      qty: 1,
      gross: 200,
      netAmount: 180,
      balanceDue: 20,
    ),
  ];

  List<Test> allLabTests = [
    Test(
      slNo: 1,
      testName: "CBC (Complete Blood Count)",
      quantity: 1,
      price: 150.00,
      deductible: 150.00,
      remarks: "Not Collected",
    ),
    Test(
      slNo: 2,
      testName: "Blood Sugar (Fasting)",
      quantity: 1,
      price: 100.00,
      deductible: 100.00,
      remarks: "Not Collected",
    ),
    Test(
      slNo: 3,
      testName: "Lipid Profile",
      quantity: 1,
      price: 250.00,
      deductible: 250.00,
      remarks: "Not Collected",
    ),
    Test(
      slNo: 4,
      testName: "Liver Function Test (LFT)",
      quantity: 1,
      price: 200.00,
      deductible: 200.00,
      remarks: "Not Collected",
    ),
    Test(
      slNo: 5,
      testName: "Kidney Function Test (KFT)",
      quantity: 1,
      price: 180.00,
      deductible: 180.00,
      remarks: "Not Collected",
    ),
  ];

  List<Procedure> allProcedures = [
    Procedure(
      slNo: 1,
      procedureName: "Comprehensive analysis package",
      quantity: 1,
      price: 0.00,
      deductible: 0.00,
      remarks: "Not Done",
    ),
    Procedure(
      slNo: 2,
      procedureName: "Partial mandibular denture - resin base",
      quantity: 1,
      price: 617.65,
      deductible: 617.65,
      remarks: "Not Done",
    ),
    Procedure(
      slNo: 3,
      procedureName: "Complete oral prophylaxis",
      quantity: 1,
      price: 300.00,
      deductible: 300.00,
      remarks: "Not Done",
    ),
    Procedure(
      slNo: 4,
      procedureName: "Root canal treatment (single tooth)",
      quantity: 1,
      price: 2500.00,
      deductible: 2500.00,
      remarks: "Not Done",
    ),
    Procedure(
      slNo: 5,
      procedureName: "Tooth extraction (simple)",
      quantity: 1,
      price: 800.00,
      deductible: 800.00,
      remarks: "Not Done",
    ),
    Procedure(
      slNo: 6,
      procedureName: "Crown fitting (ceramic)",
      quantity: 1,
      price: 4500.00,
      deductible: 4500.00,
      remarks: "Not Done",
    ),
    Procedure(
      slNo: 7,
      procedureName: "Scaling & polishing",
      quantity: 1,
      price: 1000.00,
      deductible: 1000.00,
      remarks: "Not Done",
    ),
    Procedure(
      slNo: 8,
      procedureName: "Teeth whitening (basic session)",
      quantity: 1,
      price: 3500.00,
      deductible: 3500.00,
      remarks: "Not Done",
    ),
  ];
  @override
  void initState() {
    super.initState();
    _calculate();
  }

  @override
  void dispose(){
      super.dispose();
  }

  void _calculate() {

    // Calculate total
   total =
        packages.fold(0.0, (sum, item) => sum + item.netAmount) +
        labTests.fold(0, (sum, item) => sum + item.deductible) +
        procedures.fold(0, (sum, item) => sum + item.deductible);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: const Text(
          "Treatments",
          style: TextStyle(
            color: Colors.white,
            fontWeight: AppFontWeight.semiBold,
          ),
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildSection(
              title: "Package",
              children: packages.map((pkg) => _buildPackageCard(pkg)).toList(),
              onAdd: () => _showAddPackageDialog(),
            ),
            const SizedBox(height: 16),
            _buildSection(
              title: "Laboratory / Radiology",
              children: labTests.map((test) => _buildTestCard(test)).toList(),
              onAdd: () => _showAddLabDialog(),
            ),
            const SizedBox(height: 16),
            _buildSection(
              title: "Procedure / Treatment / Service",
              children: procedures
                  .map((proc) => _buildProcedureCard(proc))
                  .toList(),
              onAdd: () => _showAddProcedureDialog(),
            ),
            const SizedBox(height: 24),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                "Total: \$${total.toStringAsFixed(2)}",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Section with title + add icon
  Widget _buildSection({
    required String title,
    required List<Widget> children,
    required VoidCallback onAdd,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.add_circle, color: Colors.blueAccent),
              onPressed: onAdd,
            ),
          ],
        ),
        const SizedBox(height: 8),
        ...children,
      ],
    );
  }

  // Package card with expandable details
  Widget _buildPackageCard(Package pkg) {
    return Card(
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Package: ${pkg.packageName}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 4),
              _buildInfoRow("Sl No:", pkg.slNo.toString()),
              _buildInfoRow("Active From:", pkg.activeFrom),
            ],
          ),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoRow("Qty:", pkg.qty.toString()),
                  _buildInfoRow("Gross:", pkg.gross.toStringAsFixed(2)),
                  _buildInfoRow(
                    "Net Amount:",
                    pkg.netAmount.toStringAsFixed(2),
                  ),
                  _buildInfoRow(
                    "Balance Due:",
                    pkg.balanceDue.toStringAsFixed(2),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Lab test card
  Widget _buildTestCard(Test test) {
    return Card(
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Lab Test : ${test.testName}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 4),
              _buildInfoRow("Sl No :", test.slNo.toString()),
              _buildInfoRow("Quantity :", test.quantity.toString()),
            ],
          ),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoRow("Price:", test.price.toStringAsFixed(2)),
                  _buildInfoRow(
                    "Deductible: ",
                    test.deductible.toStringAsFixed(2),
                  ),
                  _buildInfoRow("Remarks:", test.remarks, isRemark: true),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Procedure card
  Widget _buildProcedureCard(Procedure proc) {
    return Card(
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          title: Column(
            children: [
              Text(
                "Procedure: ${proc.procedureName}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              _buildInfoRow("Sl No:", proc.slNo.toString()),
              _buildInfoRow("Quantity:", proc.quantity.toString()),
            ],
          ),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoRow("Price:", proc.price.toStringAsFixed(2)),
                  _buildInfoRow(
                    "Deductible:",
                    proc.deductible.toStringAsFixed(2),
                  ),
                  _buildInfoRow("Remarks:", proc.remarks, isRemark: true),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Info row helper
  Widget _buildInfoRow(String label, String value, {bool isRemark = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
          Text(
            value,
            style: TextStyle(color: isRemark ? Colors.red : Colors.black87),
          ),
        ],
      ),
    );
  }

  // Dialogs to add items
  void _showAddPackageDialog() {
    Package? selectedPackage;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              title: const Text("Select Package"),
              content: DropdownButton<Package>(
                hint: const Text("Choose a package"),
                value: selectedPackage,
                isExpanded: true,
                items: allPackages.map((pkg) {
                  return DropdownMenuItem(
                    value: pkg,
                    child: Text(pkg.packageName),
                  );
                }).toList(),
                onChanged: (pkg) {
                  setStateDialog(() {
                    selectedPackage = pkg;
                  });
                },
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancel"),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (selectedPackage != null) {
                      setState(() {
                        packages.add(selectedPackage!);
                      });
                      Navigator.pop(context);
                    }
                  },
                  child: const Text("Add"),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showAddLabDialog() {
    // Implement similar logic for lab tests
    Test? selectedTest;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              title: const Text("Select Package"),
              content: DropdownButton<Test>(
                hint: const Text("Choose a package"),
                value: selectedTest,
                isExpanded: true,
                items: allLabTests.map((test) {
                  return DropdownMenuItem(
                    value: test,
                    child: Text(test.testName),
                  );
                }).toList(),
                onChanged: (test) {
                  setStateDialog(() {
                    selectedTest = test;
                  });
                },
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancel"),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (selectedTest != null) {
                      setState(() {
                        labTests.add(selectedTest!);
                      });
                      Navigator.pop(context);
                    }
                  },
                  child: const Text("Add"),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showAddProcedureDialog() {
    // Implement similar logic for procedures
    Procedure? selectedProcedure;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              title: const Text("Select Package"),
              content: DropdownButton<Procedure>(
                hint: const Text("Choose a package"),
                value: selectedProcedure,
                isExpanded: true,
                items: allProcedures.map((pkg) {
                  return DropdownMenuItem(
                    value: pkg,
                    child: Text(pkg.procedureName),
                  );
                }).toList(),
                onChanged: (pkg) {
                  setStateDialog(() {
                    selectedProcedure = pkg;
                  });
                },
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancel"),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (selectedProcedure != null) {
                      setState(() {
                        procedures.add(selectedProcedure!);
                      });
                      Navigator.pop(context);
                    }
                  },
                  child: const Text("Add"),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

// Models
class Package {
  final int slNo;
  final String packageName;
  final String activeFrom;
  final int qty;
  final double gross;
  final double netAmount;
  final double balanceDue;

  Package({
    required this.slNo,
    required this.packageName,
    required this.activeFrom,
    required this.qty,
    required this.gross,
    required this.netAmount,
    required this.balanceDue,
  });
}

class Test {
  final int slNo;
  final String testName;
  final int quantity;
  final double price;
  final double deductible;
  final String remarks;

  Test({
    required this.slNo,
    required this.testName,
    required this.quantity,
    required this.price,
    required this.deductible,
    required this.remarks,
  });
}

class Procedure {
  final int slNo;
  final String procedureName;
  final int quantity;
  final double price;
  final double deductible;
  final String remarks;

  Procedure({
    required this.slNo,
    required this.procedureName,
    required this.quantity,
    required this.price,
    required this.deductible,
    required this.remarks,
  });
}
