import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.uid,
    required super.email,
    required super.username,
  });

  factory UserModel.fromFirebaseUser(dynamic user, String username) {
    return UserModel(
      uid: user.uid,
      email: user.email ?? '',
      username: username,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'username': username,
    };
  }
}