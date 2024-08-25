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

      // Ensure the response contains the expected data
      if (response != null || response['list'] == null) {
        return [];
      }

      final List<dynamic> list = response['list'];
      final forecasts = list
          .map((item) => WeatherForecast((b) => b
            ..dt = item['dt']
            ..main.update((b) => b..temp = item['main']['temp'])
            ..weather.replace([
              Weather((b) => b..description = item['weather'][0]['description'])
            ])
            ..dtTxt = item['dt_txt']))
          .toList();

      // Get unique dates for the next 5 days
      final uniqueDates = forecasts
          .map((f) => DateFormat('yyyy-MM-dd').format(DateTime.parse(f.dtTxt)))
          .toSet()
          .take(5)
          .toList();

      // Filter forecasts to get one per day for the next 5 days
      return uniqueDates
          .map((date) => forecasts.firstWhere((f) =>
              DateFormat('yyyy-MM-dd').format(DateTime.parse(f.dtTxt)) == date))
          .toList();
    } catch (e) {
      // Log the error if needed
      print('Error fetching weather data: $e');
      // Return an empty list if there's an error
      return [];
    }
  }
}
