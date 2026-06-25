class User {
  final int? id;
  final String username;
  final String email;
  final String password;
  final String? profileImage;
  final String createdAt;

  User({
    this.id,
    required this.username,
    required this.email,
    required this.password,
    this.profileImage,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'password': password,
      'profile_image': profileImage,
      'created_at': createdAt,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as int?,
      username: map['username'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
      profileImage: map['profile_image'] as String?,
      createdAt: map['created_at'] as String,
    );
  }

  User copyWith({
    int? id,
    String? username,
    String? email,
    String? password,
    String? profileImage,
    String? createdAt,
  }) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
      profileImage: profileImage ?? this.profileImage,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
