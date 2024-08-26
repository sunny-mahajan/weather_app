import 'package:flutter/material.dart';
import 'package:built_collection/built_collection.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_app/blocs/weather_bloc.dart';
import 'package:weather_app/models/weather_forecast.dart';
import 'package:weather_app/ui/screens/home_screen.dart';

// Create a mock class for WeatherBloc
class MockWeatherBloc extends Mock implements WeatherBloc {}

void main() {
  late WeatherBloc weatherBloc;

  setUp(() {
    weatherBloc = MockWeatherBloc();

    // Register fallback values for streams to avoid null issues
    when(() => weatherBloc.stream).thenAnswer((_) => const Stream.empty());
    when(() => weatherBloc.state).thenReturn([]);
  });

  testWidgets('renders HomeScreen and shows loading indicator', (tester) async {
    // Arrange: Set up the mock to emit a loading state
    when(() => weatherBloc.stream)
        .thenAnswer((_) => Stream.value([])); // or any loading state you expect

    // Act: Build the widget
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider.value(
          value: weatherBloc,
          child: const HomeScreen(),
        ),
      ),
    );

    // Assert: Check for loading indicator
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
  testWidgets('renders HomeScreen with error message', (tester) async {
    // Arrange: Set up the mock to emit an error state
    when(() => weatherBloc.stream).thenAnswer(
        (_) => Stream.error(Exception('Failed to fetch weather data')));

    // Act: Build the widget
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider.value(
          value: weatherBloc,
          child: const HomeScreen(),
        ),
      ),
    );

    // Pump the widget to ensure it updates after the error is emitted
    await tester.pump();

    // Assert: Check for error message
    expect(find.text('Failed to fetch location.'), findsOneWidget);
  });

  testWidgets('renders HomeScreen with current weather and forecast',
      (tester) async {
    // Arrange: Set up the mock to emit weather data
    final weatherForecast = WeatherForecast((b) => b
      ..dt = 0
      ..main.update((b) => b..temp = 25)
      ..weather = ListBuilder([
        Weather((b) => b..description = 'clear sky'),
      ])
      ..dtTxt = '2024-08-25 12:00:00');

    final weatherForecasts = [weatherForecast];
    when(() => weatherBloc.stream)
        .thenAnswer((_) => Stream.value(weatherForecasts));

    // Act: Build the widget
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider.value(
          value: weatherBloc,
          child: const HomeScreen(),
        ),
      ),
    );

    // Assert: Check for weather information
    expect(find.byIcon(Icons.wb_sunny), findsOneWidget);
    expect(find.text('25.0°C'), findsOneWidget);
    expect(find.text('clear sky'), findsOneWidget);
  });

  testWidgets('renders HomeScreen with forecast cards', (tester) async {
    // Arrange: Set up the mock to emit forecast data
    final weatherForecast = WeatherForecast((b) => b
      ..dt = 0
      ..main.update((b) => b..temp = 25)
      ..weather = ListBuilder([
        Weather((b) => b..description = 'clear sky'),
      ])
      ..dtTxt = '2024-08-25 12:00:00');

    final nextDaysForecast = List.generate(
      4,
      (index) => WeatherForecast((b) => b
        ..dt = 0
        ..main.update((b) => b..temp = 25.0)
        ..weather = ListBuilder([
          Weather((b) => b..description = 'clear sky'),
        ])
        ..dtTxt = '2024-08-26 ${index + 1}:00:00'),
    );

    when(() => weatherBloc.stream)
        .thenAnswer((_) => Stream.value([weatherForecast] + nextDaysForecast));

    // Act: Build the widget
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider.value(
          value: weatherBloc,
          child: const HomeScreen(),
        ),
      ),
    );

    // Assert: Check for forecast cards
    expect(find.byType(ListView), findsOneWidget);
    expect(find.text('Aug 26'), findsNWidgets(4));
  });
}
