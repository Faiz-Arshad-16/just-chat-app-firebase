// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import '../../../../core/routes/on_generate_route.dart';
// import '../../../../core/utils/time_stamp_utils.dart';
// import '../../../../core/providers/app_provider.dart';
// import '../../../user/presentation/providers/auth_provider.dart';
// import '../../domain/entities/chat_entity.dart';
// import '../providers/chat_provider.dart';
//
// class HomePage extends ConsumerStatefulWidget {
//   const HomePage({super.key});
//
//   @override
//   HomePageState createState() => HomePageState();
// }
//
// class HomePageState extends ConsumerState<HomePage> {
//   Offset? fabPosition;
//   bool isDragging = false;
//   final TextEditingController _searchController = TextEditingController();
//   String _searchQuery = '';
//
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       final mediaQuery = MediaQuery.of(context);
//       const fabSize = 56.0;
//       const sideMargin = 20.0;
//       const bottomMargin = 20.0;
//       setState(() {
//         fabPosition = Offset(
//           mediaQuery.size.width - fabSize - sideMargin,
//           mediaQuery.size.height - fabSize - bottomMargin - mediaQuery.padding.bottom,
//         );
//       });
//     });
//     _searchController.addListener(() {
//       setState(() {
//         _searchQuery = _searchController.text.toLowerCase();
//       });
//     });
//   }
//
//   @override
//   void dispose() {
//     _searchController.dispose();
//     super.dispose();
//   }
//
//   void _showNewChatDialog(BuildContext context, WidgetRef ref) {
//     final emailController = TextEditingController();
//     final messageController = TextEditingController();
//     final formKey = GlobalKey<FormState>();
//
//     showDialog(
//       context: context,
//       builder: (context) {
//         final isLoading = ref.watch(loadingProvider);
//         return AlertDialog(
//           title: const Text('Start New Chat'),
//           content: Form(
//             key: formKey,
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 TextFormField(
//                   controller: emailController,
//                   keyboardType: TextInputType.emailAddress,
//                   decoration: InputDecoration(
//                     labelText: 'Partner\'s Email',
//                     hintText: 'Enter partner\'s email',
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8.0),
//                     ),
//                   ),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter an email';
//                     }
//                     final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
//                     if (!emailRegex.hasMatch(value)) {
//                       return 'Please enter a valid email';
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 16.0),
//                 TextFormField(
//                   controller: messageController,
//                   maxLines: 3,
//                   decoration: InputDecoration(
//                     labelText: 'Message',
//                     hintText: 'Write your message',
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8.0),
//                     ),
//                   ),
//                   validator: (value) => value == null || value.isEmpty ? 'Please enter a message' : null,
//                 ),
//               ],
//             ),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: const Text('Cancel'),
//             ),
//             TextButton(
//               onPressed: isLoading
//                   ? null
//                   : () async {
//                 if (formKey.currentState!.validate()) {
//                   ref.read(loadingProvider.notifier).state = true;
//                   try {
//                     final user = ref.read(authStateProvider).valueOrNull;
//                     if (user == null) throw Exception('User not logged in');
//                     await ref.read(startChatProvider).call(
//                       user.uid,
//                       emailController.text,
//                       messageController.text,
//                     );
//                     Navigator.pop(context);
//                   } catch (e) {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(content: Text('Failed to start chat: $e')),
//                     );
//                   } finally {
//                     ref.read(loadingProvider.notifier).state = false;
//                   }
//                 }
//               },
//               child: isLoading
//                   ? const CircularProgressIndicator()
//                   : Text(
//                 'Send',
//                 style: TextStyle(color: Theme.of(context).colorScheme.primary),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final mediaQuery = MediaQuery.of(context);
//     final screenWidth = mediaQuery.size.width;
//     final screenHeight = mediaQuery.size.height;
//     const fabSize = 56.0;
//     const topMargin = 100.0;
//     const bottomMargin = 20.0;
//     const sideMargin = 20.0;
//     final user = ref.watch(authStateProvider).valueOrNull;
//
//     return WillPopScope(
//       onWillPop: () async {
//         bool? shouldExit = await showDialog<bool>(
//           context: context,
//           builder: (context) => AlertDialog(
//             title: const Text('Exit App'),
//             content: const Text('Are you sure you want to exit?'),
//             actions: [
//               TextButton(
//                 onPressed: () => Navigator.pop(context, false),
//                 child: const Text('Cancel'),
//               ),
//               TextButton(
//                 onPressed: () => Navigator.pop(context, true),
//                 child: Text(
//                   'Exit',
//                   style: TextStyle(color: Theme.of(context).colorScheme.primary),
//                 ),
//               ),
//             ],
//           ),
//         );
//         return shouldExit ?? false;
//       },
//       child: Scaffold(
//         body: Stack(
//           children: [
//             SafeArea(
//               child: Column(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         GestureDetector(
//                           onTap: () {
//                             Navigator.pushNamed(context, PageConst.profile);
//                           },
//                           child: CircleAvatar(
//                             radius: 24.0,
//                             child: Text(
//                               user?.username.isNotEmpty == true
//                                   ? user!.username[0].toUpperCase()
//                                   : '?',
//                               style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
//                             ),
//                           ),
//                         ),
//                         Text(
//                           'Just Chat',
//                           style: TextStyle(
//                             fontSize: 24,
//                             fontWeight: FontWeight.bold,
//                             color: Theme.of(context).colorScheme.primary,
//                           ),
//                         ),
//                         const SizedBox(width: 48.0),
//                       ],
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                     child: TextField(
//                       controller: _searchController,
//                       decoration: InputDecoration(
//                         hintText: 'Search chats by username',
//                         prefixIcon: const Icon(Icons.search),
//                         suffixIcon: _searchQuery.isNotEmpty
//                             ? IconButton(
//                           icon: const Icon(Icons.clear),
//                           onPressed: () {
//                             _searchController.clear();
//                             setState(() {
//                               _searchQuery = '';
//                             });
//                           },
//                         )
//                             : null,
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8.0),
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 16.0),
//                   Expanded(
//                     child: user == null
//                         ? const Center(child: Text('Please log in'))
//                         : ref.watch(chatsProvider(user.uid)).when(
//                       data: (chats) {
//                         return FutureBuilder<List<Map<String, dynamic>>>(
//                           future: Future.wait(
//                             chats.map((chat) async {
//                               final partnerId = chat.participantIds.firstWhere(
//                                     (id) => id != user.uid,
//                                 orElse: () => '',
//                               );
//                               if (partnerId.isEmpty) {
//                                 return {
//                                   'chat': chat,
//                                   'username': '',
//                                 };
//                               }
//                               final doc = await FirebaseFirestore.instance
//                                   .collection('users')
//                                   .doc(partnerId)
//                                   .get();
//                               return {
//                                 'chat': chat,
//                                 'username': doc['username']?.toString().toLowerCase() ?? '',
//                               };
//                             }),
//                           ),
//                           builder: (context, snapshot) {
//                             if (!snapshot.hasData) {
//                               return const Center(child: CircularProgressIndicator());
//                             }
//                             final chatData = snapshot.data!;
//                             final visibleChats = chatData
//                                 .asMap()
//                                 .entries
//                                 .where((entry) =>
//                             _searchQuery.isEmpty ||
//                                 entry.value['username'].contains(_searchQuery))
//                                 .map((entry) => entry.value['chat'] as ChatEntity)
//                                 .toList();
//
//                             if (visibleChats.isEmpty) {
//                               return Center(
//                                   child: Text(_searchQuery.isEmpty
//                                       ? 'No chats yet'
//                                       : 'No chats found'));
//                             }
//
//                             return ListView.builder(
//                               itemCount: visibleChats.length,
//                               itemBuilder: (context, index) {
//                                 final chat = visibleChats[index];
//                                 final partnerId = chat.participantIds.firstWhere(
//                                       (id) => id != user.uid,
//                                   orElse: () => '',
//                                 );
//                                 final partnerUsername =
//                                     chatData.firstWhere((data) => data['chat'] == chat)['username'] ??
//                                         'Unknown';
//                                 return ListTile(
//                                   onTap: () {
//                                     Navigator.pushNamed(
//                                       context,
//                                       PageConst.chat,
//                                       arguments: {
//                                         'chatId': chat.id,
//                                         'partnerUsername': partnerUsername,
//                                       },
//                                     );
//                                   },
//                                   leading: CircleAvatar(
//                                     radius: 24.0,
//                                     child: Text(
//                                       partnerUsername.isNotEmpty
//                                           ? partnerUsername[0].toUpperCase()
//                                           : '?',
//                                       style: const TextStyle(
//                                           fontSize: 20, fontWeight: FontWeight.bold),
//                                     ),
//                                   ),
//                                   title: Text(partnerUsername),
//                                   subtitle: Text(
//                                     chat.lastMessage,
//                                     maxLines: 1,
//                                     overflow: TextOverflow.ellipsis,
//                                   ),
//                                   trailing: Text(
//                                     TimestampUtils.formatTimestamp(chat.lastMessageTimestamp),
//                                     style: TextStyle(
//                                       color: Theme.of(context).colorScheme.secondary,
//                                       fontSize: 12,
//                                     ),
//                                   ),
//                                 );
//                               },
//                             );
//                           },
//                         );
//                       },
//                       loading: () => const Center(child: CircularProgressIndicator()),
//                       error: (e, _) => Center(child: Text('Error: $e')),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             if (fabPosition != null)
//               Positioned(
//                 left: fabPosition!.dx,
//                 top: fabPosition!.dy,
//                 child: GestureDetector(
//                   onPanStart: (_) {
//                     setState(() => isDragging = true);
//                   },
//                   onPanUpdate: (details) {
//                     setState(() {
//                       fabPosition = Offset(
//                         (fabPosition!.dx + details.delta.dx)
//                             .clamp(sideMargin, screenWidth - fabSize - sideMargin),
//                         (fabPosition!.dy + details.delta.dy)
//                             .clamp(topMargin, screenHeight - fabSize - bottomMargin - mediaQuery.padding.bottom),
//                       );
//                     });
//                   },
//                   onPanEnd: (_) {
//                     setState(() => isDragging = false);
//                   },
//                   child: FloatingActionButton(
//                     onPressed: () => _showNewChatDialog(context, ref),
//                     backgroundColor: Theme.of(context).colorScheme.primary,
//                     tooltip: 'Start new chat',
//                     elevation: isDragging ? 12.0 : 6.0,
//                     child: const Icon(Icons.add),
//                   ),
//                 ),
//               ),
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
import '../../domain/entities/chat_entity.dart';
import '../../domain/usecases/delete_chats.dart';
import '../providers/chat_provider.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends ConsumerState<HomePage> {
  Offset? fabPosition;
  bool isDragging = false;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  final List<String> _selectedChatIds = [];
  bool _isSelectionMode = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final mediaQuery = MediaQuery.of(context);
      const fabSize = 56.0;
      const sideMargin = 20.0;
      const bottomMargin = 20.0;
      setState(() {
        fabPosition = Offset(
          mediaQuery.size.width - fabSize - sideMargin,
          mediaQuery.size.height - fabSize - bottomMargin - mediaQuery.padding.bottom,
        );
      });
    });
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text.toLowerCase();
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _showNewChatDialog(BuildContext context, WidgetRef ref) {
    final emailController = TextEditingController();
    final messageController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (context) {
        final isLoading = ref.watch(loadingProvider);
        return AlertDialog(
          title: const Text('Start New Chat'),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Partner\'s Email',
                    hintText: 'Enter partner\'s email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an email';
                    }
                    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                    if (!emailRegex.hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: messageController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    labelText: 'Message',
                    hintText: 'Write your message',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  validator: (value) => value == null || value.isEmpty ? 'Please enter a message' : null,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: isLoading
                  ? null
                  : () async {
                if (formKey.currentState!.validate()) {
                  ref.read(loadingProvider.notifier).state = true;
                  try {
                    final user = ref.read(authStateProvider).valueOrNull;
                    if (user == null) throw Exception('User not logged in');
                    await ref.read(startChatProvider).call(
                      user.uid,
                      emailController.text,
                      messageController.text,
                    );
                    Navigator.pop(context);
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Failed to start chat: $e')),
                    );
                  } finally {
                    ref.read(loadingProvider.notifier).state = false;
                  }
                }
              },
              child: isLoading
                  ? const CircularProgressIndicator()
                  : Text(
                'Send',
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;
    const fabSize = 56.0;
    const topMargin = 100.0;
    const bottomMargin = 20.0;
    const sideMargin = 20.0;
    final user = ref.watch(authStateProvider).valueOrNull;

    return WillPopScope(
      onWillPop: () async {
        if (_isSelectionMode) {
          setState(() {
            _selectedChatIds.clear();
            _isSelectionMode = false;
          });
          return false;
        }
        bool? shouldExit = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Exit App'),
            content: const Text('Are you sure you want to exit?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: Text(
                  'Exit',
                  style: TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
              ),
            ],
          ),
        );
        return shouldExit ?? false;
      },
      child: Scaffold(
        appBar: _isSelectionMode
            ? AppBar(
          title: Text('${_selectedChatIds.length} selected'),
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              setState(() {
                _selectedChatIds.clear();
                _isSelectionMode = false;
              });
            },
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: _selectedChatIds.isNotEmpty
                  ? () async {
                ref.read(loadingProvider.notifier).state = true;
                try {
                  await ref.read(deleteChatsProvider).call(
                    DeleteChatsParams(
                      chatIds: _selectedChatIds,
                      userId: user!.uid,
                    ),
                  );
                  setState(() {
                    _selectedChatIds.clear();
                    _isSelectionMode = false;
                  });
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Failed to delete chats: $e')),
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
        body: Stack(
          children: [
            SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, PageConst.profile);
                          },
                          child: CircleAvatar(
                            radius: 24.0,
                            child: Text(
                              user?.username.isNotEmpty == true
                                  ? user!.username[0].toUpperCase()
                                  : '?',
                              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                        Text(
                          'Just Chat',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        const SizedBox(width: 48.0),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: TextField(
                      controller: _searchController,
                      onTapOutside: (_){
                        FocusScope.of(context).unfocus();
                      },
                      decoration: InputDecoration(
                        hintText: 'Search chats by username',
                        prefixIcon: const Icon(Icons.search),
                        suffixIcon: _searchQuery.isNotEmpty
                            ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            _searchController.clear();
                            setState(() {
                              _searchQuery = '';
                            });
                          },
                        )
                            : null,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Expanded(
                    child: user == null
                        ? const Center(child: Text('Please log in'))
                        : ref.watch(chatsProvider(user.uid)).when(
                      data: (chats) {
                        return FutureBuilder<List<Map<String, dynamic>>>(
                          future: Future.wait(
                            chats.map((chat) async {
                              final partnerId = chat.participantIds.firstWhere(
                                    (id) => id != user.uid,
                                orElse: () => '',
                              );
                              if (partnerId.isEmpty) {
                                return {
                                  'chat': chat,
                                  'username': '',
                                };
                              }
                              final doc = await FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(partnerId)
                                  .get();
                              return {
                                'chat': chat,
                                'username': doc['username']?.toString().toLowerCase() ?? '',
                              };
                            }),
                          ),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return const Center(child: CircularProgressIndicator());
                            }
                            final chatData = snapshot.data!;
                            final visibleChats = chatData
                                .asMap()
                                .entries
                                .where((entry) =>
                            _searchQuery.isEmpty ||
                                entry.value['username'].contains(_searchQuery))
                                .map((entry) => entry.value['chat'] as ChatEntity)
                                .toList();

                            if (visibleChats.isEmpty) {
                              return Center(
                                  child: Text(_searchQuery.isEmpty
                                      ? 'No chats yet'
                                      : 'No chats found'));
                            }

                            return ListView.builder(
                              itemCount: visibleChats.length,
                              itemBuilder: (context, index) {
                                final chat = visibleChats[index];
                                final partnerId = chat.participantIds.firstWhere(
                                      (id) => id != user.uid,
                                  orElse: () => '',
                                );
                                final partnerUsername =
                                    chatData.firstWhere((data) => data['chat'] == chat)['username'] ??
                                        'Unknown';
                                final isSelected = _selectedChatIds.contains(chat.id);
                                return GestureDetector(
                                  onLongPress: () {
                                    setState(() {
                                      _isSelectionMode = true;
                                      if (isSelected) {
                                        _selectedChatIds.remove(chat.id);
                                      } else {
                                        _selectedChatIds.add(chat.id);
                                      }
                                    });
                                  },
                                  onTap: () {
                                    if (_isSelectionMode) {
                                      setState(() {
                                        if (isSelected) {
                                          _selectedChatIds.remove(chat.id);
                                        } else {
                                          _selectedChatIds.add(chat.id);
                                        }
                                      });
                                    } else {
                                      Navigator.pushNamed(
                                        context,
                                        PageConst.chat,
                                        arguments: {
                                          'chatId': chat.id,
                                          'partnerUsername': partnerUsername,
                                        },
                                      );
                                    }
                                  },
                                  child: ListTile(
                                    leading: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        if (_isSelectionMode)
                                          Checkbox(
                                            value: isSelected,
                                            onChanged: (value) {
                                              setState(() {
                                                if (value == true) {
                                                  _selectedChatIds.add(chat.id);
                                                } else {
                                                  _selectedChatIds.remove(chat.id);
                                                }
                                              });
                                            },
                                          ),
                                        CircleAvatar(
                                          radius: 24.0,
                                          child: Text(
                                            partnerUsername.isNotEmpty
                                                ? partnerUsername[0].toUpperCase()
                                                : '?',
                                            style: const TextStyle(
                                                fontSize: 20, fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                    title: Text(partnerUsername),
                                    subtitle: Text(
                                      chat.lastMessage,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    trailing: Text(
                                      TimestampUtils.formatTimestamp(chat.lastMessageTimestamp),
                                      style: TextStyle(
                                        color: Theme.of(context).colorScheme.secondary,
                                        fontSize: 12,
                                      ),
                                    ),
                                    selected: isSelected,
                                    selectedTileColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                                  ),
                                );
                              },
                            );
                          },
                        );
                      },
                      loading: () => const Center(child: CircularProgressIndicator()),
                      error: (e, _) => Center(child: Text('Error: $e')),
                    ),
                  ),
                ],
              ),
            ),
            if (fabPosition != null && !_isSelectionMode)
              Positioned(
                left: fabPosition!.dx,
                top: fabPosition!.dy,
                child: GestureDetector(
                  onPanStart: (_) {
                    setState(() => isDragging = true);
                  },
                  onPanUpdate: (details) {
                    setState(() {
                      fabPosition = Offset(
                        (fabPosition!.dx + details.delta.dx)
                            .clamp(sideMargin, screenWidth - fabSize - sideMargin),
                        (fabPosition!.dy + details.delta.dy)
                            .clamp(topMargin, screenHeight - fabSize - bottomMargin - mediaQuery.padding.bottom),
                      );
                    });
                  },
                  onPanEnd: (_) {
                    setState(() => isDragging = false);
                  },
                  child: FloatingActionButton(
                    onPressed: () => _showNewChatDialog(context, ref),
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    tooltip: 'Start new chat',
                    elevation: isDragging ? 12.0 : 6.0,
                    child: const Icon(Icons.add),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}