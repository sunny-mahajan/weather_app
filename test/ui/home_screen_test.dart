import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_app/blocs/weather_bloc.dart';
import 'package:weather_app/ui/screens/home_screen.dart';

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
}
