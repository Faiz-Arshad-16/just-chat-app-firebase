import 'package:equatable/equatable.dart';

class ChatEntity extends Equatable {
  final String id;
  final List<String> participantIds;
  final String lastMessage;
  final DateTime lastMessageTimestamp;

  const ChatEntity({
    required this.id,
    required this.participantIds,
    required this.lastMessage,
    required this.lastMessageTimestamp,
  });

  @override
  List<Object> get props => [id, participantIds, lastMessage, lastMessageTimestamp];
}