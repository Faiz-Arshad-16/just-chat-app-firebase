
import '../repositories/chat_repository.dart';

class StartChat {
  final ChatRepository repository;

  StartChat(this.repository);

  Future<void> call(String userId, String partnerEmail, String message) {
    return repository.startChat(userId, partnerEmail, message);
  }
}