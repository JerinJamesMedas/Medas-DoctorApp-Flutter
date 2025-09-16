import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class shedule_skeletonizer extends StatelessWidget {
  const shedule_skeletonizer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: SafeArea(
        child: ListView.builder(
          padding: const EdgeInsets.all(2),
          itemCount: 9, // show 6 placeholders
          itemBuilder: (context, index) {
            return ListTile(
              leading: const CircleAvatar(
                radius: 10,
                backgroundColor: Color.fromARGB(255, 220, 220, 220),
              ),
              title: Container(
                height: 80,
                width: 180,
                color: Colors.white,
              ),
              subtitle: Container(
                margin: const EdgeInsets.only(top: 6),
                height: 12,
                width: 150,
                color: Colors.white,
              ),
            );
          },
        ),
      ),
    );
  }
}
