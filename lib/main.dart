import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/bloc/days_bloc.dart';
import 'package:weather/bloc/weather_bloc.dart';
import 'package:weather/screens/city_screen.dart';
import 'package:weather/screens/days_screen.dart';
import 'package:weather/screens/forecast_screen.dart';
import 'package:weather/screens/weather_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weather/service/weatherbit_repository.dart';

Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  final apiKey = dotenv.get('WEATHERBIT_API_KEY');
  WeatherBitRepository.setApiKey(apiKey);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create:(context) => WeatherBloc()
          ..add(LoadCitySharedPreferencesEvent())),
        BlocProvider(create:(context) => DaysBloc())
      ],
      child: BlocBuilder<WeatherBloc,WeatherState>(
          builder: (context, state) {
        return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData( primarySwatch: Colors.blue),
            // initialRoute: context.read<WeatherBloc>().state.city.isNotEmpty
            //     ? WeatherScreen.route
            //     : CityScreen.route,
            home: state.city.isEmpty ?  const CityScreen() :  WeatherScreen(),
            routes: {
              CityScreen.route: (context) => const CityScreen(),
              WeatherScreen.route: (context) =>  WeatherScreen(),
              DaysScreen.route: (context) => DaysScreen(),
              ForecastScreen.route: (context) => ForecastScreen(),
            });
      }),
    );
  }
}
