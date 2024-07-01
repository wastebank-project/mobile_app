import 'package:flutter/material.dart';

class FloatingIconButton extends StatelessWidget {
  final IconData iconData;
  final Function() onPressed;
  final double iconSize;
  final Color color;

  const FloatingIconButton({
    super.key,
    required this.iconData,
    required this.onPressed,
    required this.color,
    required this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding:
            const EdgeInsets.all(10), // Adjust padding to control button size
        backgroundColor: color,
        elevation: 15, // Add shadow
        shadowColor:
            Colors.black.withOpacity(1), // Customize shadow color if needed
      ),
      child: Icon(
        iconData,
        size: iconSize, // Use the passed iconSize
        color: Colors.white, // Adjust color as needed
      ),
    );
  }
}
