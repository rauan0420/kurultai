import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import 'camera.dart';
import 'messages.dart';
import 'notifications.dart';
import 'profile.dart';
import 'signuppage.dart';

class Home extends StatefulWidget {
  const Home({Key? key});

  @override
  State<Home> createState() => _HomeState();
}

class Photo {
  final String imagePath;

  Photo({required this.imagePath});
}

final List<Photo> photos = [
  Photo(imagePath: 'lib/images/facebook.png'),
  Photo(imagePath: 'lib/images/facebook.png'),
  Photo(imagePath: 'lib/images/facebook.png'),
  // Add more photos if needed
];

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomePage(
      photos: photos,
    ),
    NotificationsPage(),
    CameraPage(),
    MessagesPage(),
    ProfilePage(),
  ];

  void signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null && user.isAnonymous) {
      return HomeScreen(
        photos: photos,
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color(0xFFE6EEFA),
          actions: [
            IconButton(
              onPressed: signOut,
              icon: Icon(
                Icons.logout,
                color: Colors.black,
              ),
            ),
          ],
        ),
        backgroundColor: Color(0xFFE6EEFA),
        bottomNavigationBar: CurvedNavigationBar(
          items: [
            Icon(
              Icons.home,
              color: Colors.white,
            ),
            Icon(
              Icons.notifications_rounded,
              color: Colors.white,
            ),
            Icon(
              Icons.add_circle_outline_rounded,
              color: Colors.white,
            ),
            Icon(
              Icons.message_rounded,
              color: Colors.white,
            ),
            Icon(
              Icons.person_sharp,
              color: Colors.white,
            ),
          ],
          color: Color.fromRGBO(87, 144, 223, 0.6),
          backgroundColor: Color(0xFFE6EEFA),
          buttonBackgroundColor: Color(0xFF5790DF),
          animationDuration: Duration(milliseconds: 300),
          animationCurve: Curves.bounceInOut,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
        body: _pages[_selectedIndex],
      );
    }
  }
}

class HomeScreen extends StatelessWidget {
  final List<Photo> photos;
  HomeScreen({Key? key, required this.photos});
  void signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFFE6EEFA),
        actions: [
          IconButton(
            onPressed: signOut,
            icon: Icon(
              Icons.logout,
              color: Colors.black,
            ),
          ),
        ],
      ),
      backgroundColor: Color(0xFFE6EEFA),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (var photo in photos)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  photo.imagePath,
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  final List<Photo> photos;

  HomePage({Key? key, required this.photos});

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      backgroundColor: Color(0xFFE6EEFA),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (var photo in photos)
                Container(
                  margin: EdgeInsets.all(12),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      photo.imagePath,
                      width: 200,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
