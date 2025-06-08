class Notifikasi {
  String id;
  String title;
  String body;
  String? topic;
  bool? isRead;
  String? time;

  Notifikasi({
    required this.id,
    required this.title,
    required this.body,
    this.topic,
    this.isRead,
    this.time,
  });

  factory Notifikasi.fromJson(Map<String, dynamic> json) {
    return Notifikasi(
      id: json['_id'] ?? '', // MongoDB pakai _id
      title: json['title'] ?? '',
      body: json['body'] ?? '',
      topic: json['topic'],
      isRead: json['isRead'] ?? false,
      time: json['time'] is String
          ? json['time']
          : DateTime.now().toIso8601String(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'body': body,
      'topic': topic,
      'isRead': isRead,
      'time': time,
    };
  }
}
