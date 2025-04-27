class GerakanTari {
  int? id;
  String? name;
  String? imageUrl;
  String? description;
  double? skor; // ✅ Tambahkan skor

  GerakanTari({
    this.id,
    this.name,
    this.imageUrl,
    this.description,
    this.skor, // ✅ Tambahkan ke constructor
  });

  GerakanTari.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    imageUrl = json['imageUrl'];
    description = json['description'];
    skor = (json['skor'] != null)
        ? double.tryParse(json['skor'].toString())
        : null; // ✅ Parsing aman
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['imageUrl'] = imageUrl;
    data['description'] = description;
    data['skor'] = skor; // ✅ Tambahkan ke JSON
    return data;
  }
}
