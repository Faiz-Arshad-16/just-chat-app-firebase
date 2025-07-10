// import 'package:chat_app/core/routes/on_generate_route.dart';
// import 'package:flutter/material.dart';
//
// class HomePage extends StatelessWidget {
//   const HomePage({super.key});
//
//   // Mock chat data
//   static const List<Map<String, String>> mockChats = [
//     {'username': 'Alice', 'lastMessage': 'Hey, how are you?', 'timestamp': '10:30 AM'},
//     {'username': 'Bob', 'lastMessage': 'Let’s meet tomorrow', 'timestamp': '9:15 AM'},
//     {'username': 'Charlie', 'lastMessage': 'Check this out!', 'timestamp': 'Yesterday'},
//     {'username': 'Diana', 'lastMessage': 'Thanks for the update', 'timestamp': '2 days ago'},
//     {'username': 'Ali', 'lastMessage': 'Hey, how are you?', 'timestamp': '10:30 AM'},
//     {'username': 'Kamran', 'lastMessage': 'Let’s meet tomorrow', 'timestamp': '9:15 AM'},
//     {'username': 'Aziz Bhai', 'lastMessage': 'Check this out!', 'timestamp': 'Yesterday'},
//     {'username': 'Hassan', 'lastMessage': 'Thanks for the update', 'timestamp': '2 days ago'},
//     {'username': 'Mudassir', 'lastMessage': 'Hey, how are you?', 'timestamp': '10:30 AM'},
//     {'username': 'Haris', 'lastMessage': 'Let’s meet tomorrow', 'timestamp': '9:15 AM'},
//     {'username': 'Bilal', 'lastMessage': 'Check this out!', 'timestamp': 'Yesterday'},
//     {'username': 'Adnan', 'lastMessage': 'Thanks for the update', 'timestamp': '2 days ago'},
//   ];
//
//   // Show dialog to start a new chat
//   void _showNewChatDialog(BuildContext context) {
//     final emailController = TextEditingController();
//     final messageController = TextEditingController();
//
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: const Text('Start New Chat'),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               TextField(
//                 controller: emailController,
//                 keyboardType: TextInputType.emailAddress,
//                 decoration: InputDecoration(
//                   labelText: 'Partner\'s Email',
//                   hintText: 'Enter partner\'s email',
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8.0),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 16.0),
//               TextField(
//                 controller: messageController,
//                 maxLines: 3,
//                 decoration: InputDecoration(
//                   labelText: 'Message',
//                   hintText: 'Write your message',
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8.0),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context); // Close dialog
//               },
//               child: const Text('Cancel'),
//             ),
//             TextButton(
//               onPressed: () {
//                 // Simulate starting a chat
//                 debugPrint(
//                   'Starting chat with ${emailController.text}: ${messageController.text}',
//                 );
//                 Navigator.pop(context); // Close dialog
//               },
//               child: Text(
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
//     const mockUsername = 'User'; // Mock username for profile picture
//
//     return Scaffold(
//       floatingActionButton: FloatingActionButton(
//         onPressed: () => _showNewChatDialog(context),
//         backgroundColor: Theme.of(context).colorScheme.primary,
//         tooltip: 'Start new chat',
//         child: const Icon(Icons.add),
//       ),
//       body: SafeArea(
//         child: Column(
//           children: [
//             // Top row with profile picture and app name
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   GestureDetector(
//                     onTap: () {
//                       Navigator.pushNamed(context, PageConst.profile);
//                     },
//                     child: CircleAvatar(
//                       radius: 24.0,
//                       child: Text(
//                         mockUsername.isNotEmpty ? mockUsername[0].toUpperCase() : '?',
//                         style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
//                       ),
//                     ),
//                   ),
//                   Text(
//                     'Just Chat',
//                     style: TextStyle(
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold,
//                       color: Theme.of(context).colorScheme.primary,
//                     ),
//                   ),
//                   const SizedBox(width: 48.0), // Placeholder for symmetry
//                 ],
//               ),
//             ),
//             // Search bar
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16.0),
//               child: TextField(
//                 onChanged: (value) {
//                   debugPrint('Search query: $value'); // Simulate search
//                 },
//                 decoration: InputDecoration(
//                   hintText: 'Search chats',
//                   prefixIcon: const Icon(Icons.search),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8.0),
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 16.0),
//             // Chat list
//             Expanded(
//               child: ListView.builder(
//                 itemCount: mockChats.length,
//                 itemBuilder: (context, index) {
//                   final chat = mockChats[index];
//                   return ListTile(
//                     onTap: () {
//                       Navigator.pushNamed(context, PageConst.chat);
//                     },
//                     leading: CircleAvatar(
//                       radius: 24.0,
//                       child: Text(
//                         chat['username']!.isNotEmpty
//                             ? chat['username']![0].toUpperCase()
//                             : '?',
//                         style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                     title: Text(chat['username']!),
//                     subtitle: Text(
//                       chat['lastMessage']!,
//                       maxLines: 1,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                     trailing: Text(chat['timestamp']!),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

import '../../../../core/routes/on_generate_route.dart';
import '../../../../core/utils/time_stamp_utils.dart';
// to do
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  // Mock chat data with DateTime timestamps
  static final List<Map<String, dynamic>> mockChats = [
    {
      'username': 'Alice',
      'lastMessage': 'Hey, how are you?',
      'timestamp': DateTime.now().subtract(const Duration(minutes: 30)),
    },
    {
      'username': 'Bob',
      'lastMessage': 'Let’s meet tomorrow',
      'timestamp': DateTime.now().subtract(const Duration(days: 1)),
    },
    {
      'username': 'Charlie',
      'lastMessage': 'Check this out!',
      'timestamp': DateTime.now().subtract(const Duration(days: 3)),
    },
    {
      'username': 'Diana',
      'lastMessage': 'Thanks for the update',
      'timestamp': DateTime.now().subtract(const Duration(days: 15)),
    },
    {
      'username': 'Ali',
      'lastMessage': 'Hey, how are you?',
      'timestamp': DateTime.now().subtract(const Duration(minutes: 45)),
    },
    {
      'username': 'Kamran',
      'lastMessage': 'Let’s meet tomorrow',
      'timestamp': DateTime.now().subtract(const Duration(days: 2)),
    },
    {
      'username': 'Aziz Bhai',
      'lastMessage': 'Check this out!',
      'timestamp': DateTime.now().subtract(const Duration(days: 1)),
    },
    {
      'username': 'Hassan',
      'lastMessage': 'Thanks for the update',
      'timestamp': DateTime.now().subtract(const Duration(days: 5)),
    },
    {
      'username': 'Mudassir',
      'lastMessage': 'Hey, how are you?',
      'timestamp': DateTime.now().subtract(const Duration(minutes: 15)),
    },
    {
      'username': 'Haris',
      'lastMessage': 'Let’s meet tomorrow',
      'timestamp': DateTime.now().subtract(const Duration(days: 4)),
    },
    {
      'username': 'Bilal',
      'lastMessage': 'Check this out!',
      'timestamp': DateTime.now().subtract(const Duration(days: 1)),
    },
    {
      'username': 'Adnan',
      'lastMessage': 'Thanks for the update',
      'timestamp': DateTime(2025, 6, 1),
    },
  ]..sort((a, b) => b['timestamp'].compareTo(a['timestamp'])); // Sort newest first

  // FAB position
  Offset? fabPosition;
  bool isDragging = false;

  @override
  void initState() {
    super.initState();
    // Initialize FAB position after first frame
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
        debugPrint('FAB initialized at: $fabPosition');
      });
    });
  }

  // Show dialog to start a new chat
  void _showNewChatDialog(BuildContext context) {
    final emailController = TextEditingController();
    final messageController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Start New Chat'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Partner\'s Email',
                  hintText: 'Enter partner\'s email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: messageController,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: 'Message',
                  hintText: 'Write your message',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Simulate starting a chat
                debugPrint(
                  'Starting chat with ${emailController.text}: ${messageController.text}',
                );
                Navigator.pop(context); // Close dialog
              },
              child: Text(
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
    const mockUsername = 'User'; // Mock username for profile picture
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;
    const fabSize = 56.0; // Default FAB size
    const topMargin = 100.0; // Avoid top bar and search bar
    const bottomMargin = 20.0; // Avoid bottom safe area
    const sideMargin = 20.0; // Avoid screen edges

    return WillPopScope(
      onWillPop: () async {
        // Show confirmation dialog before exiting
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
        body: Stack(
          children: [
            SafeArea(
              child: Column(
                children: [
                  // Top row with profile picture and app name
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
                              mockUsername.isNotEmpty ? mockUsername[0].toUpperCase() : '?',
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
                        const SizedBox(width: 48.0), // Placeholder for symmetry
                      ],
                    ),
                  ),
                  // Search bar
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: TextField(
                      onChanged: (value) {
                        debugPrint('Search query: $value'); // Simulate search
                      },
                      decoration: InputDecoration(
                        hintText: 'Search chats',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  // Chat list
                  Expanded(
                    child: ListView.builder(
                      itemCount: mockChats.length,
                      itemBuilder: (context, index) {
                        final chat = mockChats[index];
                        return ListTile(
                          onTap: () {
                            Navigator.pushNamed(context, PageConst.chat);
                          },
                          leading: CircleAvatar(
                            radius: 24.0,
                            child: Text(
                              chat['username']!.isNotEmpty
                                  ? chat['username']![0].toUpperCase()
                                  : '?',
                              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                          title: Text(chat['username']!),
                          subtitle: Text(
                            chat['lastMessage']!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          trailing: Text(
                            TimestampUtils.formatTimestamp(chat['timestamp']),
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
                              fontSize: 12,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            // Draggable FAB (only render if fabPosition is initialized)
            if (fabPosition != null)
              Positioned(
                left: fabPosition!.dx,
                top: fabPosition!.dy,
                child: GestureDetector(
                  onPanStart: (_) {
                    setState(() {
                      isDragging = true;
                      debugPrint('FAB drag started');
                    });
                  },
                  onPanUpdate: (details) {
                    setState(() {
                      fabPosition = Offset(
                        (fabPosition!.dx + details.delta.dx).clamp(sideMargin, screenWidth - fabSize - sideMargin),
                        (fabPosition!.dy + details.delta.dy).clamp(topMargin, screenHeight - fabSize - bottomMargin - mediaQuery.padding.bottom),
                      );
                      debugPrint('FAB moved to: $fabPosition');
                    });
                  },
                  onPanEnd: (_) {
                    setState(() {
                      isDragging = false;
                      debugPrint('FAB drag ended');
                    });
                  },
                  child: FloatingActionButton(
                    onPressed: () => _showNewChatDialog(context),
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    tooltip: 'Start new chat',
                    elevation: isDragging ? 12.0 : 6.0, // Increase elevation when dragging
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