class UserModel {
  final String username;
  final String password;
  final String lastname;
  final String email;
  final String imageUrl;
  final String phoneNumber;
  final String userId;

  UserModel({
    required this.username,
    required this.password,
    required this.lastname,
    required this.email,
    required this.imageUrl,
    required this.phoneNumber,
    required this.userId,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      username: json['username'] as String? ?? "",
      password: json['password'] as String? ?? "",
      lastname: json['lastname'] as String? ?? "",
      email: json['email'] as String? ?? "",
      imageUrl: json['imageUrl'] as String? ?? "",
      phoneNumber: json['phoneNumber'] as String? ?? "",
      userId: json['userId'] as String? ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
      'lastname': lastname,
      'email': email,
      'imageUrl': imageUrl,
      'phoneNumber': phoneNumber,
      'userId': userId,
    };
  }

  UserModel copyWith({
    String? username,
    String? password,
    String? lastname,
    String? email,
    String? imageUrl,
    String? phoneNumber,
    String? userId,
  }) {
    return UserModel(
      username: username ?? this.username,
      password: password ?? this.password,
      lastname: lastname ?? this.lastname,
      email: email ?? this.email,
      imageUrl: imageUrl ?? this.imageUrl,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      userId: userId ?? this.userId,
    );
  }

  static UserModel initial() => UserModel(
        username: "",
        password: "",
        lastname: "",
        email: "",
        imageUrl: "",
        phoneNumber: "",
        userId: "",
      );
}
