import 'package:flutter/material.dart';

class BottomNavbarItem extends StatelessWidget {
  final int index;
  final bool isSelected;
  final String title;
  final String image;
  final String selectedImage;

  const BottomNavbarItem(
      {super.key,
      required this.index,
      required this.isSelected,
      required this.title,
      required this.image,
      required this.selectedImage});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 35,
          height: 35,
          child: Image.asset(isSelected ? selectedImage : image),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          title,
          style: TextStyle(
              fontSize: 12, fontWeight: FontWeight.w500, color: Colors.white),
        )
      ],
    );
  }
}
