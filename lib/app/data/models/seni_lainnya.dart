import 'package:senja_mobile/app/data/models/detail_seni.dart';

class SeniLainnya {
  int? id;
  String? name;
  String? description;
  String? imageUrl;
  List<DetailSeni>? details;

  SeniLainnya({
    this.id,
    this.name,
    this.description,
    this.imageUrl,
    this.details,
  });

  factory SeniLainnya.fromJson(Map<String, dynamic> json) {
    return SeniLainnya(
      id: json['id'],
      name: json['name'],
      description: json['description'], // typo pada field 'description' di JSON
      imageUrl: json['imageUrl'],
      details: (json['details'] as List<dynamic>?)
          ?.map((item) => DetailSeni.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'details': details?.map((item) => item.toJson()).toList(),
    };
  }
}
