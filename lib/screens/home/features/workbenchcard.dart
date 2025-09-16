import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Workbenchcard extends StatefulWidget {
  const Workbenchcard({
    super.key,
    required this.icon,
    required this.title,
    required this.color,
    required this.route,
  });

  final IconData icon;
  final String title;
  final Color color;
  final String route;

  @override
  State<Workbenchcard> createState() => _WorkbenchcardState();
}

class _WorkbenchcardState extends State<Workbenchcard> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isExpanded = true; // animate expand
        });

        // Navigate after animation completes
        Future.delayed(const Duration(milliseconds: 200), () {
          Navigator.pushNamed(context, widget.route).then((_) {
            // reset expansion when coming back
            setState(() {
              isExpanded = false;
            });
          });
        });
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            height: isExpanded ? 60 : 65, // grows on tap
            width: isExpanded ? 60 : 65,
            decoration: BoxDecoration(
              image: const DecorationImage(
                image: AssetImage("assets/images/card3.png"),
                fit: BoxFit.fill,
              ),
              color: widget.color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(widget.icon, color: widget.color, size: 32),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            widget.title,
            style: GoogleFonts.varelaRound(
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
