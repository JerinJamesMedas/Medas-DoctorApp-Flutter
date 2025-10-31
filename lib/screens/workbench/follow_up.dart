// import 'package:doctors_app/common_class/textstyle.dart';
// import 'package:flutter/material.dart';

// class FollowUp extends StatelessWidget {
//   const FollowUp({super.key});

//   Widget buildTreatmentCard(String plan, String date, String doctor) {
//     return Card(
//       margin: const EdgeInsets.symmetric(vertical: 6),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       elevation: 2,
//       child: ListTile(
//         title: Text(plan,
//             style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
//         subtitle: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const SizedBox(height: 6),
//             Text("Entered Date: $date"),
//             Text("Entered By: $doctor"),
//           ],
//         ),
//         trailing: IconButton(
//           icon: const Icon(Icons.close, color: Colors.red),
//           onPressed: () {},
//         ),
//       ),
//     );
//   }

//   Widget buildFollowUpCard(String recallDate, String plan, String priority,
//       String doctor, String enteredDate) {
//     return Card(
//       margin: const EdgeInsets.symmetric(vertical: 6),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       elevation: 2,
//       child: Padding(
//         padding: const EdgeInsets.all(12),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text("Recall Date: $recallDate",
//                     style: const TextStyle(
//                         fontWeight: FontWeight.bold, fontSize: 16)),
//                 IconButton(
//                   icon: const Icon(Icons.close, color: Colors.red),
//                   onPressed: () {},
//                 ),
//               ],
//             ),
//             const SizedBox(height: 6),
//             Text("Follow-up Plan: $plan"),
//             Text("Priority: $priority"),
//             Text("Entered By: $doctor"),
//             Text("Entered Date: $enteredDate"),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.blueAccent,
//         title: const Text("Plans", style: TextStyle(fontWeight: AppFontWeight.semiBold, color: Colors.white),),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.white,),
//           onPressed: () => Navigator.pop(context),
//         ),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(12),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               "Treatment Plan",
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.blue,
//               ),
//             ),
//             const SizedBox(height: 8),
//             buildTreatmentCard(
//               "eat medicine in times",
//               "Oct 03, 2025 13:06",
//               "Dr. Ahmed Abdulaziz",
//             ),
//             buildTreatmentCard(
//               "just go and sleep",
//               "Oct 03, 2025 13:06",
//               "Dr. Ahmed Abdulaziz",
//             ),
//             const SizedBox(height: 20),
//             const Text(
//               "Follow-up Plan",
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.blue,
//               ),
//             ),
//             const SizedBox(height: 8),
//             buildFollowUpCard(
//               "03-10-2025",
//               "follow mee",
//               "1",
//               "Dr. Ahmed Abdulaziz",
//               "Oct 03, 2025 16:02",
//             ),
//             buildFollowUpCard(
//               "04-10-2025",
//               "follow",
//               "2",
//               "Dr. Ahmed Abdulaziz",
//               "Oct 03, 2025 16:03",
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:doctors_app/common_class/textstyle.dart';

class FollowUp extends StatefulWidget {
  const FollowUp({super.key});

  @override
  State<FollowUp> createState() => _FollowUpState();
}

class _FollowUpState extends State<FollowUp> {
  // Mock lists (replace with DB or API later)
  List<Map<String, String>> treatmentPlans = [
    {
      "plan": "eat medicine in times",
      "date": "Oct 03, 2025 13:06",
      "doctor": "Dr. Ahmed Abdulaziz"
    },
    {
      "plan": "just go and sleep",
      "date": "Oct 03, 2025 13:06",
      "doctor": "Dr. Ahmed Abdulaziz"
    },
  ];

  List<Map<String, String>> followUpPlans = [
    {
      "recallDate": "03-10-2025",
      "plan": "follow mee",
      "priority": "1",
      "doctor": "Dr. Ahmed Abdulaziz",
      "enteredDate": "Oct 03, 2025 16:02"
    },
    {
      "recallDate": "04-10-2025",
      "plan": "follow",
      "priority": "2",
      "doctor": "Dr. Ahmed Abdulaziz",
      "enteredDate": "Oct 03, 2025 16:03"
    },
  ];

// ------------------------------- Treatment Card --------------------------------
   Widget buildTreatmentCard(String plan, String date, String doctor, int index) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: ListTile(
        title: Text(plan,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 6),
            Text("Entered Date: $date"),
            Text("Entered By: $doctor"),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.close, color: Colors.red),
          onPressed: () {
            setState(() {
              treatmentPlans.removeAt(index);
            });
          },
        ),
      ),
    );
  }

  // ---------------- Follow-up Card ----------------
  Widget buildFollowUpCard(
      String recallDate, String plan, String priority, String doctor, String enteredDate, int index) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Recall Date: $recallDate",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16)),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.red),
                  onPressed: () {
                    setState(() {
                      followUpPlans.removeAt(index);
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text("Follow-up Plan: $plan"),
            Text("Priority: $priority"),
            Text("Entered By: $doctor"),
            Text("Entered Date: $enteredDate"),
          ],
        ),
      ),
    );
  }

  // ---------------- Popup for Adding ----------------
  void _showAddDialog(bool isTreatment) {
    final TextEditingController planController = TextEditingController();
    final TextEditingController dateController = TextEditingController();
    final TextEditingController doctorController = TextEditingController();
    final TextEditingController recallDateController = TextEditingController();
    final TextEditingController priorityController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(isTreatment ? "Add Treatment Plan" : "Add Follow-up Plan"),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: planController,
                  decoration: const InputDecoration(labelText: "Plan"),
                ),
                if (!isTreatment)
                  TextField(
                    controller: recallDateController,
                    decoration: const InputDecoration(labelText: "Recall Date"),
                  ),
                if (!isTreatment)
                  TextField(
                    controller: priorityController,
                    decoration: const InputDecoration(labelText: "Priority"),
                  ),
                TextField(
                  controller: dateController,
                  decoration: const InputDecoration(labelText: "Entered Date"),
                ),
                TextField(
                  controller: doctorController,
                  decoration: const InputDecoration(labelText: "Doctor"),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text("Cancel"),
              onPressed: () => Navigator.pop(context),
            ),
            ElevatedButton(
              child: const Text("Save"),
              onPressed: () {
                setState(() {
                  if (isTreatment) {
                    treatmentPlans.add({
                      "plan": planController.text,
                      "date": dateController.text,
                      "doctor": doctorController.text,
                    });
                  } else {
                    followUpPlans.add({
                      "recallDate": recallDateController.text,
                      "plan": planController.text,
                      "priority": priorityController.text,
                      "doctor": doctorController.text,
                      "enteredDate": dateController.text,
                    });
                  }
                });
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  // ---------------- Build ----------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text(
          "Plans",
          style: TextStyle(
              fontWeight: AppFontWeight.semiBold, color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // -------- Treatment Section --------
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Treatment Plan",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add_circle, color: Colors.blue),
                  onPressed: () => _showAddDialog(true),
                ),
              ],
            ),
            const SizedBox(height: 8),
            ...treatmentPlans.asMap().entries.map((e) => buildTreatmentCard(
                e.value["plan"]!, e.value["date"]!, e.value["doctor"]!, e.key)),

            const SizedBox(height: 20),

            // -------- Follow-up Section --------
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Follow-up Plan",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add_circle, color: Colors.blue),
                  onPressed: () => _showAddDialog(false),
                ),
              ],
            ),
            const SizedBox(height: 8),
            ...followUpPlans.asMap().entries.map((e) => buildFollowUpCard(
                e.value["recallDate"]!,
                e.value["plan"]!,
                e.value["priority"]!,
                e.value["doctor"]!,
                e.value["enteredDate"]!,
                e.key)),
          ],
        ),
      ),
    );
  }
}
