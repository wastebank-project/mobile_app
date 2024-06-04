import 'package:flutter/material.dart';
import 'package:waste_app/presentation/page/customers_page/customers_page.dart';
import 'package:waste_app/presentation/page/home_page/home_page.dart';
import 'package:waste_app/presentation/page/waste_detection/waste_detection.dart';
import 'package:waste_app/presentation/widgets/bottom_navbar.dart';
import 'package:waste_app/presentation/widgets/bottom_navbar_item.dart';
import 'package:waste_app/presentation/widgets/floating_action_button.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key, required this.username});
  final String username;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  PageController pageController = PageController();
  int selectedPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: pageController,
            onPageChanged: (value) => setState(() {
              selectedPage = value;
            }),
            children: [
              HomePage(username: widget.username),
              const WasteDetection(),
              const CustomersPage(),
            ],
          ),
          BottomNavbar(
            items: [
              BottomNavbarItem(
                  index: 0,
                  isSelected: selectedPage == 0,
                  title: 'Beranda',
                  image: 'assets/png/beranda.png',
                  selectedImage: 'assets/png/beranda_selected.png'),
              BottomNavbarItem(
                index: 1,
                isSelected: selectedPage == 1,
                title: 'Tabung',
                image: 'assets/png/tabung.png',
                selectedImage: 'assets/png/tabung_selected.png',
              ),
              BottomNavbarItem(
                index: 2,
                isSelected: selectedPage == 2,
                title: '        ',
                image: 'assets/png/beranda.png',
                selectedImage: 'assets/png/nasabah_selected.png',
              ),
              BottomNavbarItem(
                  index: 3,
                  isSelected: selectedPage == 3,
                  title: 'Nasabah',
                  image: 'assets/png/nasabah.png',
                  selectedImage: 'assets/png/nasabah_selected.png'),
              BottomNavbarItem(
                  index: 4,
                  isSelected: selectedPage == 4,
                  title: 'Profil',
                  image: 'assets/png/profil.png',
                  selectedImage: 'assets/png/profil_selected.png'),
            ],
            onTap: (Index) {
              selectedPage = Index;
              pageController.animateToPage(selectedPage,
                  duration: const Duration(microseconds: 100),
                  curve: Curves.bounceIn);
            },
            selectedIndex: 0,
            iconSize: 100,
          ),
          FloatingIconButton(
            iconSize: 40, // Adjust icon size
            iconData: Icons.qr_code_scanner_rounded,
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const WasteDetection(),
                  ));
            },
            color: const Color(0xffF3CA52),
          ),
        ],
      ),
    );
  }
}
