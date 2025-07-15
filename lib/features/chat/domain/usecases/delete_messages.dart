import '../repositories/chat_repository.dart';

class DeleteMessages {
  final ChatRepository repository;

  DeleteMessages(this.repository);

  Future<void> call(DeleteMessagesParams params) async {
    await repository.deleteMessages(params.chatId, params.messageIds, params.userId);
  }
}

class DeleteMessagesParams {
  final String chatId;
  final List<String> messageIds;
  final String userId;

  DeleteMessagesParams({
    required this.chatId,
    required this.messageIds,
    required this.userId,
  });
}