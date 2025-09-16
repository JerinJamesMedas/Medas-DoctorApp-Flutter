import 'package:doctors_app/common_class/logincheck.dart';
import 'package:doctors_app/main.dart';
// import 'package:doctors_app/screens/Status/status_all.dart';
import 'package:doctors_app/screens/auth/doctor/login.dart';
import 'package:doctors_app/screens/auth/patient/login.dart';
import 'package:doctors_app/screens/home/home.dart';
import 'package:doctors_app/screens/navigation/bottom_nav.dart';
import 'package:doctors_app/screens/user/features/help_support.dart';
import 'package:doctors_app/screens/user/features/profile_edit.dart';
import 'package:doctors_app/screens/user/features/settings.dart';
import 'package:doctors_app/screens/workbench/diagnosis.dart';
import 'package:doctors_app/screens/workbench/examination.dart';
import 'package:doctors_app/screens/workbench/follow_up.dart';
import 'package:doctors_app/screens/workbench/history.dart';
import 'package:doctors_app/screens/workbench/nursesheet/nurse_sheet.dart';
import 'package:doctors_app/screens/workbench/remarks.dart';
import 'package:doctors_app/screens/workbench/reports.dart';
import 'package:doctors_app/screens/workbench/treatment.dart';
import 'package:flutter/material.dart';

// page Route----------------------------
class AppRouter {
  static const String landing = '/';
  static const String doctorLogin = '/doctor-login';
  static const String patientLogin = '/patient-login';
  static const String doctorWorkbench = '/doctor-workbench';
  static const String docBottomNav = "/doc-navigation";
  static const String nurseSheet = "/nurse-sheet";
  static const String patientHistory = "/patient-history";
  static const String diagnosis = "/diagnosis";
  static const String examination = "/examination";
 static const String  followup = "/follow-up";
  static const String remarks = "/remarks";
  static const String reports= "/reports";
  static const String treatment= "/treatment";
  static const String profielSettings= "/profilesettings";
  static const String helpsupport= "/helpsupport";
  static const String editprofile= "/editprofile";
  static const String logincheck = "/logincheck";

  static final Map<String, WidgetBuilder> routes = {
    landing: (context) => const LandingPage(),
    doctorLogin: (context) => const DoctorLoginPage(),
    patientLogin: (context) => const PatientLoginPage(),
    doctorWorkbench: (context) => const DoctorHomePage(),
    docBottomNav : (context) => const BottomNavPage(),
    nurseSheet:(context)=> NurseSheet(),
    patientHistory:(context)=> History(),
    diagnosis:(context)=>Diagnosis(),
    examination:(context)=>Examination(),
    followup:(context)=>FollowUp(),
    remarks:(context)=> Remarks(),
    reports:(context)=> Reports(),
    treatment:(context)=> Treatment(),
    profielSettings:(context) => SettingsPage(),
    helpsupport:(context)=> HelpSupportPage(),
    editprofile:(context)=> EditProfilePage(),
    logincheck:(context)=> LoginCheck(),
  };
}