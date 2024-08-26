import 'package:flutter/material.dart';

class APPUtils {

  // Method to get background gradient based on weather description
  static Gradient getBackgroundGradient(String description) {
    final desc = description.toLowerCase();

    if (desc.contains('clear sky')) {
      return const LinearGradient(
        colors: [Color(0xFF87CEFA), Color(0xFFB0E0E6)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      );
    } else if (desc.contains('few clouds') ||
        desc.contains('scattered clouds') ||
        desc.contains('broken clouds')) {
      return const LinearGradient(
        colors: [Color(0xFF87CEEB), Color(0xFFB0E0E6)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      );
    } else if (desc.contains('shower rain') || desc.contains('rain')) {
      return const LinearGradient(
        colors: [Color(0xFF778899), Color(0xFFB0C4DE)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      );
    } else if (desc.contains('thunderstorm')) {
      return const LinearGradient(
        colors: [Color(0xFF4B0082), Color(0xFF483D8B)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      );
    } else if (desc.contains('snow')) {
      return const LinearGradient(
        colors: [Color(0xFFffffff), Color(0xFFf0f8ff)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      );
    } else if (desc.contains('mist') || desc.contains('fog')) {
      return const LinearGradient(
        colors: [Color(0xFFb0e0e6), Color(0xFFd3d3d3)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      );
    } else if (desc.contains('dust')) {
      return const LinearGradient(
        colors: [Color(0xFFf5deb3), Color(0xFFd2b48c)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      );
    } else {
      return const LinearGradient(
        colors: [Color(0xFF87CEEB), Color(0xFFB0C4DE)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      );
    }
  }

  // Method to get weather icon based on weather description
  static IconData getWeatherIcon(String description) {
    final desc = description.toLowerCase();

    if (desc.contains('clear sky')) {
      return Icons.wb_sunny;
    } else if (desc.contains('few clouds') ||
        desc.contains('scattered clouds') ||
        desc.contains('broken clouds')) {
      return Icons.cloud;
    } else if (desc.contains('shower rain') || desc.contains('rain')) {
      return Icons.grain;
    } else if (desc.contains('thunderstorm')) {
      return Icons.bolt;
    } else if (desc.contains('snow')) {
      return Icons.ac_unit;
    } else if (desc.contains('mist') || desc.contains('fog')) {
      return Icons.foggy;
    } else if (desc.contains('dust')) {
      return Icons.cloud;
    } else {
      return Icons.cloud_queue;
    }
  }
}
