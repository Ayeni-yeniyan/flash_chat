import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

import '../components/custom_text_button.dart';
import 'login_screen.dart';
import 'registration_screen.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'WelcomeScreen';

  const WelcomeScreen({super.key});
  @override
  WelcomeScreenState createState() => WelcomeScreenState();
}

class WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation animation;
  late Animation opaqueAnimation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
    opaqueAnimation = Tween(begin: 0.0, end: 1.0).animate(animationController);
    animation = ColorTween(begin: Colors.grey, end: Colors.white)
        .animate(animationController);
    animationController.forward();
    animation.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'tag1',
                  child: SizedBox(
                    height: 60.0,
                    child: Image.asset('assets/images/logo.png'),
                  ),
                ),
                DefaultTextStyle(
                  style: const TextStyle(
                      fontSize: 45.0,
                      fontWeight: FontWeight.w900,
                      color: Colors.black),
                  child: AnimatedTextKit(
                    isRepeatingAnimation: true,
                    repeatForever: true,
                    animatedTexts: [
                      TypewriterAnimatedText('Flash Chat',
                          speed: const Duration(milliseconds: 150),
                          curve: Curves.bounceIn),
                    ],
                    onTap: () {
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 48.0),
            CustomTextButton(
              buttoncolor: Colors.lightBlueAccent,
              name: 'Log in',
              onTap: () {
                Navigator.pushNamed(context, LoginScreen.id);
              },
            ),
            const SizedBox(height: 30.0),
            CustomTextButton(
              name: 'Register',
              onTap: () {
                Navigator.pushNamed(context, RegistrationScreen.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}
