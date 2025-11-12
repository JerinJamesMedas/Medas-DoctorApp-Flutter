import 'package:doctors_app/common_class/bloc/homeBlock.dart';
import 'package:doctors_app/common_class/bloc/patient_bloc.dart';
import 'package:doctors_app/common_class/textStyle.dart';
import 'package:doctors_app/injection_container.dart' as di;
import 'package:doctors_app/model/home_model.dart';
import 'package:doctors_app/screens/home/features/home_skeleton.dart';
import 'package:doctors_app/screens/home/features/notification_banner.dart';
import 'package:doctors_app/screens/home/features/patient_card_list.dart';
import 'package:doctors_app/screens/home/features/todays_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pull_up_down_refresh/flutter_pull_up_down_refresh.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../domain/entities/patient.dart';

class DoctorHomePage extends StatefulWidget {
  const DoctorHomePage({super.key});

  @override
  State<DoctorHomePage> createState() => _DoctorHomePageState();
}

class _DoctorHomePageState extends State<DoctorHomePage> {
  bool showTimeoutError = false;

  late Future<void> _initPatient; 

  @override
  void initState() {
    super.initState();

  if(!di.gi.isRegistered<HomeBloc>()){
    _initPatient = di.initDependencies();
  } else {
    _initPatient = Future.value();
  }
    // Timeout check for showing error if loading too long
    Future.delayed(const Duration(seconds: 10), () {
      if (mounted) {
        setState(() {
          showTimeoutError = true;
        });
      }
    });
  }

  String selectedBranch = "Seattle, USA"; // default value
  final List<String> branches = [
    "Seattle, USA",
    "New York, USA",
    "Los Angeles, USA",
  ];

  Future<void> _onRefresh(BuildContext context) async {
    context.read<HomeBloc>().add(LoadHomeData());
    await Future.delayed(const Duration(seconds: 1)); // small UX delay
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initPatient,
      builder: (context, snapshot) {
    return BlocProvider(
      create: (_) => di.gi<HomeBloc>()..add(LoadHomeData()),
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeLoadingState) {
            if (showTimeoutError) {
              return FlutterPullUpDownRefresh(
                scrollController: ScrollController(),
                onRefresh: () => _onRefresh(context),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text("Network Error"),
                      Icon(Icons.error, color: Colors.red),
                      SizedBox(height: 30),
                      Text(
                        "Pull down to refresh",
                        style: TextStyle(color: Colors.black54),
                      ),
                      Icon(
                        Icons.keyboard_double_arrow_down_sharp,
                        color: Colors.black54,
                      ),
                    ],
                  ),
                ),
              );
            }
            return const DoctorHomeSkeleton();
          }

          if (state is HomeLoadedState) {
            final  patients = state.homeData;
            if (patients.isEmpty) {
              return FlutterPullUpDownRefresh(
                scrollController: ScrollController(),
                onRefresh: () => _onRefresh(context),
                child: const Center(child: Text("No patients found")),
              );
            }
            return _buildMainUI(context, patients);
          }

          if (state is PatientLoadError) {
            return FlutterPullUpDownRefresh(
              scrollController: ScrollController(),
              onRefresh: () => _onRefresh(context),
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Network Error",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 10),
                        Icon(Icons.error, color: Colors.red),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Pull down to refresh",
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  });
  }

  Widget _buildMainUI(BuildContext context, List<ConsultationModel> patients) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: FlutterPullUpDownRefresh(
          scrollController: ScrollController(),
          onRefresh: () => _onRefresh(context),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Location & Notifications
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.location_on, color: Colors.blue),
                        const SizedBox(width: 4),
                        DropdownButton<String>(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          value: selectedBranch,
                          underline:
                              const SizedBox(), // removes default underline
                          icon: const Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.grey,
                          ),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                          items: branches.map((branch) {
                            return DropdownMenuItem(
                              value: branch,
                              child: Text(branch),
                            );
                          }).toList(),
                          onChanged: (value) {
                            if (value != null) {
                              setState(() {
                                selectedBranch = value;
                              });
                            }
                          },
                        ),
                      ],
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.grey.shade200,
                      child: const Icon(Icons.notifications_none),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
    
                // Search bar
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: const [
                      Icon(Icons.search, color: Colors.grey),
                      SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "Search Patient...",
                            hintStyle: TextStyle(fontSize: AppFontSize.body),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
    
                // Notification Banner (Appointments)
                NotificationBanner(appoinment: patients),
                const SizedBox(height: 20),
    
                // Statistics card
                const Text(
                  "Todays Status",
                  style: TextStyle(fontSize: AppFontSize.h2, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                TodaysStatus(patients: patients),
                const SizedBox(height: 20),
    
                // Current Patients
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "History",
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: AppFontSize.h2,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        print("See All tapped");
                      },
                      borderRadius: BorderRadius.circular(4),
                      highlightColor: Colors.grey.shade300,
                      splashColor: Colors.transparent,
                      child: const Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Text(
                          "See All",
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
    
                PatientCardList(
                  patients: patients.where((p) => p.visited == "VISITED").toList(),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
