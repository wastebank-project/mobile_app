import 'package:flutter/material.dart';
import 'package:waste_app/presentation/widgets/bottom_navbar_item.dart';

class BottomNavbar extends StatelessWidget {
  final List<BottomNavbarItem> items;
  final void Function(int index) onTap;
  final int selectedIndex;
  final double iconSize;

  const BottomNavbar(
      {super.key,
      required this.items,
      required this.onTap,
      required this.selectedIndex,
      required this.iconSize});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 60,
        decoration: BoxDecoration(color: Colors.green.shade100),
        child: Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: items
                  .map((e) => GestureDetector(
                        onTap: () => onTap(e.index),
                        child: e,
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}








// decoration: BoxDecoration(
        //   color: Color(0xffff222),
        //   // borderRadius: const BorderRadius.only(
        //   //     topLeft: Radius.circular(35), topRight: Radius.circular(35)),
        //   boxShadow: [
        //     BoxShadow(
        //       color: Colors.black.withOpacity(0.2),
        //       // spreadRadius: 0,
        //       blurRadius: 20,
        //     )
        //   ],
        // ),
