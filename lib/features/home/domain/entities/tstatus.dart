class TodaysStatus {
  final List<StatusData> all;
  final List<StatusData> walkin;
  final List<StatusData> appointment;
  final List<StatusData> visited;
  final List<StatusData> notVisited;
  final List<StatusData> revisit;
  final List<StatusData> newVisit;

  TodaysStatus({
    required this.all,
    required this.walkin,
    required this.appointment,
    required this.visited,
    required this.notVisited,
    required this.revisit,
    required this.newVisit,
  });

  factory TodaysStatus.fromJson(Map<String, dynamic> json) {
    List<StatusData> parseList(String key) {
      if (json[key] == null) return [];
      return List<StatusData>.from(
          json[key].map((x) => StatusData.fromJson(x)));
    }

    return TodaysStatus(
      all: parseList('all'),
      walkin: parseList('walkin'),
      appointment: parseList('appointment'),
      visited: parseList('visited'),
      notVisited: parseList('not_visited'),
      revisit: parseList('revisit'),
      newVisit: parseList('new_visit'),
    );
  }
}

class StatusData {
  final int consultId;
  final int dcId;
  final DateTime appointDate;
  final String appointType;
  final int patientId;
  final String opNumber;
  final String appointStatus;
  final String patientName;
  final String visitTypeNew;
  final String visited;
  final String doctorVisitType;

  StatusData({
    required this.consultId,
    required this.dcId,
    required this.appointDate,
    required this.appointType,
    required this.patientId,
    required this.opNumber,
    required this.appointStatus,
    required this.patientName,
    required this.visitTypeNew,
    required this.visited,
    required this.doctorVisitType,
  });

  factory StatusData.fromJson(Map<String, dynamic> json) {
    return StatusData(
      consultId: json['consult_id'],
      dcId: json['dcId'],
      appointDate: DateTime.parse(json['appoint_date']),
      appointType: json['appoint_type'] ?? '',
      patientId: json['patient_id'],
      opNumber: json['op_number'] ?? '',
      appointStatus: json['appoint_status'] ?? '',
      patientName: json['patient_name'] ?? '',
      visitTypeNew: json['visit_type_new'] ?? '',
      visited: json['visited'] ?? '',
      doctorVisitType: json['doctor_visit_type'] ?? '',
    );
  }
}
