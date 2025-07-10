import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  // Mock message data
  static const List<Map<String, dynamic>> mockMessages = [
    {'text': 'Hey, how’s it going?', 'isSent': false, 'timestamp': '10:30 AM'},
    {'text': 'Pretty good, you?', 'isSent': true, 'timestamp': '10:32 AM'},
    {'text': 'Just chilling. Wanna meet up?', 'isSent': false, 'timestamp': '10:35 AM'},
    {'text': 'Sure, when?', 'isSent': true, 'timestamp': '10:36 AM'},
    {'text': 'How about 3 PM?', 'isSent': false, 'timestamp': '10:38 AM'},
    {'text': 'Works for me!', 'isSent': true, 'timestamp': '10:40 AM'},
    {'text': 'Hey, how’s it going?', 'isSent': false, 'timestamp': '10:30 AM'},
    {'text': 'Pretty good, you?', 'isSent': true, 'timestamp': '10:32 AM'},
    {'text': 'Just chilling. Wanna meet up?', 'isSent': false, 'timestamp': '10:35 AM'},
    {'text': 'Sure, when?', 'isSent': true, 'timestamp': '10:36 AM'},
    {'text': 'How about 3 PM?', 'isSent': false, 'timestamp': '10:38 AM'},
    {'text': 'Works for me!', 'isSent': true, 'timestamp': '10:40 AM'},
    {'text': 'Hey, how’s it going?', 'isSent': false, 'timestamp': '10:30 AM'},
    {'text': 'Pretty good, you?', 'isSent': true, 'timestamp': '10:32 AM'},
    {'text': 'Just chilling. Wanna meet up?', 'isSent': false, 'timestamp': '10:35 AM'},
    {'text': 'Sure, when?', 'isSent': true, 'timestamp': '10:36 AM'},
    {'text': 'How about 3 PM?', 'isSent': false, 'timestamp': '10:38 AM'},
    {'text': 'Works for me!', 'isSent': true, 'timestamp': '10:40 AM'},
  ];

  @override
  Widget build(BuildContext context) {
    const partnerName = 'Alice'; // Mock partner name
    const userName = 'User'; // Mock user name
    final messageController = TextEditingController();

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Top row with back button, profile picture, partner name, and dropdown
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context); // Back to home
                    },
                  ),
                  const SizedBox(width: 8.0),
                  CircleAvatar(
                    radius: 20.0,
                    child: Text(
                      partnerName.isNotEmpty ? partnerName[0].toUpperCase() : '?',
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(width: 12.0),
                  Expanded(
                    child: Text(
                      partnerName,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.more_vert),
                    onPressed: () {
                      debugPrint('Dropdown tapped'); // Placeholder for dropdown
                    },
                  ),
                ],
              ),
            ),
            // Message area
            Expanded(
              child: ListView.builder(
                reverse: true, // Latest message at bottom
                itemCount: mockMessages.length,
                itemBuilder: (context, index) {
                  final message = mockMessages[index];
                  final isSent = message['isSent'] as bool;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                    child: Row(
                      mainAxisAlignment:
                      isSent ? MainAxisAlignment.end : MainAxisAlignment.start,
                      children: [
                        if (!isSent) ...[
                          CircleAvatar(
                            radius: 16.0,
                            child: Text(
                              partnerName.isNotEmpty ? partnerName[0].toUpperCase() : '?',
                              style: const TextStyle(fontSize: 12),
                            ),
                          ),
                          const SizedBox(width: 8.0),
                        ],
                        Flexible(
                          child: Container(
                            padding: const EdgeInsets.all(12.0),
                            decoration: BoxDecoration(
                              color: isSent
                                  ? Theme.of(context).colorScheme.primary.withOpacity(0.8)
                                  : Colors.grey[300],
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Text(message['text'] as String),
                          ),
                        ),
                        if (isSent) ...[
                          const SizedBox(width: 8.0),
                          CircleAvatar(
                            radius: 16.0,
                            child: Text(
                              userName.isNotEmpty ? userName[0].toUpperCase() : '?',
                              style: const TextStyle(fontSize: 12),
                            ),
                          ),
                        ],
                      ],
                    ),
                  );
                },
              ),
            ),
            // Message input
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
                      onSubmitted: (value) {
                        if (value.isNotEmpty) {
                          debugPrint('Sent message: $value');
                          messageController.clear();
                        }
                      },
                      onTapOutside: (_) {
                        FocusScope.of(context).unfocus();
                      },
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  PopupMenuButton<String>(
                    icon: const Icon(Icons.attach_file),
                    onSelected: (value) {
                      debugPrint('Selected media: $value');
                    },
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