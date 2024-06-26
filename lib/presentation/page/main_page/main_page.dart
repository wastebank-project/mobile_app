import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:waste_app/presentation/page/customers_page/customers_page.dart';
import 'package:waste_app/presentation/page/home_page/home_page.dart';
import 'package:waste_app/presentation/page/profile_page/profile_page.dart';
import 'package:waste_app/presentation/page/saving_page/saving_page_screen.dart';
import 'package:waste_app/presentation/page/waste_detection/waste_detection.dart';
import 'package:waste_app/presentation/widgets/bottom_navbar.dart';
import 'package:waste_app/presentation/widgets/bottom_navbar_item.dart';
import 'package:waste_app/presentation/widgets/floating_icon_button.dart';

class MainPage extends StatefulWidget {
  const MainPage({
    super.key,
    required this.username,
    required this.email,
  });
  final String username;
  final String email;

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
              const SavingPageScreen(),
              const WasteDetection(),
              const CustomersPage(),
              ProfilePage(
                username: widget.username,
                email: widget.email,
              )
            ],
          ),
          BottomNavbar(
            items: [
              BottomNavbarItem(
                  index: 0,
                  isSelected: selectedPage == 0,
                  title: 'Beranda',
                  image: 'assets/png/beranda_hitam.png',
                  selectedImage: 'assets/png/beranda.png'),
              BottomNavbarItem(
                index: 1,
                isSelected: selectedPage == 1,
                title: 'Tabung',
                image: 'assets/png/tabung_hitam.png',
                selectedImage: 'assets/png/tabung.png',
              ),
              BottomNavbarItem(
                index: 2,
                isSelected: selectedPage == 2,
                title: '        ',
                image: 'assets/png/beranda_hitam.png',
                selectedImage: 'assets/png/nasabah.png',
              ),
              BottomNavbarItem(
                  index: 3,
                  isSelected: selectedPage == 3,
                  title: 'Nasabah',
                  image: 'assets/png/nasabah_hitam.png',
                  selectedImage: 'assets/png/nasabah.png'),
              BottomNavbarItem(
                  index: 4,
                  isSelected: selectedPage == 4,
                  title: 'Profil',
                  image: 'assets/png/profil_hitam.png',
                  selectedImage: 'assets/png/profil.png'),
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
          Positioned(
            bottom: 10,
            left: (MediaQuery.of(context).size.width - 69) /
                2, // Calculation for horizontal centering
            child: FloatingIconButton(
              iconSize: 50, // Adjust icon size
              iconData: Icons.qr_code_scanner_rounded,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const WasteDetection(),
                    ));
              },
              color: const Color(0xff7ABA78),
            ),
          ),
        ],
      ),
    );
  }
}
