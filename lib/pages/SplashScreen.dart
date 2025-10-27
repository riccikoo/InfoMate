import 'dart:async';
import 'package:flutter/material.dart';
import 'DashboardPage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const DashboardPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF37353E),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo
            Image.asset('assets/logo.png', width: 150),
            const SizedBox(height: 20),
            
            // App Name
            const Text(
              'InfoMate',
              style: TextStyle(
                color: Color(0xFFD3DAD9),
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            
            // Tagline
            const Text(
              'Everything about you',
              style: TextStyle(
                color: Color(0xFFD3DAD9),
                fontSize: 18,
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 30),
            Column(
              children: [
                const Text(
                  'Developed by:',
                  style: TextStyle(
                    color: Color(0xFFD3DAD9),
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                const SizedBox(height: 10),
                _buildDeveloperCard('Rico Fadli Alfiansyah', '152023090'),
              ],
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildDeveloperCard(String name, String nim) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF44444E),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            name,
            style: const TextStyle(
              color: Color(0xFFD3DAD9),
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            '- $nim',
            style: const TextStyle(
              color: Color(0xFFA0A5A9),
              fontSize: 14,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }
}