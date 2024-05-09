import 'package:flutter/material.dart';
import 'package:frontend/modules/authentication/screens/auth_screen.dart';
import 'package:frontend/constants/global_variables.dart';
import 'package:lottie/lottie.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Stack(
        children: [
          _BackgroundAnimation(),
          _ContentOverlay(),
        ],
      ),
    );
  }
}

class _BackgroundAnimation extends StatelessWidget {
  const _BackgroundAnimation();

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      GlobalVariables.welcomeScreenAnimation,
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
    );
  }
}

class _ContentOverlay extends StatelessWidget {
  const _ContentOverlay();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0x99B388FF),
            Color(0x4DB388FF),
          ],
        ),
      ),
      child: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const _WelcomeAvatar(),
              const SizedBox(height: 20),
              const _WelcomeMessage(),
              const SizedBox(height: 40),
              _SignInButton(onPressed: () => _navigateToAuth(context)),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToAuth(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const AuthScreen()),
    );
  }
}

class _WelcomeAvatar extends StatelessWidget {
  const _WelcomeAvatar();

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.white,
      radius: 50,
      child: Image.asset(GlobalVariables.waiterImage, height: 80),
    );
  }
}

class _WelcomeMessage extends StatelessWidget {
  const _WelcomeMessage();

  @override
  Widget build(BuildContext context) {
    return const Text(
      'OrderEase',
      style: TextStyle(
        color: Colors.white,
        fontSize: 36,
        fontWeight: FontWeight.bold,
        fontFamily: 'Raleway',
        shadows: [
          Shadow(
            color: Colors.black45,
            offset: Offset(2, 2),
            blurRadius: 4,
          ),
        ],
      ),
    );
  }
}

class _SignInButton extends StatelessWidget {
  final VoidCallback onPressed;
  const _SignInButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: const Color(0xFF78008D),
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
      ),
      child: const Text(
        'Let\'s Indulge!',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontFamily: 'Raleway',
          fontSize: 18,
        ),
      ),
    );
  }
}
