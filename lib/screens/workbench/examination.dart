import 'package:doctors_app/common_class/textStyle.dart';
import 'package:flutter/material.dart';

class Examination extends StatelessWidget {
  const Examination({super.key});

  final List<Map<String, dynamic>> _sections = const [
    {"title": "Confidential Statement", "icon": Icons.lock_outline},
    {"title": "Chief Complaint / HPI", "icon": Icons.healing_outlined},
    {"title": "Review of Systems", "icon": Icons.fact_check_outlined},
    {"title": "Significant Signs", "icon": Icons.warning_amber_rounded},
    {"title": "Examination Diagram", "icon": Icons.insert_photo_outlined},
    {"title": "Clinical Examination / Assessment", "icon": Icons.medical_services_outlined},
    {"title": "Examination Notes", "icon": Icons.note_alt_outlined},
    {"title": "Progress Notes", "icon": Icons.timeline_outlined},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 70, 155, 225),
        title: const Text(
          "Examination",
          style: TextStyle(
            color: Colors.white,
            fontSize: AppFontSize.h1,
            fontWeight: AppFontWeight.semiBold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: GridView.builder(
          itemCount: _sections.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // two per row
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1, // makes them square
          ),
          itemBuilder: (context, index) {
            final section = _sections[index];
            return _buildTile(context, section["title"], section["icon"]);
          },
        ),
      ),
    );
  }

  Widget _buildTile(BuildContext context, String title, IconData icon) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SectionDetailPage(title: title),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 3,
        clipBehavior: Clip.antiAlias,
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage("assets/images/card1.png"),
            ),
          ),
          padding: const EdgeInsets.all(12),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 36, color: Colors.white),
              const SizedBox(height: 12),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SectionDetailPage extends StatelessWidget {
  final String title;
  const SectionDetailPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              maxLines: null,
              decoration: InputDecoration(
                hintText: "Enter $title...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                // save logic
                Navigator.pop(context);
              },
              icon: const Icon(Icons.save),
              label: const Text("Save"),
            )
          ],
        ),
      ),
    );
  }
}
