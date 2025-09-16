class Patient {
  final String name;
  final String mr;
  final String dob;
  final String type; 
  final String nationality;
  final String city;
  final int visitcount;
  final String appointmentDate; 
  final String appointmentTime; 
  final String op; 
  final String mode;
  final String title; 
  final String revisit;
  final bool visited;
  final List<String> allergies;
  final List<String> notes;

  Patient({
    required this.name,
    required this.mr,
    required this.dob,
    required this.type,
    required this.nationality,
    required this.city,
    required this.visitcount,
    required this.appointmentDate,
    required this.appointmentTime,
    required this.op,
    required this.mode,
    required this.title,
    required this.revisit,
    required this.visited,
    required this.allergies,
    required this.notes
  });
}
