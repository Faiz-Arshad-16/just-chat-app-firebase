// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import '../../domain/entities/chat_entity.dart';
// import '../../domain/entities/message_entity.dart';
//
// class ChatFirebaseDataSource {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//
//   Future<void> startChat(String userId, String partnerEmail, String message) async {
//     try {
//       final partnerSnapshot = await _firestore
//           .collection('users')
//           .where('email', isEqualTo: partnerEmail)
//           .get();
//       if (partnerSnapshot.docs.isEmpty) {
//         throw Exception('User not found');
//       }
//       final partnerId = partnerSnapshot.docs.first.id;
//       final chatId = _generateChatId(userId, partnerId);
//
//       final chatRef = _firestore.collection('chats').doc(chatId);
//       final chatSnapshot = await chatRef.get();
//       if (!chatSnapshot.exists) {
//         await chatRef.set({
//           'participantIds': [userId, partnerId],
//           'lastMessage': message,
//           'lastMessageTimestamp': FieldValue.serverTimestamp(),
//         });
//         print('Chat created: $chatId with participants: $userId, $partnerId');
//       } else {
//         print('Chat already exists: $chatId');
//       }
//
//       await chatRef.collection('messages').add({
//         'senderId': userId,
//         'text': message,
//         'timestamp': FieldValue.serverTimestamp(),
//       });
//       print('Message sent to chat: $chatId');
//     } catch (e) {
//       print('Error in startChat: $e');
//       throw Exception('Failed to start chat: $e');
//     }
//   }
//
//   Stream<List<ChatEntity>> getChats(String userId) {
//     return _firestore
//         .collection('chats')
//         .where('participantIds', arrayContains: userId)
//         .snapshots()
//         .map((snapshot) {
//       print('Fetched chats for user: $userId, count: ${snapshot.docs.length}');
//       return snapshot.docs
//           .map((doc) => ChatEntity(
//         id: doc.id,
//         participantIds: List<String>.from(doc['participantIds']),
//         lastMessage: doc['lastMessage'] ?? '',
//         lastMessageTimestamp:
//         (doc['lastMessageTimestamp'] as Timestamp?)?.toDate() ?? DateTime.now(),
//       ))
//           .toList()
//         ..sort((a, b) => b.lastMessageTimestamp.compareTo(a.lastMessageTimestamp));
//     });
//   }
//
//   Stream<List<MessageEntity>> getMessages(String chatId) {
//     return _firestore
//         .collection('chats')
//         .doc(chatId)
//         .collection('messages')
//         .orderBy('timestamp', descending: true)
//         .snapshots()
//         .map((snapshot) {
//       print('Fetched messages for chat: $chatId, count: ${snapshot.docs.length}');
//       return snapshot.docs.map((doc) {
//         final timestamp = doc['timestamp'] as Timestamp?;
//         if (timestamp == null) {
//           print('Warning: Message ${doc.id} in chat $chatId has no timestamp');
//         }
//         return MessageEntity(
//           id: doc.id,
//           senderId: doc['senderId'],
//           text: doc['text'],
//           timestamp: timestamp?.toDate() ?? DateTime.now(),
//         );
//       }).toList();
//     });
//   }
//
//   Future<void> sendMessage(String chatId, String userId, String text) async {
//     try {
//       final chatRef = _firestore.collection('chats').doc(chatId);
//       final chatSnapshot = await chatRef.get();
//       if (!chatSnapshot.exists) {
//         throw Exception('Chat does not exist: $chatId');
//       }
//       await chatRef.collection('messages').add({
//         'senderId': userId,
//         'text': text,
//         'timestamp': FieldValue.serverTimestamp(),
//       });
//       await chatRef.update({
//         'lastMessage': text,
//         'lastMessageTimestamp': FieldValue.serverTimestamp(),
//       });
//       print('Message sent to chat: $chatId');
//     } catch (e) {
//       print('Error in sendMessage: $e');
//       throw Exception('Failed to send message: $e');
//     }
//   }
//
//   Future<void> deleteMessages(String chatId, List<String> messageIds, String userId) async {
//     try {
//       final chatRef = _firestore.collection('chats').doc(chatId);
//       final batch = _firestore.batch();
//
//       // Get the most recent non-deleted message to update lastMessage
//       final messagesSnapshot = await chatRef
//           .collection('messages')
//           .where('isDeleted', isEqualTo: false)
//           .orderBy('timestamp', descending: true)
//           .limit(1)
//           .get();
//
//       String? newLastMessage;
//       Timestamp? newLastMessageTimestamp;
//
//       if (messagesSnapshot.docs.isNotEmpty) {
//         final latestMessage = messagesSnapshot.docs.first;
//         newLastMessage = latestMessage.data().containsKey('isDeleted') && latestMessage['isDeleted'] == true
//             ? 'This message was deleted'
//             : latestMessage['text'];
//         newLastMessageTimestamp = latestMessage['timestamp'] as Timestamp?;
//       }
//
//       // Mark selected messages as deleted
//       for (final messageId in messageIds) {
//         final messageRef = chatRef.collection('messages').doc(messageId);
//         batch.update(messageRef, {
//           'isDeleted': true,
//           'text': 'This message was deleted',
//         });
//       }
//
//       // Update lastMessage if necessary
//       if (newLastMessage != null) {
//         batch.update(chatRef, {
//           'lastMessage': newLastMessage,
//           'lastMessageTimestamp': newLastMessageTimestamp ?? FieldValue.serverTimestamp(),
//         });
//       } else {
//         batch.update(chatRef, {
//           'lastMessage': 'This message was deleted',
//           'lastMessageTimestamp': FieldValue.serverTimestamp(),
//         });
//       }
//
//       await batch.commit();
//       print('Deleted messages: $messageIds in chat: $chatId');
//     } catch (e) {
//       print('Error in deleteMessages: $e');
//       throw Exception('Failed to delete messages: $e');
//     }
//   }
//
//   Future<void> deleteChats(List<String> chatIds, String userId) async {
//     try {
//       final batch = _firestore.batch();
//       for (final chatId in chatIds) {
//         final chatRef = _firestore.collection('chats').doc(chatId);
//         // Delete all messages in the subcollection
//         final messagesSnapshot = await chatRef.collection('messages').get();
//         for (final doc in messagesSnapshot.docs) {
//           batch.delete(doc.reference);
//         }
//         // Delete the chat document
//         batch.delete(chatRef);
//       }
//       await batch.commit();
//       print('Deleted chats: $chatIds');
//     } catch (e) {
//       print('Error in deleteChats: $e');
//       throw Exception('Failed to delete chats: $e');
//     }
//   }
//
//   String _generateChatId(String userId1, String userId2) {
//     final ids = [userId1, userId2]..sort();
//     return '${ids[0]}_${ids[1]}';
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../domain/entities/chat_entity.dart';
import '../../domain/entities/message_entity.dart';

class ChatFirebaseDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> startChat(String userId, String partnerEmail, String message) async {
    try {
      if (_auth.currentUser == null) {
        throw Exception('User not authenticated');
      }
      print('Starting chat for user: $userId, partnerEmail: $partnerEmail, message: $message');

      // Query users collection for partner email
      final partnerSnapshot = await _firestore
          .collection('users')
          .where('email', isEqualTo: partnerEmail)
          .limit(1)
          .get();

      if (partnerSnapshot.docs.isEmpty) {
        print('No user found with email: $partnerEmail');
        throw Exception('User with email $partnerEmail not found');
      }

      final partnerDoc = partnerSnapshot.docs.first;
      final partnerId = partnerDoc.id;
      final partnerData = partnerDoc.data();
      print('Partner found: ID=$partnerId, data=$partnerData');

      if (partnerId == userId) {
        print('Cannot start chat with self: $userId');
        throw Exception('Cannot start chat with yourself');
      }

      final chatId = _generateChatId(userId, partnerId);
      final chatRef = _firestore.collection('chats').doc(chatId);

      // Create or update chat document
      await chatRef.set({
        'participantIds': [userId, partnerId],
        'lastMessage': message,
        'lastMessageTimestamp': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
      print('Chat created or updated: $chatId with participants: $userId, $partnerId');

      // Send the initial message
      await chatRef.collection('messages').add({
        'senderId': userId,
        'text': message,
        'timestamp': FieldValue.serverTimestamp(),
        'isDeleted': false,
      });
      print('Message sent to chat: $chatId');
    } catch (e) {
      print('Error in startChat: $e');
      throw Exception('Failed to start chat: $e');
    }
  }

  Stream<List<ChatEntity>> getChats(String userId) {
    try {
      return _firestore
          .collection('chats')
          .where('participantIds', arrayContains: userId)
          .snapshots()
          .map((snapshot) {
        print('Fetched chats for user: $userId, count: ${snapshot.docs.length}');
        return snapshot.docs
            .map((doc) => ChatEntity(
          id: doc.id,
          participantIds: List<String>.from(doc['participantIds'] ?? []),
          lastMessage: doc['lastMessage'] ?? '',
          lastMessageTimestamp:
          (doc['lastMessageTimestamp'] as Timestamp?)?.toDate() ?? DateTime.now(),
        ))
            .toList()
          ..sort((a, b) => b.lastMessageTimestamp.compareTo(a.lastMessageTimestamp));
      });
    } catch (e) {
      print('Error in getChats: $e');
      throw Exception('Failed to fetch chats: $e');
    }
  }

  Stream<List<MessageEntity>> getMessages(String chatId) {
    try {
      return _firestore
          .collection('chats')
          .doc(chatId)
          .collection('messages')
          .orderBy('timestamp', descending: true)
          .snapshots()
          .map((snapshot) {
        print('Fetched messages for chat: $chatId, count: ${snapshot.docs.length}');
        return snapshot.docs.map((doc) {
          final timestamp = doc['timestamp'] as Timestamp?;
          final isDeleted = doc.data().containsKey('isDeleted') ? doc['isDeleted'] as bool : false;
          if (timestamp == null) {
            print('Warning: Message ${doc.id} in chat $chatId has no timestamp');
          }
          if (doc['senderId'] == null || doc['text'] == null) {
            print('Warning: Message ${doc.id} in chat $chatId has missing fields: senderId=${doc['senderId']}, text=${doc['text']}');
          }
          return MessageEntity(
            id: doc.id,
            senderId: doc['senderId'] ?? '',
            text: isDeleted ? 'This message was deleted' : doc['text'] ?? '',
            timestamp: timestamp?.toDate() ?? DateTime.now(),
            isDeleted: isDeleted,
          );
        }).toList();
      });
    } catch (e) {
      print('Error in getMessages: $e');
      throw Exception('Failed to fetch messages: $e');
    }
  }

  Future<void> sendMessage(String chatId, String userId, String text) async {
    try {
      final chatRef = _firestore.collection('chats').doc(chatId);
      final chatSnapshot = await chatRef.get();
      if (!chatSnapshot.exists) {
        throw Exception('Chat does not exist: $chatId');
      }
      await chatRef.collection('messages').add({
        'senderId': userId,
        'text': text,
        'timestamp': FieldValue.serverTimestamp(),
        'isDeleted': false,
      });
      await chatRef.update({
        'lastMessage': text,
        'lastMessageTimestamp': FieldValue.serverTimestamp(),
      });
      print('Message sent to chat: $chatId');
    } catch (e) {
      print('Error in sendMessage: $e');
      throw Exception('Failed to send message: $e');
    }
  }

  Future<void> deleteMessages(String chatId, List<String> messageIds, String userId) async {
    try {
      final chatRef = _firestore.collection('chats').doc(chatId);
      final batch = _firestore.batch();

      // Get the most recent non-deleted message to update lastMessage
      final messagesSnapshot = await chatRef
          .collection('messages')
          .where('isDeleted', isEqualTo: false)
          .orderBy('timestamp', descending: true)
          .limit(1)
          .get();

      String? newLastMessage;
      Timestamp? newLastMessageTimestamp;

      if (messagesSnapshot.docs.isNotEmpty) {
        final latestMessage = messagesSnapshot.docs.first;
        newLastMessage = latestMessage.data().containsKey('isDeleted') && latestMessage['isDeleted'] == true
            ? 'This message was deleted'
            : latestMessage['text'];
        newLastMessageTimestamp = latestMessage['timestamp'] as Timestamp?;
      }

      // Mark selected messages as deleted
      for (final messageId in messageIds) {
        final messageRef = chatRef.collection('messages').doc(messageId);
        batch.update(messageRef, {
          'isDeleted': true,
          'text': 'This message was deleted',
        });
      }

      // Update lastMessage if necessary
      if (newLastMessage != null) {
        batch.update(chatRef, {
          'lastMessage': newLastMessage,
          'lastMessageTimestamp': newLastMessageTimestamp ?? FieldValue.serverTimestamp(),
        });
      } else {
        batch.update(chatRef, {
          'lastMessage': 'This message was deleted',
          'lastMessageTimestamp': FieldValue.serverTimestamp(),
        });
      }

      await batch.commit();
      print('Deleted messages: $messageIds in chat: $chatId');
    } catch (e) {
      print('Error in deleteMessages: $e');
      throw Exception('Failed to delete messages: $e');
    }
  }

  Future<void> deleteChats(List<String> chatIds, String userId) async {
    try {
      final batch = _firestore.batch();
      for (final chatId in chatIds) {
        final chatRef = _firestore.collection('chats').doc(chatId);
        // Delete all messages in the subcollection
        final messagesSnapshot = await chatRef.collection('messages').get();
        for (final doc in messagesSnapshot.docs) {
          batch.delete(doc.reference);
        }
        // Delete the chat document
        batch.delete(chatRef);
      }
      await batch.commit();
      print('Deleted chats: $chatIds');
    } catch (e) {
      print('Error in deleteChats: $e');
      throw Exception('Failed to delete chats: $e');
    }
  }

  String _generateChatId(String userId1, String userId2) {
    final ids = [userId1, userId2]..sort();
    return '${ids[0]}_${ids[1]}';
  }
}