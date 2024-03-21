import 'package:flutter/material.dart';
import 'package:waste_app/presentation/page/customers_page/customers_page.dart';
import 'package:waste_app/presentation/page/home_page/home_page.dart';
import 'package:waste_app/presentation/page/waste_detection/waste_detection.dart';
import 'package:waste_app/presentation/widgets/bottom_navbar.dart';
import 'package:waste_app/presentation/widgets/bottom_navbar_item.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

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
            controller: pageController,
            onPageChanged: (value) => setState(() {
              selectedPage = value;
            }),
            children: const [
              Center(
                child: HomePage(),
              ),
              Center(
                child: WasteDetection(),
              ),
              Center(
                child: CustomersPage(),
              )
            ],
          ),
          BottomNavbar(
              items: [
                BottomNavbarItem(
                    index: 0,
                    isSelected: selectedPage == 0,
                    title: 'Home',
                    image: 'assets/png/home.png',
                    selectedImage: 'assets/png/home.png'),
                BottomNavbarItem(
                    index: 1,
                    isSelected: selectedPage == 1,
                    title: 'Pindai',
                    image: 'assets/png/scan.png',
                    selectedImage: 'assets/png/scan.png'),
                BottomNavbarItem(
                    index: 2,
                    isSelected: selectedPage == 2,
                    title: 'Nasabah',
                    image: 'assets/png/customer.png',
                    selectedImage: 'assets/png/customer.png')
              ],
              onTap: (Index) {
                selectedPage = Index;
                pageController.animateToPage(selectedPage,
                    duration: Duration(microseconds: 100),
                    curve: Curves.easeInOut);
              },
              selectedIndex: 0)
        ],
      ),
    );
  }
}
