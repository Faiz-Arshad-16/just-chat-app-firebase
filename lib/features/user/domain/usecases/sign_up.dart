import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class SignUp {
  final AuthRepository repository;

  SignUp(this.repository);

  Future<UserEntity?> call(String email, String password, String username) {
    return repository.signUp(email, password, username);
  }
}