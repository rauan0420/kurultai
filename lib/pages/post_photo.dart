import 'package:flutter/material.dart';

class Photo {
  final String imageProvider;

  Photo({required this.imageProvider});
}

class PhotoList extends StatelessWidget {
  final List<Photo> photos;

  PhotoList({
    required this.photos,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (var photo in photos)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.network(
                photo.imageProvider,
                width: 555,
                height: 555,
                fit: BoxFit.cover,
              ),
            ),
        ],
      ),
    );
  }
}

void main() {
  List<Photo> photos = [
    Photo(imageProvider: 'lib/images/facebook.png'),
    Photo(imageProvider: 'lib/images/facebook.png'),
    Photo(imageProvider: 'lib/images/facebook.png'),
  ];

  runApp(
    MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Photo List'),
        ),
        body: PhotoList(photos: photos),
      ),
    ),
  );
}
