import 'package:flutter/material.dart';
import 'package:fulleconomymileagetracker/Screens/HomeScreen.dart';
import 'package:google_fonts/google_fonts.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {

  void initState() {
    super.initState();
    // Start timer when widget initializes
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const Homescreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Text(
              "TS",
              style: GoogleFonts.playfairDisplay(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 40
              )
            ),
          ),
        ],
      ),
    );
  }
}