import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import '../models/weather_forecast.dart';
import '../repositories/weather_repository.dart';
import 'weather_event.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

// Example of checking network connectivity
Future<bool> isConnected() async {
  final connectivityResult = await Connectivity().checkConnectivity();
  return connectivityResult != ConnectivityResult.none;
}

class WeatherBloc extends HydratedBloc<WeatherEvent, List<WeatherForecast>> {
  final WeatherRepository repository;

  WeatherBloc(this.repository) : super([]) {
    on<FetchWeather>(_onFetchWeather);
  }

  void _onFetchWeather(
      FetchWeather event, Emitter<List<WeatherForecast>> emit) async {
    final connected = await isConnected();
    if (connected) {
      try {
        final forecasts =
            await repository.getWeatherForecast(event.lat, event.lon);
        emit(forecasts);
      } catch (e) {
        print('Error fetching weather data: $e');
        emit(state); // Emit cached data if there's an error
      }
    } else {
      print('No network connection');
      emit(state); // Emit cached data if offline
    }
  }

  @override
  List<WeatherForecast>? fromJson(Map<String, dynamic> json) {
    final List<dynamic>? forecastsJson = json['forecasts'] as List<dynamic>?;
    if (forecastsJson != null) {
      return forecastsJson
          .map((json) => WeatherForecast.fromJson(json as Map<String, dynamic>))
          .toList();
    }
    return [];
  }

  @override
  Map<String, dynamic>? toJson(List<WeatherForecast> state) {
    return {
      'forecasts': state.map((forecast) => forecast.toJson()).toList(),
    };
  }
}
