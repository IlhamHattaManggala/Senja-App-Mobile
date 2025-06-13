class Artikel {
  final String id;
  final String title;
  final String date;
  final String? content;
  final String? imageUrl;
  final String? source;

  Artikel({
    required this.id,
    required this.title,
    required this.date,
    this.content,
    this.imageUrl,
    this.source,
  });

  factory Artikel.fromJson(Map<String, dynamic> json) {
    return Artikel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      date: json['date'] ?? '',
      imageUrl: json['image_url'] ?? '',
      source: json['source'] ?? '',
    );
  }
}
