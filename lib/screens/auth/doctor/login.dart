import 'package:doctors_app/common_class/bloc/doc_bloc.dart';
import 'package:doctors_app/common_class/bloc/user_bloc.dart';
import 'package:doctors_app/injection_container.dart' as di;
import 'package:doctors_app/screens/navigation/bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorLoginPage extends StatefulWidget {
  const DoctorLoginPage({super.key});

  @override
  State<DoctorLoginPage> createState() => _DoctorLoginPageState();
}

class _DoctorLoginPageState extends State<DoctorLoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  late Future<void> _initFuture;

  @override
  void initState() {
    super.initState();
    if (di.gi.isRegistered<UserBloc>()) {
      _initFuture = di.initUser();
    } else {
      _initFuture = Future.value();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initFuture,
      builder: (context, snapshot) {
        return BlocProvider(
          create: (_) => di.gi<UserBloc>(), // 👈 from GetIt injection
          child: BlocConsumer<UserBloc, Userstate>(
            listener: (context, state) {
              if (state is UserLoading) {
                // You can show loader here or dialog
              } else if (state is UserLoaded) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Welcome Dr. ${state.user}")),
                );

                // Navigate to dashboard here

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => BottomNavPage()),
                );
              } else if (state is UserError) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.msg)));
              }
            },
            builder: (context, state) {
              return Scaffold(
                backgroundColor: Colors.blue.shade50,
                body: Center(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24.0,
                      vertical: 16.0,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Page Heading
                        const Text(
                          "Welcome Back, Doctor ",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Login to access your dashboard",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        const SizedBox(height: 30),

                        // Main Card
                        Container(
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 12,
                                offset: const Offset(0, 6),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              // Logo
                              Container(
                                height: 90,
                                width: 90,
                                decoration: BoxDecoration(
                                  color: Colors.blue.shade100,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Icon(
                                  Icons.local_hospital,
                                  size: 50,
                                  color: Colors.blue,
                                ),
                              ),
                              const SizedBox(height: 30),

                              // Email field
                              TextField(
                                controller: emailController,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  labelText: "Email",
                                  prefixIcon: const Icon(
                                    Icons.email,
                                    color: Colors.blue,
                                  ),
                                  filled: true,
                                  fillColor: Colors.blue.shade50,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),

                              // Password field
                              TextField(
                                controller: passwordController,
                                obscureText: true,
                                decoration: InputDecoration(
                                  labelText: "Password",
                                  prefixIcon: const Icon(
                                    Icons.lock,
                                    color: Colors.blue,
                                  ),
                                  filled: true,
                                  fillColor: Colors.blue.shade50,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 24),

                              // Login Button
                              SizedBox(
                                width: double.infinity,
                                height: 48,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  onPressed: () {
                                    final email = emailController.text;
                                    final password = passwordController.text;
                                     print(password);
                                    context.read<UserBloc>().add(
                                      LoginUserEvent(email, password),
                                    );
                                  },
                                  child: const Text(
                                    "Login",
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),

                              // Forgot Password
                              TextButton(
                                onPressed: () {},
                                child: const Text(
                                  "Forgot Password?",
                                  style: TextStyle(color: Colors.blue),
                                ),
                              ),

                              if (state is DoctorLoading)
                                const Padding(
                                  padding: EdgeInsets.all(12.0),
                                  child: CircularProgressIndicator(),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
