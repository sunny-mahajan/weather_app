# Forecastify

**Forecastify** is a Flutter-based weather mobile app that provides a 5-day weather forecast for your current location. The app uses various third-party APIs and plugins to deliver a smooth and responsive user experience, even when offline.

## Features

- **Real-time Weather Forecast**: Displays a 5-day weather forecast based on the user's current location.
- **Offline Support**: Stores the last fetched weather data locally, allowing users to view the forecast even without an internet connection.
- **Accurate Location Detection**: Automatically detects the user's current location using GPS.
- **Robust State Management**: Manages app states efficiently using the BLoC pattern.
- **Comprehensive Testing**: Includes widget and unit tests to ensure app reliability.

## Getting Started

### Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- [Dart](https://dart.dev/get-dart)
- API Key for [OpenWeatherMap](https://openweathermap.org/): You can sign up for a free API key [here](https://home.openweathermap.org/users/sign_up).

### Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/sunny-mahajan/weather_app.git
   cd weather_app
   ```

2. **Install dependencies:**
   ```bash
   flutter pub get
   ```

3. **Add your OpenWeatherMap API key:**

   Open the `lib/core/constants.dart` file and add your App ID:
   ```dart
   const String APP_ID = 'YOUR_API_ID_HERE';
   ```

4. **Run the app:**
   ```bash
   flutter run
   ```

## Usage

The app will automatically detect your current location and display the 5-day weather forecast. If you don't have an active internet connection, the app will show the last recorded forecast data.

## Plugins Used

- **[dio](https://pub.dev/packages/dio)**: Used to make API calls, with the API key added as an interceptor.
- **[bloc](https://pub.dev/packages/bloc)**: For state management, following the BLoC pattern.
- **[built_value](https://pub.dev/packages/built_value)**: For JSON serialization and deserialization.
- **[hydrated_bloc](https://pub.dev/packages/hydrated_bloc)**: To persist the last fetched weather data locally.
- **[geolocator](https://pub.dev/packages/geolocator)**: To get the user's current location.

## Testing

The project includes unit tests and widget tests to ensure the app's functionality and reliability.

- **Run tests:**
  ```bash
  flutter test
  ```