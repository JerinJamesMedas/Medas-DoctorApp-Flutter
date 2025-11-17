import 'package:flutter/material.dart';

class PatientsStatiticsCard extends StatelessWidget {
  final String heading;
  final Color colrs;
  final int count;
  final String iconPath; // now using image path instead of IconData
  final double iconheight;
  final double iconwidth;

  const PatientsStatiticsCard({
    super.key,
    required this.colrs,
    required this.heading,
    required this.count,
    required this.iconPath,
    required this.iconheight,
    required this.iconwidth
  });

  @override
  Widget build(BuildContext context) {

    final screenwidth = MediaQuery.of(context).size.width;
    final  boxwidth;
    if (screenwidth <=430){
       boxwidth = screenwidth/3.6;
      
    }else {
      boxwidth = 130;
    }
    

    return Card(
      elevation: 5,
      color: Colors.transparent,
      child: Container(
        height: 126,
        width: boxwidth,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          image: const DecorationImage(
            image: AssetImage("assets/images/card7.png"),
            fit: BoxFit.fill,
          ),
          borderRadius: BorderRadius.circular(10), // round border
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Heading text on top
              Text(
                heading,
                style: TextStyle(
                  fontSize: 13,
                  color: colrs,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),

              // Icon from image asset
              Image.asset(
                iconPath,
                height: iconheight, // adjust size as needed
                width: iconwidth,
                color: colrs, // optional tinting, remove if you want original color
              ),
              const SizedBox(height: 8),

              // Count text below the icon
              Text(
                count.toString(),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black, // adjust color if needed
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
