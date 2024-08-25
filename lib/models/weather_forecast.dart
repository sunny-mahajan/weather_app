import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/standard_json_plugin.dart'; // Import StandardJsonPlugin

part 'weather_forecast.g.dart';

abstract class WeatherForecast
    implements Built<WeatherForecast, WeatherForecastBuilder> {
  @BuiltValueField(wireName: 'dt')
  int get dt;

  @BuiltValueField(wireName: 'main')
  Main get main;

  @BuiltValueField(wireName: 'weather')
  BuiltList<Weather> get weather;

  @BuiltValueField(wireName: 'dt_txt')
  String get dtTxt;

  WeatherForecast._();
  factory WeatherForecast([void Function(WeatherForecastBuilder) updates]) =
      _$WeatherForecast;

  static Serializer<WeatherForecast> get serializer =>
      _$weatherForecastSerializer;

  factory WeatherForecast.fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(WeatherForecast.serializer, json)!;
  }

  Map<String, dynamic> toJson() {
    return serializers.serializeWith(WeatherForecast.serializer, this)
        as Map<String, dynamic>;
  }
}

abstract class Main implements Built<Main, MainBuilder> {
  @BuiltValueField(wireName: 'temp')
  double get temp;

  Main._();
  factory Main([void Function(MainBuilder) updates]) = _$Main;

  static Serializer<Main> get serializer => _$mainSerializer;
}

abstract class Weather implements Built<Weather, WeatherBuilder> {
  @BuiltValueField(wireName: 'description')
  String get description;

  Weather._();
  factory Weather([void Function(WeatherBuilder) updates]) = _$Weather;

  static Serializer<Weather> get serializer => _$weatherSerializer;
}

// Serializers
@SerializersFor([
  WeatherForecast,
  Main,
  Weather,
])
final Serializers serializers =
    (_$serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();
