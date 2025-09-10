import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/bloc/days_bloc.dart';
import 'package:weather/bloc/weather_bloc.dart';
import 'package:weather/screens/city_screen.dart';
import 'package:weather/screens/days_screen.dart';
import 'package:weather/screens/forecast_screen.dart';
import 'package:weather/screens/weather_screen.dart';
import 'package:weather/service/weather_map_helper.dart';
import 'package:weather/service/weatherbit_repository.dart';
import 'constants.dart';

Future main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
            create: (BuildContext context) =>
                WeatherBitRepository()..setApiKey()),
        RepositoryProvider(
            create: (context) => WeatherMapHelper()..setApiKey()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => WeatherBloc(repositories: {
                    RepositoryQualifier.openWeatherMap:
                        RepositoryProvider.of<WeatherMapHelper>(context),
                    RepositoryQualifier.weatherBit:
                        RepositoryProvider.of<WeatherBitRepository>(context)
                  })
                    ..add(LoadCitySharedPreferencesEvent())),
          BlocProvider(create: (context) => DaysBloc())
        ],
        child:
            BlocBuilder<WeatherBloc, WeatherState>(builder: (context, state) {
          return MaterialApp(
              title: 'Flutter Demo',
              theme: ThemeData(primarySwatch: Colors.blue),
              // initialRoute: context.read<WeatherBloc>().state.city.isNotEmpty
              //     ? WeatherScreen.route
              //     : CityScreen.route,
              home: state.city.isEmpty
                  ? const CityScreen()
                  : const WeatherScreen(),
              routes: {
                CityScreen.route: (context) => const CityScreen(),
                WeatherScreen.route: (context) => const WeatherScreen(),
                DaysScreen.route: (context) => DaysScreen(),
                ForecastScreen.route: (context) => const ForecastScreen(),
              });
        }),
      ),
    );
  }
}
