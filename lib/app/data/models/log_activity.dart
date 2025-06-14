class LogActivity {
  final String? id;
  final String? userId;
  final String? email;
  final String? aktivitas;
  final String? waktu;

  LogActivity({
    this.id,
    this.userId,
    this.email,
    this.aktivitas,
    this.waktu,
  });

  factory LogActivity.fromJson(Map<String, dynamic> json) {
    return LogActivity(
      id: json['id'] ?? '',
      userId: json['user_id'] ?? '',
      email: json['email'] ?? '',
      aktivitas: json['aktivitas'] ?? '',
      waktu: json['waktu'] ?? '',
    );
  }
}
