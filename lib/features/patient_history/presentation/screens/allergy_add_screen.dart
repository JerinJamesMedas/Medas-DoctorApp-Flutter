import 'package:doctors_app/features/patient_history/presentation/bloc/allergy_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllergyAddScreen extends StatefulWidget {
  const AllergyAddScreen({super.key});

  @override
  State<AllergyAddScreen> createState() => _AllergyAddScreenState();
}

class _AllergyAddScreenState extends State<AllergyAddScreen> {
  String? selectedType;
  String? selectedAllergy;
  String? selectedSeverity;
  String? selectedReaction;

  List<String> filteredAllergies = [];

  @override
  void initState() {
    super.initState();
    context.read<AllergyBloc>().add(GetAllergyEvent('12'));
  }

  @override
  Widget build(BuildContext context) {
    final Color primaryBlue = Colors.blue.shade700;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryBlue,
        title: const Text("Add Allergy"),
      ),
      body: BlocBuilder<AllergyBloc, AllergyState>(
        builder: (context, state) {
          if (state is AllergyInitial || state is AllergyLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is AllergyErrorState) {
            return Center(child: Text(state.message));
          }

          if (state is AllergyLoadedState) {
            // Group allergies by allergy_type
            final Map<String, List<String>> grouped = {};

            for (var item in state.allergyList) {
              grouped.putIfAbsent(item.allergyType, () => []);
              grouped[item.allergyType]!.add(item.allergy);
            }

            final allergyTypes = grouped.keys.toList();

            // Update filtered list if type already selected
            filteredAllergies = selectedType == null
                ? []
                : grouped[selectedType!] ?? [];

            return Container(
              padding: const EdgeInsets.all(16.0),
              color: Colors.blue.shade50,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _sectionTitle("Allergy Type", primaryBlue),
                    _roundedDropdown(
                      hint: "Select allergy type",
                      items: allergyTypes,
                      value: selectedType,
                      onChanged: (value) {
                        setState(() {
                          selectedType = value;
                          filteredAllergies = grouped[value] ?? [];
                          selectedAllergy = null; // reset
                        });
                      },
                    ),

                    const SizedBox(height: 20),

                    _sectionTitle("Allergy Code", primaryBlue),
                    _roundedDropdown(
                      hint: "Select allergy",
                      items: filteredAllergies,
                      value: selectedAllergy,
                      onChanged: (value) {
                        setState(() {
                          selectedAllergy = value;
                        });
                      },
                    ),

                    const SizedBox(height: 20),

                    _sectionTitle("Severity", primaryBlue),
                    _roundedDropdown(
                      hint: "Select severity",
                      items: const ["Mild", "Moderate", "Severe"],
                      value: selectedSeverity,
                      onChanged: (value) {
                        setState(() {
                          selectedSeverity = value;
                        });
                      },
                    ),

                    const SizedBox(height: 20),

                    _sectionTitle("Reaction", primaryBlue),
                    _roundedDropdown(
                      hint: "Select reaction",
                      items: const [
                        "Rash",
                        "Breathing Difficulty",
                        "Swelling",
                        "Anaphylaxis",
                      ],
                      value: selectedReaction,
                      onChanged: (value) {
                        setState(() {
                          selectedReaction = value;
                        });
                      },
                    ),

                    const SizedBox(height: 30),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryBlue,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          // Your save logic
                          print("Type: $selectedType");
                          print("Allergy: $selectedAllergy");
                          print("Severity: $selectedSeverity");
                          print("Reaction: $selectedReaction");
                        },
                        child: const Text(
                          "Save",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _sectionTitle(String title, Color color) {
    return Text(
      title,
      style: TextStyle(
        color: color,
        fontWeight: FontWeight.w700,
        fontSize: 15,
      ),
    );
  }

  Widget _roundedDropdown({
    required String hint,
    required List<String> items,
    required Function(String?) onChanged,
    required String? value,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 14,
        ),
        hintText: hint,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      items: items
          .map((e) => DropdownMenuItem(value: e, child: Text(e)))
          .toList(),
      onChanged: onChanged,
    );
  }
}
