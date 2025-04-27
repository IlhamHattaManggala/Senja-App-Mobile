class User {
  String id;
  String name;
  String email;
  String role;
  String? avatar;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    this.avatar,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"] ?? "",
        name: json["name"] ?? "Anonymous",
        email: json["email"] ?? "Anonymous",
        role: json["role"] ?? "user",
        avatar: json["avatar"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "role": role,
        "avatar": avatar,
      };
}
