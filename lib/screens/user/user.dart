import 'package:doctors_app/common_class/bloc/doc_bloc.dart';
import 'package:doctors_app/common_class/route.dart';
import 'package:doctors_app/domain/entities/doctor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:doctors_app/injection_container.dart' as di;

class User extends StatelessWidget {
  const User({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => di.gi<DoctorBloc>()..add(LoginDoctorEvent()),
      child: Scaffold(
        body: SafeArea(
          child: BlocBuilder<DoctorBloc, DoctorState>(
            builder: (context, state) {
              if (state is DoctorLoading) {
                // Skeleton UI while loading
                return _buildSkeleton();
              } else if (state is DoctorLoaded) {
                final Doctor doctor = state.doctor;
                return _buildProfile(context, doctor);
              } else if (state is DoctorError) {
                return Center(child: Text(state.message));
              }
              return const Center(child: Text("No doctor data"));
            },
          ),
        ),
      ),
    );
  }

  /// 🔹 Skeletonizer while loading
  Widget _buildSkeleton() {
    return Skeletonizer(
      enabled: true,
      child: Column(
        children: [
          const SizedBox(height: 15),
          Center(
            child: Text(
              "Profile",
              style: GoogleFonts.spaceGrotesk(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 15),
          const CircleAvatar(radius: 55),
          const SizedBox(height: 15),
          Column(
            children: const [
              Text("Doctor Name"),
              Text("Speciality"),
              Text("City"),
              Text("Email"),
            ],
          ),
          const SizedBox(height: 60),
          Expanded(
            child: ListView(
              children: [
                _skeletonTile(),
                _skeletonTile(),
                _skeletonTile(),
                _skeletonTile(),
              ],
            ),
          )
        ],
      ),
    );
  }

  static Widget _skeletonTile() {
    return Container(
      height: 65,
      margin: const EdgeInsets.symmetric(horizontal: 19, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: const ListTile(
        leading: CircleAvatar(),
        title: Text("Loading..."),
      ),
    );
  }

  /// 🔹 Actual Profile UI
  Widget _buildProfile(BuildContext context, Doctor doctor) {
    return Column(
      children: [
        const SizedBox(height: 15),
        Center(
          child: Text(
            "Profile",
            style: GoogleFonts.spaceGrotesk(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 15),
        CircleAvatar(
          radius: 55,
          backgroundColor: Colors.transparent,
          child: ClipOval(
            child: Image.asset(
              "assets/images/card3.png",
              fit: BoxFit.cover,
              width: 150,
              height: 150,
            ),
          ),
        ),
        const SizedBox(height: 15),
        Column(
          children: [
            Text(
              doctor.name,
              style: GoogleFonts.spaceGrotesk(
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              doctor.speciality,
              style: GoogleFonts.spaceGrotesk(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              doctor.city,
              style: GoogleFonts.spaceGrotesk(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            Text(
              doctor.email,
              style: GoogleFonts.spaceGrotesk(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
        const SizedBox(height: 60),
        Expanded(
          child: ListView(
            children: [
              _menuTile(
                context,
                icon: Icons.edit,
                title: "Edit Profile",
                onTap: () => Navigator.pushNamed(context, AppRouter.editprofile),
              ),
              _menuTile(
                context,
                icon: Icons.settings,
                title: "Settings",
                onTap: () =>
                    Navigator.pushNamed(context, AppRouter.profielSettings),
              ),
              _menuTile(
                context,
                icon: Icons.help,
                title: "Help & Support",
                onTap: () => Navigator.pushNamed(context, AppRouter.helpsupport),
              ),
              _menuTile(
                context,
                icon: Icons.logout,
                title: "Logout",
                onTap: () async {
                    final prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // 🔹 clears all saved keys (id, username, email, role, uid)

    // Optionally navigate to login page
    Navigator.pushReplacementNamed(context, AppRouter.doctorLogin);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// 🔹 Reusable menu tile
  static Widget _menuTile(BuildContext context,
      {required IconData icon, required String title, VoidCallback? onTap}) {
    return Container(
      height: 65,
      margin: const EdgeInsets.symmetric(horizontal: 19, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            offset: const Offset(0, 3),
            blurRadius: 5,
          ),
        ],
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.blue),
        title: Text(title),
        onTap: onTap,
      ),
    );
  }
}
