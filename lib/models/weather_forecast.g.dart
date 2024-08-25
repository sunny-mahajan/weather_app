// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_forecast.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializers _$serializers = (new Serializers().toBuilder()
      ..add(Main.serializer)
      ..add(Weather.serializer)
      ..add(WeatherForecast.serializer)
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(Weather)]),
          () => new ListBuilder<Weather>()))
    .build();
Serializer<WeatherForecast> _$weatherForecastSerializer =
    new _$WeatherForecastSerializer();
Serializer<Main> _$mainSerializer = new _$MainSerializer();
Serializer<Weather> _$weatherSerializer = new _$WeatherSerializer();

class _$WeatherForecastSerializer
    implements StructuredSerializer<WeatherForecast> {
  @override
  final Iterable<Type> types = const [WeatherForecast, _$WeatherForecast];
  @override
  final String wireName = 'WeatherForecast';

  @override
  Iterable<Object?> serialize(Serializers serializers, WeatherForecast object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'dt',
      serializers.serialize(object.dt, specifiedType: const FullType(int)),
      'main',
      serializers.serialize(object.main, specifiedType: const FullType(Main)),
      'weather',
      serializers.serialize(object.weather,
          specifiedType:
              const FullType(BuiltList, const [const FullType(Weather)])),
      'dt_txt',
      serializers.serialize(object.dtTxt,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  WeatherForecast deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new WeatherForecastBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'dt':
          result.dt = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'main':
          result.main.replace(serializers.deserialize(value,
              specifiedType: const FullType(Main))! as Main);
          break;
        case 'weather':
          result.weather.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(Weather)]))!
              as BuiltList<Object?>);
          break;
        case 'dt_txt':
          result.dtTxt = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$MainSerializer implements StructuredSerializer<Main> {
  @override
  final Iterable<Type> types = const [Main, _$Main];
  @override
  final String wireName = 'Main';

  @override
  Iterable<Object?> serialize(Serializers serializers, Main object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'temp',
      serializers.serialize(object.temp, specifiedType: const FullType(double)),
    ];

    return result;
  }

  @override
  Main deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new MainBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'temp':
          result.temp = serializers.deserialize(value,
              specifiedType: const FullType(double))! as double;
          break;
      }
    }

    return result.build();
  }
}

class _$WeatherSerializer implements StructuredSerializer<Weather> {
  @override
  final Iterable<Type> types = const [Weather, _$Weather];
  @override
  final String wireName = 'Weather';

  @override
  Iterable<Object?> serialize(Serializers serializers, Weather object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'description',
      serializers.serialize(object.description,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  Weather deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new WeatherBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'description':
          result.description = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$WeatherForecast extends WeatherForecast {
  @override
  final int dt;
  @override
  final Main main;
  @override
  final BuiltList<Weather> weather;
  @override
  final String dtTxt;

  factory _$WeatherForecast([void Function(WeatherForecastBuilder)? updates]) =>
      (new WeatherForecastBuilder()..update(updates))._build();

  _$WeatherForecast._(
      {required this.dt,
      required this.main,
      required this.weather,
      required this.dtTxt})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(dt, r'WeatherForecast', 'dt');
    BuiltValueNullFieldError.checkNotNull(main, r'WeatherForecast', 'main');
    BuiltValueNullFieldError.checkNotNull(
        weather, r'WeatherForecast', 'weather');
    BuiltValueNullFieldError.checkNotNull(dtTxt, r'WeatherForecast', 'dtTxt');
  }

  @override
  WeatherForecast rebuild(void Function(WeatherForecastBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  WeatherForecastBuilder toBuilder() =>
      new WeatherForecastBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is WeatherForecast &&
        dt == other.dt &&
        main == other.main &&
        weather == other.weather &&
        dtTxt == other.dtTxt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, dt.hashCode);
    _$hash = $jc(_$hash, main.hashCode);
    _$hash = $jc(_$hash, weather.hashCode);
    _$hash = $jc(_$hash, dtTxt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'WeatherForecast')
          ..add('dt', dt)
          ..add('main', main)
          ..add('weather', weather)
          ..add('dtTxt', dtTxt))
        .toString();
  }
}

class WeatherForecastBuilder
    implements Builder<WeatherForecast, WeatherForecastBuilder> {
  _$WeatherForecast? _$v;

  int? _dt;
  int? get dt => _$this._dt;
  set dt(int? dt) => _$this._dt = dt;

  MainBuilder? _main;
  MainBuilder get main => _$this._main ??= new MainBuilder();
  set main(MainBuilder? main) => _$this._main = main;

  ListBuilder<Weather>? _weather;
  ListBuilder<Weather> get weather =>
      _$this._weather ??= new ListBuilder<Weather>();
  set weather(ListBuilder<Weather>? weather) => _$this._weather = weather;

  String? _dtTxt;
  String? get dtTxt => _$this._dtTxt;
  set dtTxt(String? dtTxt) => _$this._dtTxt = dtTxt;

  WeatherForecastBuilder();

  WeatherForecastBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _dt = $v.dt;
      _main = $v.main.toBuilder();
      _weather = $v.weather.toBuilder();
      _dtTxt = $v.dtTxt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(WeatherForecast other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$WeatherForecast;
  }

  @override
  void update(void Function(WeatherForecastBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  WeatherForecast build() => _build();

  _$WeatherForecast _build() {
    _$WeatherForecast _$result;
    try {
      _$result = _$v ??
          new _$WeatherForecast._(
              dt: BuiltValueNullFieldError.checkNotNull(
                  dt, r'WeatherForecast', 'dt'),
              main: main.build(),
              weather: weather.build(),
              dtTxt: BuiltValueNullFieldError.checkNotNull(
                  dtTxt, r'WeatherForecast', 'dtTxt'));
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'main';
        main.build();
        _$failedField = 'weather';
        weather.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'WeatherForecast', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$Main extends Main {
  @override
  final double temp;

  factory _$Main([void Function(MainBuilder)? updates]) =>
      (new MainBuilder()..update(updates))._build();

  _$Main._({required this.temp}) : super._() {
    BuiltValueNullFieldError.checkNotNull(temp, r'Main', 'temp');
  }

  @override
  Main rebuild(void Function(MainBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MainBuilder toBuilder() => new MainBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Main && temp == other.temp;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, temp.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Main')..add('temp', temp)).toString();
  }
}

class MainBuilder implements Builder<Main, MainBuilder> {
  _$Main? _$v;

  double? _temp;
  double? get temp => _$this._temp;
  set temp(double? temp) => _$this._temp = temp;

  MainBuilder();

  MainBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _temp = $v.temp;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Main other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Main;
  }

  @override
  void update(void Function(MainBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Main build() => _build();

  _$Main _build() {
    final _$result = _$v ??
        new _$Main._(
            temp: BuiltValueNullFieldError.checkNotNull(temp, r'Main', 'temp'));
    replace(_$result);
    return _$result;
  }
}

class _$Weather extends Weather {
  @override
  final String description;

  factory _$Weather([void Function(WeatherBuilder)? updates]) =>
      (new WeatherBuilder()..update(updates))._build();

  _$Weather._({required this.description}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        description, r'Weather', 'description');
  }

  @override
  Weather rebuild(void Function(WeatherBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  WeatherBuilder toBuilder() => new WeatherBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Weather && description == other.description;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Weather')
          ..add('description', description))
        .toString();
  }
}

class WeatherBuilder implements Builder<Weather, WeatherBuilder> {
  _$Weather? _$v;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  WeatherBuilder();

  WeatherBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _description = $v.description;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Weather other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Weather;
  }

  @override
  void update(void Function(WeatherBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Weather build() => _build();

  _$Weather _build() {
    final _$result = _$v ??
        new _$Weather._(
            description: BuiltValueNullFieldError.checkNotNull(
                description, r'Weather', 'description'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
