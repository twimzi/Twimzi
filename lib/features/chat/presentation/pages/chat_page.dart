import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chats'),
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const CircleAvatar(
              child: Icon(Icons.store),
            ),
            title: Text('Business ${index + 1}'),
            subtitle: const Text('Last message...'),
            trailing: const Text('10:30 AM'),
          );
        },
      ),
    );
  }
}