import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meals_app/screens/tabs.dart';

void main() {
  runApp(
    ProviderScope(
      child: MaterialApp(
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 131, 57, 0),
          ),
          textTheme: GoogleFonts.latoTextTheme(),
        ),
        home: const TabScreen(),
      ),
    ),
  );
}
