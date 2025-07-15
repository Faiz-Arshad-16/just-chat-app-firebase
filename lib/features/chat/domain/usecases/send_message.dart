import '../repositories/chat_repository.dart';

class SendMessage {
  final ChatRepository repository;

  SendMessage(this.repository);

  Future<void> call(String chatId, String userId, String text) {
    return repository.sendMessage(chatId, userId, text);
  }
}