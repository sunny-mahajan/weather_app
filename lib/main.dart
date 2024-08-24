import "package:flutter/material.dart";
import "package:hydrated_bloc/hydrated_bloc.dart";
import "package:path_provider/path_provider.dart";
import "package:flutter_screenutil/flutter_screenutil.dart"; // Import for ScreenUtilInit
import "package:get/get.dart"; // Import for GetMaterialApp
import "./ui/screens/home_screen.dart";

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getTemporaryDirectory(),
  );
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(412, 820), //Google pixel 4
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return GetMaterialApp(
              title: 'Weather App',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(primarySwatch: Colors.blue),
              home: const HomeScreen());
        });
  }
}
