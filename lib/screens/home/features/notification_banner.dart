import 'package:doctors_app/common_class/textStyle.dart';
import 'package:doctors_app/model/home_model.dart';
import 'package:doctors_app/screens/home/features/notification_appointment_heading.dart';
import 'package:doctors_app/screens/home/features/time_icon_appointment.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationBanner extends StatelessWidget {
  final List<ConsultationModel> appoinment;
  const NotificationBanner({super.key, required this.appoinment});

  @override
  Widget build(BuildContext context) {
    final  boxwidth;
   final screenwidth = MediaQuery.of(context).size.width;
   if (screenwidth <=430){
          boxwidth = screenwidth*0.85;
   }
   else{
          boxwidth = 380;
   }
  

    final List<ConsultationModel> appointments = appoinment;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Appointments",
          style: TextStyle(
            fontSize: AppFontSize.h2,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: 190,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: 3,
            separatorBuilder: (context, index) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final appt = appointments[index];
              return Container(
                width: boxwidth,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/images/card1.png"),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      blurRadius: 6,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        gradient: LinearGradient(
                          colors: [
                            Colors.black.withOpacity(0.55),
                            Colors.transparent,
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            getAppointmentTitle(
                              appt.appointDate.toString(),
                              appt.appointHr.toString() + ":" + appt.appointMin.toString(),
                            ),
                            style: GoogleFonts.spaceGrotesk(
                              fontSize: AppFontSize.h3,
                              fontWeight: AppFontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            "Patient: ${appt.patientName}",
                            style: const TextStyle(
                              fontSize: AppFontSize.body,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            "MR No: ${appt.opNumber}",
                            style: const TextStyle(
                              fontSize: AppFontSize.body,
                              color: Colors.white70,
                            ),
                          ),
                          Text(
                            "DOB: ${appt.dateOfBirth}",
                            style: const TextStyle(
                              fontSize: AppFontSize.body,
                              color: Colors.white70,
                            ),
                          ),
                          const Spacer(),
                          Row(
                            children: [
                              Icon(
                                appt.appointType == "Video Call"
                                    ? Icons.videocam
                                    : appt.appointType == "On Spot"
                                    ? Icons.location_on
                                    : appt.appointType == "Consultation"
                                    ? Icons.home
                                    : Icons.phone,
                                color: appointmentColor(
                                  appt.appointDate.toString(),
                                  appt.appointHr.toString(),
                                ),
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                appt.visitType == "F" ? "Follow Up" : "New Visit",
                                style:  TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: appointmentColor(
                                  appt.appointDate.toString(),
                                  appt.appointHr.toString(),
                                ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
