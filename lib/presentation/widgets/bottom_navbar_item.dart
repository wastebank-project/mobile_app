import 'package:flutter/material.dart';

class BottomNavbarItem extends StatelessWidget {
  final int index;
  final bool isSelected;
  final String title;
  final String image;
  final String selectedImage;

  const BottomNavbarItem({
    super.key,
    required this.index,
    required this.isSelected,
    required this.title,
    required this.image,
    required this.selectedImage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 40,
          height: 40,
          child: Image.asset(isSelected ? selectedImage : image),
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: Colors.green.shade900,
          ),
        ),
      ],
    );
  }
}
