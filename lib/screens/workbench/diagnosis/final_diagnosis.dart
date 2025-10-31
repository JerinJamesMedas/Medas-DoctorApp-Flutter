import 'package:flutter/material.dart';

class BuildfinalDiagnosisCard extends StatelessWidget {
  const BuildfinalDiagnosisCard({
    super.key,
    required this.title,
    required this.child,
    required this.onDelete,
    required this.onChangePriority,
    required this.priority
  });

  final String title;
  final Widget child;
  final VoidCallback onDelete;
  final VoidCallback onChangePriority;
  final int priority;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: priority == 0 ? TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold, color : Colors.red) : TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold, color : Colors.black) 
                  ),
                ),
                priority == 0 ? SizedBox() : IconButton(
                  icon: const Icon(Icons.keyboard_arrow_up_sharp,color: Colors.blueAccent, size: 30,),
                  onPressed: onChangePriority,
                  tooltip: "Increase Priority",
                ),
                IconButton(  
                  icon: const Icon(Icons.delete_outline,color: Colors.red,size: 21),
                  onPressed: onDelete,
                  tooltip: "Delete",
                ),
              ],
            ),

            child,
          ],
        ),
      ),
    );
  }
}


 