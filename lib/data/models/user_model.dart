class UserModel {
  final String username;
  final String password;
  final String lastname;
  final String email;
  final String imageUrl;
  final String phoneNumber;
  final String userId;
  final String authUid;
  final String fcm;

  UserModel({
    required this.username,
    required this.password,
    required this.lastname,
    required this.email,
    required this.imageUrl,
    required this.phoneNumber,
    required this.userId,
    required this.fcm,
    required this.authUid,
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
      fcm: json['fcm'] as String? ?? "",
      authUid: json['authUid'] as String? ?? "",
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
      'authUid': authUid,
      'fcm': fcm,
    };
  }

  Map<String, dynamic> toJsonForUpdate() {
    return {
      'username': username,
      'password': password,
      'lastname': lastname,
      'email': email,
      'imageUrl': imageUrl,
      'phoneNumber': phoneNumber,
      'authUid': authUid,
      'fcm': fcm,
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
    String? fcm,
    String? authUid,
  }) {
    return UserModel(
      username: username ?? this.username,
      password: password ?? this.password,
      lastname: lastname ?? this.lastname,
      email: email ?? this.email,
      imageUrl: imageUrl ?? this.imageUrl,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      userId: userId ?? this.userId,
      fcm: fcm ?? this.fcm,
      authUid: authUid ?? this.authUid,
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
    authUid: "",
    fcm: "",
      );
}
