import 'package:flutter/material.dart';

class AppTextStyles {
  static Text heading(String text) => Text(
        text,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
      );

  static Text semiHeading(String text) => Text(
        text,
        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
      );

  static Text smallHeading(String text) => Text(
        text,
        style: const TextStyle(fontSize: 10),
      );
}