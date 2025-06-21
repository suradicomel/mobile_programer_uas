class Registration {
  final String id;
  final Student student;
  final List<String> documents;
  final String paymentStatus;
  final String registrationStatus;
  final DateTime registrationDate;

  Registration({
    required this.id,
    required this.student,
    required this.documents,
    this.paymentStatus = 'Pending',
    this.registrationStatus = 'Processing',
    required this.registrationDate,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'student': student.toJson(),
        'documents': documents,
        'paymentStatus': paymentStatus,
        'registrationStatus': registrationStatus,
        'registrationDate': registrationDate.toIso8601String(),
      };

  factory Registration.fromJson(Map<String, dynamic> json) => Registration(
        id: json['id'],
        student: Student.fromJson(json['student']),
        documents: List<String>.from(json['documents']),
        paymentStatus: json['paymentStatus'],
        registrationStatus: json['registrationStatus'],
        registrationDate: DateTime.parse(json['registrationDate']),
      );
}