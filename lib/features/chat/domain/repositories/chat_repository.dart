import '../entities/chat_entity.dart';
import '../entities/message_entity.dart';

abstract class ChatRepository {
  Future<void> startChat(String userId, String partnerEmail, String message);
  Stream<List<ChatEntity>> getChats(String userId);
  Stream<List<MessageEntity>> getMessages(String chatId);
  Future<void> sendMessage(String chatId, String userId, String text);
  Future<void> deleteMessages(String chatId, List<String> messageIds, String userId);
  Future<void> deleteChats(List<String> chatIds, String userId);
}