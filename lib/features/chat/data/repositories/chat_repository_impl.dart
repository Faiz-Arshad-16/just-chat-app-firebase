import '../../domain/entities/chat_entity.dart';
import '../../domain/entities/message_entity.dart';
import '../../domain/repositories/chat_repository.dart';
import '../datasources/chat_firebase_data_source.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatFirebaseDataSource dataSource;

  ChatRepositoryImpl(this.dataSource);

  @override
  Future<void> startChat(String userId, String partnerEmail, String message) {
    return dataSource.startChat(userId, partnerEmail, message);
  }

  @override
  Stream<List<ChatEntity>> getChats(String userId) {
    return dataSource.getChats(userId);
  }

  @override
  Stream<List<MessageEntity>> getMessages(String chatId) {
    return dataSource.getMessages(chatId);
  }

  @override
  Future<void> sendMessage(String chatId, String userId, String text) {
    return dataSource.sendMessage(chatId, userId, text);
  }

  @override
  Future<void> deleteMessages(String chatId, List<String> messageIds, String userId) async {
    await dataSource.deleteMessages(chatId, messageIds, userId);
  }

  @override
  Future<void> deleteChats(List<String> chatIds, String userId) async {
    await dataSource.deleteChats(chatIds, userId);
  }
}