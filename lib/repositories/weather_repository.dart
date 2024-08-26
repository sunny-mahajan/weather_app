import '../models/weather_forecast.dart';
import '../services/api_service.dart';
import 'package:intl/intl.dart';

class WeatherRepository {
  final ApiService apiService;

  WeatherRepository(this.apiService);

  Future<List<WeatherForecast>> getWeatherForecast(
      double lat, double lon) async {
    try {
      final response = await apiService.get(
        'forecast',
        queryParameters: {
          'lat': lat,
          'lon': lon,
          'appid': '37ea9939152496e5de6ca532f93817fd',
          'units': 'metric',
        },
      );

      final List<dynamic> list = response['list'];
      final forecasts = list
          .map((item) => WeatherForecast((b) => b
            ..dt = item['dt']
            ..main.update(
                (b) => b..temp = (item['main']['temp'] as num).toDouble())
            ..weather.replace([
              Weather((b) => b..description = item['weather'][0]['description'])
            ])
            ..dtTxt = item['dt_txt']))
          .toList();

      // Get unique dates for the next 5 days
      final uniqueDates = forecasts
          .map((f) => DateFormat('yyyy-MM-dd').format(DateTime.parse(f.dtTxt)))
          .toSet()
          .take(6)
          .toList();

      // Filter forecasts to get one per day for the next 5 days
      return uniqueDates
          .map((date) => forecasts.firstWhere((f) =>
              DateFormat('yyyy-MM-dd').format(DateTime.parse(f.dtTxt)) == date))
          .toList();
    } catch (e, stackTrace) {
      // Extract the relevant stack trace information
      final traceLines = stackTrace.toString().split('\n');
      final relevantTrace =
          traceLines.isNotEmpty ? traceLines[0] : 'No stack trace available';

      // Log the error with the line number
      print('Error fetching weather data: $e');
      print('Occurred at: $relevantTrace');

      // Return an empty list if there's an error
      return [];
    }
  }
}
