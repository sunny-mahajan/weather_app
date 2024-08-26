// ignore_for_file: use_build_context_synchronously

import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/blocs/weather_event.dart';
import 'package:weather_app/utils/app_utils.dart';
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
    try {
      Position position = await _locationService.getCurrentLocation();

      BlocProvider.of<WeatherBloc>(context)
          .add(FetchWeather(position.latitude, position.longitude));

    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to fetch location.';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
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
                      gradient: APPUtils.getBackgroundGradient(
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
                          child: CurrentWeatherWidget(currentWeather: currentWeather),
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
                                return ForecastCardWidget(weather: weather);
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

class CurrentWeatherWidget extends StatelessWidget {
  final WeatherForecast currentWeather;

  const CurrentWeatherWidget({
    Key? key,
    required this.currentWeather,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            APPUtils.getWeatherIcon(
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
          Text(
            currentWeather.weather.isNotEmpty
                ? DateFormat('MMM d').format(
                    DateTime.fromMillisecondsSinceEpoch(
                      currentWeather.dt * 1000,
                    ),
                  )
                : '-',
            style: const TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class ForecastCardWidget extends StatelessWidget {
  final WeatherForecast weather;

  const ForecastCardWidget({Key? key, required this.weather}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            APPUtils.getWeatherIcon(weather
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
  }
}
