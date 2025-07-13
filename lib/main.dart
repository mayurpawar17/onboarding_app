import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onboarding_app/providers/onboarding_provider.dart';
import 'package:onboarding_app/screens/onboarding_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    // MultiProvider(
    //   providers: [Provider(create: (_) => OnboardingProvider())],
    //   child: MyApp(),
    // ),
    ChangeNotifierProvider(create: (_) => OnboardingProvider(), child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(textTheme: GoogleFonts.poppinsTextTheme()),
      home: OnboardingScreen(),
    );
  }
}
