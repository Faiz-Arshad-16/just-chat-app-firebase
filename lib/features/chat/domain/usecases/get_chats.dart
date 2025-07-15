import '../entities/chat_entity.dart';
import '../repositories/chat_repository.dart';

class GetChats {
  final ChatRepository repository;

  GetChats(this.repository);

  Stream<List<ChatEntity>> call(String userId) {
    return repository.getChats(userId);
  }
}