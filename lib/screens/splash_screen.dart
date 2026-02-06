import 'package:flutter/material.dart';
import '../screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Lógica del temporizador de 2 segundos
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF0F3045), Color(0xFF18667E)],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(flex: 2),
            Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                border: Border.all(color: Colors.white),
              ),
              child: const Center(
                child: Icon(Icons.remove_red_eye_outlined, size: 70, color: Color(0xFF29B6F6)),
              ),
            ),
            const SizedBox(height: 40),
            const Text(
              'OCEAN EYES',
              style: TextStyle(
                color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold, letterSpacing: 4.0
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Protegiendo nuestros océanos',
              style: TextStyle(color: Colors.white70, fontSize: 16, fontWeight: FontWeight.w300),
            ),
            const Spacer(flex: 2),
            const SizedBox(
              width: 40, height: 40,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF29B6F6)), strokeWidth: 3
              ),
            ),
            const SizedBox(height: 20),
            const Text('CARGANDO', style: TextStyle(color: Colors.white38, fontSize: 12, letterSpacing: 1.5)),
            const SizedBox(height: 30),
            Container(
              width: 150, height: 4,
              decoration: BoxDecoration(color: Colors.white12, borderRadius: BorderRadius.circular(2)),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  width: 50,
                  decoration: BoxDecoration(color: const Color(0xFF29B6F6), borderRadius: BorderRadius.circular(2)),
                ),
              ),
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}