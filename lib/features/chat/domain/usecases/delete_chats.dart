import '../repositories/chat_repository.dart';

class DeleteChats {
  final ChatRepository repository;

  DeleteChats(this.repository);

  Future<void> call(DeleteChatsParams params) async {
    await repository.deleteChats(params.chatIds, params.userId);
  }
}

class DeleteChatsParams {
  final List<String> chatIds;
  final String userId;

  DeleteChatsParams({
    required this.chatIds,
    required this.userId,
  });
}