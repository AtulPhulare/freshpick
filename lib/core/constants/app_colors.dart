import 'package:flutter/material.dart';

class AppColors {
  // --- Brand Colors ---
  static const Color primary = Color(0xFF27AE60); // Fresh Leaf Green
  static const Color primaryLight = Color(0xFFE8F5E9); // Light Mint background
  static const Color accent = Color(0xFFFF8C00); // Ripe Orange (Great for CTAs)
  
  // --- Text & Neutral Colors ---
  static const Color textDark = Color(0xFF2D2D2D); // Deep Charcoal for readability
  static const Color textGrey = Color(0xFF757575); // Subtitles and hints
  
  static const Color background = Color(0xFFF9F9F9); // Off-white/Soft Grey
  static const Color white = Colors.white;

  // --- Functional Colors ---
  static const Color error = Color(0xFFE74C3C); // Tomato Red
  static const Color success = Color(0xFF2ECC71); 
  static const Color warning = Color(0xFFF1C40F); // Lemon Yellow

  // --- Fruit Category Specific (For Cards/Tags) ---
  // These are soft "pastel" versions to use as backgrounds for fruit images
  static const Color berryPastel = Color(0xFFFCE4EC); 
  static const Color citrusPastel = Color(0xFFFFF3E0);
  static const Color greenPastel = Color(0xFFF1F8E9);
  static const Color tropicalPastel = Color(0xFFFFFDE7);
}