import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:waste_app/domain/authentication.dart';
import 'package:waste_app/presentation/page/login_page/login_screen.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key, required this.username});
  final String username;

  Future<void> _logout(BuildContext context) async {
    EasyLoading.show(status: 'Logging out...');
    try {
      await Authentication().logoutUser();
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
        (route) => false,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to log out: $e')),
      );
    }
    EasyLoading.dismiss();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Image.asset(
              'assets/png/save1.png',
              opacity: const AlwaysStoppedAnimation(.6),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 100, 25, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(
                    height: 100,
                  ),
                  Center(
                    child: Image.asset('assets/png/profile_picture.png'),
                  ),
                  Center(
                    child: Text(
                      username,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const Center(
                    child: Text(
                      'email',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    height: 50,
                    child: OutlinedButton.icon(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(const Color(0xffF6F4BD)),
                        side: MaterialStateProperty.all(
                          const BorderSide(
                            color: Color(0xffF6F4BD),
                          ),
                        ),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      onPressed: () {},
                      icon: const Icon(
                        Icons.system_update_tv_rounded,
                        color: Color(0xff0A6847),
                      ),
                      label: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Edit Profil',
                            style: TextStyle(
                                color: Color(0xff0A6847),
                                fontSize: 14,
                                fontWeight: FontWeight.w700),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Color(0xff0A6847),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 50,
                    child: OutlinedButton.icon(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(const Color(0xffF6F4BD)),
                        side: MaterialStateProperty.all(
                          const BorderSide(
                            color: Color(0xffF6F4BD),
                          ),
                        ),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      onPressed: () {},
                      icon: const Icon(
                        Icons.system_update_tv_rounded,
                        color: Color(0xff0A6847),
                      ),
                      label: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Ubah Password',
                            style: TextStyle(
                                color: Color(0xff0A6847),
                                fontSize: 14,
                                fontWeight: FontWeight.w700),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Color(0xff0A6847),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 50,
                    child: OutlinedButton.icon(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(const Color(0xffF6F4BD)),
                        side: MaterialStateProperty.all(
                          const BorderSide(
                            color: Color(0xffF6F4BD),
                          ),
                        ),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      onPressed: () {},
                      icon: const Icon(
                        Icons.system_update_tv_rounded,
                        color: Color(0xff0A6847),
                      ),
                      label: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Tentang Aplikasi',
                            style: TextStyle(
                                color: Color(0xff0A6847),
                                fontSize: 14,
                                fontWeight: FontWeight.w700),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Color(0xff0A6847),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 100),
                  SizedBox(
                    width: 150,
                    child: TextButton(
                      onPressed: () {
                        _logout(context);
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          const Color(0xffD96B78),
                        ),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      child: const Text(
                        'Keluar',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
