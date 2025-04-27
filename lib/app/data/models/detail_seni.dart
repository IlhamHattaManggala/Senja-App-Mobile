class DetailSeni {
  int? id;
  String? name;
  String? description;
  String? imageUrl;

  DetailSeni({
    this.id,
    this.name,
    this.description,
    this.imageUrl,
  });

  factory DetailSeni.fromJson(Map<String, dynamic> json) {
    return DetailSeni(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
    };
  }
}
