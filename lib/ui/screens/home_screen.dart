// ignore_for_file: use_build_context_synchronously

import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/blocs/weather_event.dart';
import '../../blocs/weather_bloc.dart';
import '../../models/weather_forecast.dart';
import '../../services/location_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final LocationService _locationService = LocationService();
  bool _isLoading = true;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _fetchWeatherData();
  }

  Future<void> _fetchWeatherData() async {
    print("data");
    try {
      Position position = await _locationService.getCurrentLocation();
      print(position);
      BlocProvider.of<WeatherBloc>(context)
          .add(FetchWeather(position.latitude, position.longitude));
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      print(e);
      setState(() {
        _isLoading = false;
        _errorMessage = 'Failed to fetch location.';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Gradient getBackgroundGradient(String description) {
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

  IconData getWeatherIcon(String description) {
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

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, List<WeatherForecast>>(
      builder: (context, forecasts) {
        if (_isLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (_errorMessage.isNotEmpty) {
          return Scaffold(
            body: Center(child: Text(_errorMessage)),
          );
        }

        final currentWeather = forecasts.isNotEmpty
            ? forecasts.first
            : WeatherForecast((b) => b
              ..dt = 0
              ..main.update((b) => b..temp = 0)
              ..weather = ListBuilder<Weather>([
                Weather((b) => b..description = '-'),
              ])
              ..dtTxt = '-');

        final nextFourDays = forecasts.length > 1 ? forecasts.sublist(1) : [];

        return Scaffold(
          body: RefreshIndicator(
            color: Colors.white,
            backgroundColor: Colors.blue,
            onRefresh: () async {
              await Future.delayed(const Duration(seconds: 1));
              _fetchWeatherData();
            },
            child: CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: getBackgroundGradient(
                        currentWeather.weather.isNotEmpty
                            ? currentWeather.weather.first.description
                            : '-',
                      ),
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
                                  getWeatherIcon(
                                    currentWeather.weather.isNotEmpty
                                        ? currentWeather
                                            .weather.first.description
                                        : '-',
                                  ),
                                  size: 100,
                                  color: Colors.white,
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  '${(currentWeather.main.temp ?? 0).toStringAsFixed(1)}°C',
                                  style: const TextStyle(
                                    fontSize: 48,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  currentWeather.weather.isNotEmpty
                                      ? currentWeather.weather.first.description
                                      : '-',
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
                        Container(
                          padding: const EdgeInsets.only(
                              left: 10,
                              right: 10,
                              bottom: 10), // Adjust the margin as needed

                          child: SizedBox(
                            height: 150, // Adjust this value as needed
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: nextFourDays.length,
                              itemBuilder: (context, index) {
                                final weather = nextFourDays[index];
                                return Container(
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10, bottom: 20),
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
                                            weather.dt * 1000,
                                          ),
                                        ),
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                      const SizedBox(height: 5),
                                      Icon(
                                        getWeatherIcon(weather
                                                .weather.isNotEmpty
                                            ? weather.weather.first.description
                                            : '-'),
                                        color: Colors.black,
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        '${(weather.main.temp).toStringAsFixed(1)}°C',
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
