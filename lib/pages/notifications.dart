// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
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
            Container(
              padding: EdgeInsets.all(8.0),
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
                  _NotificationItem(
                    message: 'John Doe has subscribed to you',
                    time: '9:30 AM',
                    icon: Icons.supervisor_account_rounded,
                  ),
                  _NotificationItem(
                    message: 'Jane Smith liked your post.',
                    time: '10:45 AM',
                    icon: FontAwesomeIcons.solidHeart,
                  ),
                  _NotificationItem(
                    message: 'Bob Johnson liked your post.',
                    time: '11:00 AM',
                    icon: FontAwesomeIcons.solidHeart,
                  ),
                  _NotificationItem(
                    message: 'Alice Lee has subscribed to you',
                    time: '12:30 PM',
                    icon: Icons.supervisor_account_rounded,
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

class _NotificationItem extends StatelessWidget {
  const _NotificationItem({
    Key? key,
    required this.message,
    required this.time,
    required this.icon,
  }) : super(key: key);

  final String message;
  final String time;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(message),
      subtitle: Text(time),
    );
  }
}
