import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/providers/app_provider.dart';
import '../../data/datasources/chat_firebase_data_source.dart';
import '../../data/repositories/chat_repository_impl.dart';
import '../../domain/usecases/delete_chats.dart';
import '../../domain/usecases/delete_messages.dart';
import '../../domain/usecases/start_chat.dart';
import '../../domain/usecases/get_chats.dart';
import '../../domain/usecases/get_messages.dart';
import '../../domain/usecases/send_message.dart';
import '../../domain/entities/chat_entity.dart';
import '../../domain/entities/message_entity.dart';

final chatDataSourceProvider = Provider<ChatFirebaseDataSource>(
      (ref) => ChatFirebaseDataSource(),
);

final chatRepositoryProvider = Provider<ChatRepositoryImpl>(
      (ref) => ChatRepositoryImpl(ref.read(chatDataSourceProvider)),
);

final startChatProvider = Provider<StartChat>(
      (ref) => StartChat(ref.read(chatRepositoryProvider)),
);

final getChatsProvider = Provider<GetChats>(
      (ref) => GetChats(ref.read(chatRepositoryProvider)),
);

final getMessagesProvider = Provider<GetMessages>(
      (ref) => GetMessages(ref.read(chatRepositoryProvider)),
);

final sendMessageProvider = Provider<SendMessage>(
      (ref) => SendMessage(ref.read(chatRepositoryProvider)),
);

final deleteMessagesProvider = Provider<DeleteMessages>(
      (ref) => DeleteMessages(ref.read(chatRepositoryProvider)),
);

final deleteChatsProvider = Provider<DeleteChats>(
        (ref) => DeleteChats(ref.read(chatRepositoryProvider))
);

final chatsProvider = StreamProvider.family<List<ChatEntity>, String>(
      (ref, userId) => ref.read(getChatsProvider).call(userId),
);

final messagesProvider = StreamProvider.family<List<MessageEntity>, String>(
      (ref, chatId) => ref.read(getMessagesProvider).call(chatId),
);
