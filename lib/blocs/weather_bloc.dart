import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import '../models/weather_forecast.dart';
import '../repositories/weather_repository.dart';
import 'weather_event.dart';

class WeatherBloc extends HydratedBloc<WeatherEvent, List<WeatherForecast>> {
  final WeatherRepository repository;

  WeatherBloc(this.repository) : super([]) {
    on<FetchWeather>(_onFetchWeather);
  }

  void _onFetchWeather(FetchWeather event, Emitter<List<WeatherForecast>> emit) async {
    try {
      final forecasts = await repository.getWeatherForecast(event.lat, event.lon);
      emit(forecasts);
    } catch (e) {
      // Handle the error properly, e.g., log it or display a message
      emit(state); // Retain the current state if there's an error
    }
  }

  @override
  List<WeatherForecast>? fromJson(Map<String, dynamic> json) {
    final List<dynamic>? forecastsJson = json['forecasts'] as List<dynamic>?;
    if (forecastsJson != null) {
      return forecastsJson.map((json) => WeatherForecast.fromJson(json as Map<String, dynamic>)).toList();
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
