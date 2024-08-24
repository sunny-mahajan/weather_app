import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, dynamic>> dummyWeatherData = [
    {
      "dt": 1724500800,
      "main": {
        "temp": 301.89,
      },
      "weather": [
        {
          "id": 800,
          "main": "Clear",
          "description": "clear sky",
          "icon": "01d"
        }
      ],
      "dt_txt": "2024-08-24 12:00:00"
    },
    {
      "dt": 1724511600,
      "main": {
        "temp": 303.09,
      },
      "weather": [
        {
          "id": 801,
          "main": "Clouds",
          "description": "few clouds",
          "icon": "02d"
        }
      ],
      "dt_txt": "2024-08-24 15:00:00"
    },
    {
      "dt": 1724522400,
      "main": {
        "temp": 300.81,
      },
      "weather": [
        {
          "id": 801,
          "main": "Clouds",
          "description": "few clouds",
          "icon": "02n"
        }
      ],
      "dt_txt": "2024-08-24 18:00:00"
    },
    {
      "dt": 1724533200,
      "main": {
        "temp": 297.35,
      },
      "weather": [
        {
          "id": 800,
          "main": "rain",
          "description": "rain",
          "icon": "01n"
        }
      ],
      "dt_txt": "2024-08-24 21:00:00"
    },
    {
      "dt": 1724544000,
      "main": {
        "temp": 295.46,
      },
      "weather": [
        {
          "id": 802,
          "main": "Clouds",
          "description": "scattered clouds",
          "icon": "03n"
        }
      ],
      "dt_txt": "2024-08-25 00:00:00"
    },
  ];

  Gradient getBackgroundGradient(String description) {
    switch (description.toLowerCase()) {
      case 'clear sky':
        return const LinearGradient(
          colors: [Color(0xFF87CEFA), Color(0xFFB0E0E6)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        );
      case 'few clouds':
        return const LinearGradient(
          colors: [Color(0xFF87CEEB), Color(0xFFB0C4DE)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        );
      case 'scattered clouds':
      case 'broken clouds':
        return const LinearGradient(
          colors: [Color(0xFF87CEEB), Color(0xFFB0E0E6)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        );
      case 'rain':
        return const LinearGradient(
          colors: [Color(0xFF778899), Color(0xFFB0C4DE)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        );
      case 'thunderstorm':
        return const LinearGradient(
          colors: [Color(0xFF4B0082), Color(0xFF483D8B)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        );
      default:
        return const LinearGradient(
          colors: [Color(0xFF87CEEB), Color(0xFFB0C4DE)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        );
    }
  }

  IconData getWeatherIcon(String description) {
    switch (description.toLowerCase()) {
      case 'clear sky':
        return Icons.wb_sunny;
      case 'few clouds':
      case 'scattered clouds':
      case 'broken clouds':
        return Icons.cloud;
      case 'rain':
        return Icons.grain;
      case 'thunderstorm':
        return Icons.bolt;
      default:
        return Icons.cloud_queue;
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentWeather = dummyWeatherData[3];
    final nextFourDays = dummyWeatherData.sublist(1, 5);
    print(dummyWeatherData);
    print(currentWeather);
    print(currentWeather['weather']);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: getBackgroundGradient(currentWeather['weather'][0]['description']),
        ),
        child: Column(
          children: [
            // Current Weather Section
            Expanded(
              flex: 55,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      getWeatherIcon(currentWeather['weather'][0]['description']),
                      size: 100,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '${(currentWeather['main']['temp'] - 273.15).toStringAsFixed(1)}°C',
                      style: const TextStyle(
                        fontSize: 48,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      currentWeather['weather'][0]['description'],
                      style: const TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Forecast Section
            Expanded(
              flex: 25,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 10),
                scrollDirection: Axis.horizontal,
                itemCount: nextFourDays.length,
                itemBuilder: (context, index) {
                  final weather = nextFourDays[index];
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          offset: const Offset(0, 5),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          DateFormat('MMM d').format(
                            DateTime.fromMillisecondsSinceEpoch(
                                weather['dt'] * 1000),
                          ),
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 5),
                        Icon(
                          getWeatherIcon(weather['weather'][0]['description']),
                          color: Colors.black,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          '${(weather['main']['temp'] - 273.15).toStringAsFixed(1)}°C',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
