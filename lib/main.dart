import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'features/presentation/pages/login/login_screen.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
   WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: "assets/env/.env");

  runApp(
    const ProviderScope( 
      child: MyApp(),
    ),
  );
  
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.interTextTheme(Theme.of(context).textTheme),
      ),
      home: LoginScreen(),
    );
  }
}
