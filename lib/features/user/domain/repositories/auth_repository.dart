import '../entities/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity?> signIn(String email, String password);
  Future<UserEntity?> signUp(String email, String password, String username);
  Future<void> signOut();
  Future<void> forgotPassword(String email);
  Future<void> changePassword(String newPassword);
  Stream<UserEntity?> authStateChanges();
}