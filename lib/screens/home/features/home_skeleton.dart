import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class DoctorHomeSkeleton extends StatelessWidget {
  const DoctorHomeSkeleton({super.key});

  // Helper for skeleton boxes
  Widget _skeletonBox({
    double width = double.infinity,
    double height = 16,
    double borderRadius = 8,
  }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true, // enable skeleton mode
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Location & Notification
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _skeletonBox(width: 120, height: 20, borderRadius: 12),
                    _skeletonBox(width: 36, height: 36, borderRadius: 18),
                  ],
                ),
                const SizedBox(height: 16),

                // Search Bar
                _skeletonBox(height: 50, borderRadius: 12),
                const SizedBox(height: 20),

                // Notification Banner
                SizedBox(
                  height: 190,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: 3,
                    separatorBuilder: (_, __) => const SizedBox(width: 12),
                    itemBuilder: (_, __) =>
                        _skeletonBox(width: 360, height: 190, borderRadius: 12),
                  ),
                ),
                const SizedBox(height: 20),

                // Patients title
                _skeletonBox(width: 150, height: 20),
                const SizedBox(height: 10),

                // Patient Cards
                Column(
                  children: List.generate(
                    3,
                    (_) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: _skeletonBox(height: 90, borderRadius: 8),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Nearby Medical Centers title
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _skeletonBox(width: 180, height: 20),
                    _skeletonBox(width: 50, height: 20),
                  ],
                ),
                const SizedBox(height: 12),

                // Nearby Medical Centers cards
                SizedBox(
                  height: 150,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: 2,
                    separatorBuilder: (_, __) => const SizedBox(width: 12),
                    itemBuilder: (_, __) =>
                        _skeletonBox(width: 200, height: 150, borderRadius: 12),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


