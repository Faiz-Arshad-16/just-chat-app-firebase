// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import '../../../../core/routes/on_generate_route.dart';
// import '../../../../core/utils/time_stamp_utils.dart';
// import '../../../../core/providers/app_provider.dart';
// import '../../../user/presentation/providers/auth_provider.dart';
// import '../providers/chat_provider.dart';
//
// class ChatPage extends ConsumerWidget {
//   const ChatPage({super.key});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final routeArgs = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
//     final chatId = routeArgs?['chatId'] as String? ?? '';
//     final partnerUsername = routeArgs?['partnerUsername'] as String? ?? 'Unknown';
//     final user = ref.watch(authStateProvider).valueOrNull;
//     final messageController = TextEditingController();
//     final isLoading = ref.watch(loadingProvider);
//
//     print('ChatPage opened with chatId: $chatId, partner: $partnerUsername, user: ${user?.uid}');
//
//     return Scaffold(
//       body: SafeArea(
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
//               child: Row(
//                 children: [
//                   IconButton(
//                     icon: const Icon(Icons.arrow_back),
//                     onPressed: () => Navigator.pop(context),
//                   ),
//                   const SizedBox(width: 8.0),
//                   CircleAvatar(
//                     radius: 20.0,
//                     child: Text(
//                       partnerUsername.isNotEmpty ? partnerUsername[0].toUpperCase() : '?',
//                       style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                   const SizedBox(width: 12.0),
//                   Expanded(
//                     child: Text(
//                       partnerUsername,
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                         color: Theme.of(context).colorScheme.primary,
//                       ),
//                     ),
//                   ),
//                   IconButton(
//                     icon: const Icon(Icons.more_vert),
//                     onPressed: () {},
//                   ),
//                 ],
//               ),
//             ),
//             Expanded(
//               child: user == null
//                   ? const Center(child: Text('Please log in'))
//                   : ref.watch(messagesProvider(chatId)).when(
//                 data: (messages) {
//                   print('Messages loaded for chatId: $chatId, count: ${messages.length}');
//                   return ListView.builder(
//                     reverse: true,
//                     itemCount: messages.length,
//                     itemBuilder: (context, index) {
//                       final message = messages[index];
//                       final isSent = message.senderId == user.uid;
//                       return Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
//                         child: Row(
//                           mainAxisAlignment:
//                           isSent ? MainAxisAlignment.end : MainAxisAlignment.start,
//                           children: [
//                             if (!isSent) ...[
//                               CircleAvatar(
//                                 radius: 16.0,
//                                 child: Text(
//                                   partnerUsername.isNotEmpty ? partnerUsername[0].toUpperCase() : '?',
//                                   style: const TextStyle(fontSize: 12),
//                                 ),
//                               ),
//                               const SizedBox(width: 8.0),
//                             ],
//                             Flexible(
//                               child: Container(
//                                 padding: const EdgeInsets.all(12.0),
//                                 decoration: BoxDecoration(
//                                   color: isSent
//                                       ? Theme.of(context).colorScheme.primary.withOpacity(0.8)
//                                       : Colors.grey[300],
//                                   borderRadius: BorderRadius.circular(12.0),
//                                 ),
//                                 child: Text(message.text, style: TextStyle(color: isSent ? Colors.white : Colors.black),),
//                               ),
//                             ),
//                             if (isSent) ...[
//                               const SizedBox(width: 8.0),
//                               CircleAvatar(
//                                 radius: 16.0,
//                                 child: Text(
//                                   user.username.isNotEmpty ? user.username[0].toUpperCase() : '?',
//                                   style: const TextStyle(fontSize: 12),
//                                 ),
//                               ),
//                             ],
//                           ],
//                         ),
//                       );
//                     },
//                   );
//                 },
//                 loading: () => const Center(child: CircularProgressIndicator()),
//                 error: (e, stack) {
//                   print('Messages error for chatId: $chatId, error: $e, stack: $stack');
//                   // Delay error display to avoid flash
//                   return const Center(child: CircularProgressIndicator());
//                 },
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: TextField(
//                       controller: messageController,
//                       decoration: InputDecoration(
//                         hintText: 'Type a message',
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8.0),
//                         ),
//                       ),
//                       onSubmitted: (value) async {
//                         if (value.isNotEmpty) {
//                           ref.read(loadingProvider.notifier).state = true;
//                           try {
//                             await ref.read(sendMessageProvider).call(chatId, user!.uid, value);
//                             messageController.clear();
//                             print('Message sent successfully: $value');
//                           } catch (e) {
//                             print('Send message error: $e');
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               SnackBar(content: Text('Failed to send message: $e')),
//                             );
//                           } finally {
//                             ref.read(loadingProvider.notifier).state = false;
//                           }
//                         }
//                       },
//                       onTapOutside: (_) => FocusScope.of(context).unfocus(),
//                     ),
//                   ),
//                   const SizedBox(width: 8.0),
//                   PopupMenuButton<String>(
//                     icon: const Icon(Icons.attach_file),
//                     onSelected: (value) {},
//                     itemBuilder: (context) => [
//                       const PopupMenuItem(
//                         value: 'Picture',
//                         child: Text('Send Picture'),
//                       ),
//                       const PopupMenuItem(
//                         value: 'Video',
//                         child: Text('Send Video'),
//                       ),
//                       const PopupMenuItem(
//                         value: 'Document',
//                         child: Text('Send Document'),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../core/routes/on_generate_route.dart';
import '../../../../core/utils/time_stamp_utils.dart';
import '../../../../core/providers/app_provider.dart';
import '../../../user/presentation/providers/auth_provider.dart';
import '../../domain/usecases/delete_messages.dart';
import '../providers/chat_provider.dart';

class ChatPage extends ConsumerStatefulWidget {
  const ChatPage({super.key});

  @override
  ChatPageState createState() => ChatPageState();
}

class ChatPageState extends ConsumerState<ChatPage> {
  final List<String> _selectedMessageIds = [];
  bool _isSelectionMode = false;

  @override
  Widget build(BuildContext context) {
    final routeArgs = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    final chatId = routeArgs?['chatId'] as String? ?? '';
    final partnerUsername = routeArgs?['partnerUsername'] as String? ?? 'Unknown';
    final user = ref.watch(authStateProvider).valueOrNull;
    final messageController = TextEditingController();
    final isLoading = ref.watch(loadingProvider);

    print('ChatPage opened with chatId: $chatId, partner: $partnerUsername, user: ${user?.uid}');

    return Scaffold(
      appBar: _isSelectionMode
          ? AppBar(
        title: Text('${_selectedMessageIds.length} selected'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            setState(() {
              _selectedMessageIds.clear();
              _isSelectionMode = false;
            });
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: _selectedMessageIds.isNotEmpty
                ? () async {
              ref.read(loadingProvider.notifier).state = true;
              try {
                await ref.read(deleteMessagesProvider).call(
                  DeleteMessagesParams(
                    chatId: chatId,
                    messageIds: _selectedMessageIds,
                    userId: user!.uid,
                  ),
                );
                setState(() {
                  _selectedMessageIds.clear();
                  _isSelectionMode = false;
                });
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Failed to delete messages: $e')),
                );
              } finally {
                ref.read(loadingProvider.notifier).state = false;
              }
            }
                : null,
          ),
        ],
      )
          : null,
      body: SafeArea(
        child: Column(
          children: [
            if (!_isSelectionMode)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const SizedBox(width: 8.0),
                    CircleAvatar(
                      radius: 20.0,
                      child: Text(
                        partnerUsername.isNotEmpty ? partnerUsername[0].toUpperCase() : '?',
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(width: 12.0),
                    Expanded(
                      child: Text(
                        partnerUsername,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.more_vert),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            Expanded(
              child: user == null
                  ? const Center(child: Text('Please log in'))
                  : ref.watch(messagesProvider(chatId)).when(
                data: (messages) {
                  print('Messages loaded for chatId: $chatId, count: ${messages.length}');
                  return ListView.builder(
                    reverse: true,
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final message = messages[index];
                      final isSent = message.senderId == user.uid;
                      final isSelected = _selectedMessageIds.contains(message.id);
                      return GestureDetector(
                        onLongPress: () {
                          if (!message.isDeleted) {
                            setState(() {
                              _isSelectionMode = true;
                              if (isSelected) {
                                _selectedMessageIds.remove(message.id);
                              } else {
                                _selectedMessageIds.add(message.id);
                              }
                            });
                          }
                        },
                        onTap: () {
                          if (_isSelectionMode && !message.isDeleted) {
                            setState(() {
                              if (isSelected) {
                                _selectedMessageIds.remove(message.id);
                              } else {
                                _selectedMessageIds.add(message.id);
                              }
                            });
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                          child: Row(
                            mainAxisAlignment:
                            isSent ? MainAxisAlignment.end : MainAxisAlignment.start,
                            children: [
                              if (!isSent && !message.isDeleted) ...[
                                CircleAvatar(
                                  radius: 16.0,
                                  child: Text(
                                    partnerUsername.isNotEmpty
                                        ? partnerUsername[0].toUpperCase()
                                        : '?',
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ),
                                const SizedBox(width: 8.0),
                              ],
                              if (_isSelectionMode && !message.isDeleted)
                                Checkbox(
                                  value: isSelected,
                                  onChanged: (value) {
                                    setState(() {
                                      if (value == true) {
                                        _selectedMessageIds.add(message.id);
                                      } else {
                                        _selectedMessageIds.remove(message.id);
                                      }
                                    });
                                  },
                                ),
                              Flexible(
                                child: Container(
                                  padding: const EdgeInsets.all(12.0),
                                  decoration: BoxDecoration(
                                    color: message.isDeleted
                                        ? Colors.grey[200]
                                        : isSent
                                        ? Theme.of(context)
                                        .colorScheme
                                        .primary
                                        .withOpacity(0.8)
                                        : Colors.grey[300],
                                    borderRadius: BorderRadius.circular(12.0),
                                    border: isSelected
                                        ? Border.all(
                                      color: Theme.of(context).colorScheme.primary,
                                      width: 2.0,
                                    )
                                        : null,
                                  ),
                                  child: Text(
                                    message.text,
                                    style: TextStyle(
                                      color: message.isDeleted
                                          ? Colors.grey
                                          : isSent
                                          ? Colors.white
                                          : Colors.black,
                                      fontStyle: message.isDeleted
                                          ? FontStyle.italic
                                          : FontStyle.normal,
                                    ),
                                  ),
                                ),
                              ),
                              if (isSent && !message.isDeleted) ...[
                                const SizedBox(width: 8.0),
                                CircleAvatar(
                                  radius: 16.0,
                                  child: Text(
                                    user.username.isNotEmpty
                                        ? user.username[0].toUpperCase()
                                        : '?',
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, stack) {
                  print('Messages error for chatId: $chatId, error: $e, stack: $stack');
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: messageController,
                      decoration: InputDecoration(
                        hintText: 'Type a message',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      onSubmitted: (value) async {
                        if (value.isNotEmpty) {
                          ref.read(loadingProvider.notifier).state = true;
                          try {
                            await ref.read(sendMessageProvider).call(chatId, user!.uid, value);
                            messageController.clear();
                            print('Message sent successfully: $value');
                          } catch (e) {
                            print('Send message error: $e');
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Failed to send message: $e')),
                            );
                          } finally {
                            ref.read(loadingProvider.notifier).state = false;
                          }
                        }
                      },
                      onTapOutside: (_) => FocusScope.of(context).unfocus(),
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  PopupMenuButton<String>(
                    icon: const Icon(Icons.attach_file),
                    onSelected: (value) {},
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                        value: 'Picture',
                        child: Text('Send Picture'),
                      ),
                      const PopupMenuItem(
                        value: 'Video',
                        child: Text('Send Video'),
                      ),
                      const PopupMenuItem(
                        value: 'Document',
                        child: Text('Send Document'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}