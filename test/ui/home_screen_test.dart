import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:built_collection/built_collection.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_app/blocs/weather_bloc.dart';
import 'package:weather_app/ui/screens/home_screen.dart';
import 'package:weather_app/models/weather_forecast.dart';
import 'package:weather_app/utils/app_utils.dart';
import 'package:intl/intl.dart';

// Create a mock class for WeatherBloc
// class MockWeatherBloc extends Mock implements WeatherBloc {}
class MockWeatherBloc extends Mock implements WeatherBloc {
  @override
  Future<void> close() async {}
}

void main() {
  late MockWeatherBloc mockWeatherBloc;

  setUp(() {
    mockWeatherBloc = MockWeatherBloc();

    // Register fallback values for streams to avoid null issues
    when(() => mockWeatherBloc.stream).thenAnswer((_) => const Stream.empty());
    when(() => mockWeatherBloc.state).thenReturn([]);
  });

  testWidgets('HomeScreen builds without errors with Bloc Activated',
      (WidgetTester tester) async {
    // Build the HomeScreen widget inside a MaterialApp using the mock WeatherBloc
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<WeatherBloc>(
          create: (context) => mockWeatherBloc,
          child: const HomeScreen(),
        ),
      ),
    );

    // Trigger a frame
    await tester.pump();

    // Verify that the HomeScreen widget is built and displayed
    expect(find.byType(HomeScreen), findsOneWidget);
  });

  test('WidgetsFlutterBinding is initialized', () {
    final binding = TestWidgetsFlutterBinding.ensureInitialized();

    expect(binding, isA<WidgetsBinding>());

    expect(WidgetsBinding.instance, isNotNull);
  });

  testWidgets('renders forecast card with correct data', (WidgetTester tester) async {
    // Arrange: Create a mock WeatherForecast object
    final weatherForecast = WeatherForecast((b) => b
      ..dtTxt = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now())
      ..dt = DateTime.now().millisecondsSinceEpoch ~/ 1000
      ..main.update((b) => b..temp = 23.5)
      ..weather = ListBuilder<Weather>([
        Weather((b) => b..description = 'Clear'),
      ]));

    // Act: Build the widget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ForecastCardWidget(weather: weatherForecast),
        ),
      ),
    );

    // Assert: Check if the date, temperature, and icon are displayed correctly
    final dateText = find.text(DateFormat('MMM d').format(
      DateTime.fromMillisecondsSinceEpoch(weatherForecast.dt * 1000),
    ));
    final temperatureText = find.text('23.5°C');
    final weatherIcon = find.byIcon(APPUtils.getWeatherIcon('Clear'));

    expect(dateText, findsOneWidget);
    expect(temperatureText, findsOneWidget);
    expect(weatherIcon, findsOneWidget);
  });

  group('APPUtils', () {
    test('getBackgroundGradient returns correct gradient for clear sky', () {
      final gradient = APPUtils.getBackgroundGradient('clear sky');

      expect(gradient, const LinearGradient(
        colors: [Color(0xFF87CEFA), Color(0xFFB0E0E6)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ));
    });

    test('getBackgroundGradient returns correct gradient for scattered clouds', () {
      final gradient = APPUtils.getBackgroundGradient('scattered clouds');

      expect(gradient, const LinearGradient(
        colors: [Color(0xFF87CEEB), Color(0xFFB0E0E6)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ));
    });

    test('getBackgroundGradient returns correct gradient for rain', () {
      final gradient = APPUtils.getBackgroundGradient('rain');

      expect(gradient, const LinearGradient(
        colors: [Color(0xFF778899), Color(0xFFB0C4DE)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ));
    });

    test('getWeatherIcon returns correct icon for clear sky', () {
      final icon = APPUtils.getWeatherIcon('clear sky');

      expect(icon, Icons.wb_sunny);
    });

    test('getWeatherIcon returns correct icon for thunderstorm', () {
      final icon = APPUtils.getWeatherIcon('thunderstorm');

      expect(icon, Icons.bolt);
    });

    test('getWeatherIcon returns default icon for unknown description', () {
      final icon = APPUtils.getWeatherIcon('unknown description');

      expect(icon, Icons.cloud_queue);
    });

    test('getBackgroundGradient returns correct gradient for mist', () {
      final gradient = APPUtils.getBackgroundGradient('mist');

      expect(gradient, const LinearGradient(
        colors: [Color(0xFFb0e0e6), Color(0xFFd3d3d3)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ));
    });

    test('getWeatherIcon returns correct icon for snow', () {
      final icon = APPUtils.getWeatherIcon('snow');

      expect(icon, Icons.ac_unit);
    });
  });
}
