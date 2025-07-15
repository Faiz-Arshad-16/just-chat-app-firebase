import 'package:equatable/equatable.dart';

class MessageEntity extends Equatable {
  final String id;
  final String senderId;
  final String text;
  final DateTime timestamp;
  final bool isDeleted;

  const MessageEntity({
    required this.id,
    required this.senderId,
    required this.text,
    required this.timestamp,
    this.isDeleted = false,
  });

  @override
  List<Object> get props => [id, senderId, text, timestamp, isDeleted];
}