class UserModel {
  String id;
  String name;
  String email;

  UserModel({required this.id, required this.name, required this.email});

  UserModel.fromJson(Map<String, dynamic> json)
    : this(id: json['id'], email: json['email'], name: json['name']);

  Map<String, dynamic> toJson() => {'id': id, 'name': name, 'email': email};
}
