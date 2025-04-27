import 'package:senja_mobile/app/data/models/gerakan_tari.dart';

class Tari {
  int? id;
  String? name;
  String? description;
  String? imageUrl;
  String? level;
  String? asal;
  List<GerakanTari>? gerakanTari; // Menambahkan daftar gerakan tari

  Tari(
      {this.id,
      this.name,
      this.description,
      this.imageUrl,
      this.level,
      this.asal,
      this.gerakanTari});

  factory Tari.fromJson(Map<String, dynamic> json) {
    return Tari(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      level: json['level'],
      asal: json['asal'],
      gerakanTari: json['gerakanTari'] != null
          ? (json['gerakanTari'] as List)
              .map((e) => GerakanTari.fromJson(e))
              .toList()
          : null, // Parsing daftar gerakan tari
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'level': level,
      'asal': asal,
      'gerakanTari': gerakanTari?.map((e) => e.toJson()).toList(),
    };
  }
}
