import 'package:flutter/material.dart';

class Square extends StatelessWidget {
  final String imagePath;
  final void Function()? onTap;
  const Square({super.key, required this.imagePath, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(15)),
        child: Image.asset(
          imagePath,
          height: 48,
          width: 48,
        ),
      ),
    );
  }
}
