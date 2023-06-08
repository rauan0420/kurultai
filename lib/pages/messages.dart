import 'package:flutter/material.dart';

class MessagesPage extends StatefulWidget {
  const MessagesPage({Key? key}) : super(key: key);

  @override
  _MessagesPageState createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  late final TextEditingController _searchController;
  late final FocusNode _searchFocusNode;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _searchFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE6EEFA),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search messages',
                        border: OutlineInputBorder(),
                      ),
                      controller: _searchController,
                      focusNode: _searchFocusNode,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  const _Message(
                    senderName: 'John Doe',
                    messageText: 'Hey there, how are you?',
                    messageTime: '9:30 AM',
                  ),
                  const _Message(
                    senderName: 'Jane Smith',
                    messageText: 'Can you please send me that file?',
                    messageTime: '10:45 AM',
                  ),
                  const _Message(
                    senderName: 'Bob Johnson',
                    messageText: 'Thanks for your help yesterday!',
                    messageTime: '11:00 AM',
                  ),
                  const _Message(
                    senderName: 'Alice Lee',
                    messageText: 'Do you want to grab lunch today?',
                    messageTime: '12:30 PM',
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

class _Message extends StatelessWidget {
  const _Message({
    Key? key,
    required this.senderName,
    required this.messageText,
    required this.messageTime,
  }) : super(key: key);

  final String senderName;
  final String messageText;
  final String messageTime;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child: Text(senderName[0].toUpperCase()),
      ),
      title: Text(senderName),
      subtitle: Text(messageText),
      trailing: Text(messageTime),
    );
  }
}
