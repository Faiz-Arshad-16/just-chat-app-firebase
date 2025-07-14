import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_firebase_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthFirebaseDataSource dataSource;

  AuthRepositoryImpl(this.dataSource);

  @override
  Future<UserEntity?> signIn(String email, String password) {
    return dataSource.signIn(email, password);
  }

  @override
  Future<UserEntity?> signUp(String email, String password, String username) {
    return dataSource.signUp(email, password, username);
  }

  @override
  Future<void> signOut() {
    return dataSource.signOut();
  }

  @override
  Future<void> forgotPassword(String email) {
    return dataSource.forgotPassword(email);
  }

  @override
  Future<void> changePassword(String newPassword) {
    return dataSource.changePassword(newPassword);
  }

  @override
  Stream<UserEntity?> authStateChanges() {
    return dataSource.authStateChanges();
  }
}