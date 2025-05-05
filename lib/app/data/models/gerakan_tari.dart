class GerakanTari {
  String? name;
  String? imageUrl;
  String? videoUrl;
  String? skor;

  GerakanTari({this.name, this.imageUrl, this.videoUrl, this.skor});

  factory GerakanTari.fromJson(Map<String, dynamic> json) {
    return GerakanTari(
        name: json['name'],
        imageUrl: json['imageUrl'],
        videoUrl: json['videoUrl'],
        skor: json['skor']);
  }

  Map<String, dynamic> toJson() =>
      {'name': name, 'imageUrl': imageUrl, 'videoUrl': videoUrl, 'skor': skor};
}
