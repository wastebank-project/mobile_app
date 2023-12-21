import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class WelcomingPage extends StatelessWidget {
  const WelcomingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 70),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(height: 150),
            SvgPicture.asset("assets/svg/log-reg.svg"),
            SizedBox(height: 60),
            const Center(
              child: Column(
                children: [
                  Text(
                    "WasteApp",
                    style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF7FB77E)),
                  ),
                  SizedBox(height: 5),
                  Text(
                      "Waste Bank Administration App"
                  ),
                ],
              ),
            ),
            SizedBox(height: 40),
            TextButton(
              onPressed: (){
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(const Color(0xFF7FB77E)),
                shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                ),
              ),
              child: const Text(
                  "Create New Account",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w600
                  )
              ),
            ),
            SizedBox(height: 10),
            TextButton(
              onPressed: (){
              },
              style: ButtonStyle(
                side: MaterialStateProperty.all(
                    const BorderSide(
                        color: Color(0xFF7FB77E),
                        width: 2.5
                    )
                ),
                shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    )
                ),
              ),
              child: const Text(
                  "I Have Account",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w600
                  )
              ),
            ),
          ],
        ),
      )
    );
  }
}
