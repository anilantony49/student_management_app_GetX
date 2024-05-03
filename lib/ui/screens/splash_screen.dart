import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:database_student/ui/screens/home_screen.dart';
import 'package:flutter/material.dart';

import 'widgets/constants.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      duration: 4000,
      splash: const CircleAvatar(
        radius: 70,
        backgroundColor: kColor,
        backgroundImage: AssetImage(
          'assets/images/student image.jpg',
        ),
        //   child: CircleAvatar(

        //   radius: 40,

        // ),
      ),
      nextScreen:  const HomeScreen(),
      splashTransition: SplashTransition.rotationTransition,
      backgroundColor: Colors.black,
    );
  }
}
