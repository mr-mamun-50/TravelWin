import 'package:flutter/material.dart';
import 'package:user_flutter/constant.dart';
import 'package:user_flutter/views/driver/auth/login.dart';
import 'package:user_flutter/views/hotel/auth/login.dart';
import 'package:user_flutter/views/tourist_guide/auth/login.dart';
import 'package:user_flutter/views/user/auth/login.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const SizedBox(height: 30),
                const Text(
                  "TravelWin",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Image.asset(
                  'images/vectors/welcome.png',
                  height: 300,
                ),
                const SizedBox(height: 30),
                const Text(
                  "Sign in as_",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30),
                WelcomeBtn(
                  'Tourist',
                  () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const Login()),
                  ),
                ),
                const SizedBox(height: 15),
                WelcomeBtn(
                  'Tourist Guide',
                  () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const GuideLogin()),
                  ),
                ),
                const SizedBox(height: 15),
                WelcomeBtn(
                  'Hotel',
                  () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const HotelLogin()),
                  ),
                ),
                const SizedBox(height: 15),
                WelcomeBtn(
                  'Driver',
                  () => Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => const DriverLogin()),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
