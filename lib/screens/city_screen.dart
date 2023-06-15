import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/bloc/weather_bloc.dart';
import 'package:weather/constants.dart';
import 'package:weather/screens/weather_screen.dart';

class CityScreen extends StatefulWidget {
  const CityScreen({Key? key}) : super(key: key);
  static const String route = 'city';

  @override
  State<CityScreen> createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  final TextEditingController _controller = TextEditingController();
  late final Color currentClr;

  @override
  void initState() {
    var colors = [clr1, clr2, clr3, clr4];
    currentClr = colors[Random().nextInt(colors.length)];
    _controller.addListener(() {});
    super.initState();
  }

  bool checkCity = true;
  double scale = 1.0;
  double umbrellaScale = 0.0;
  TextStyle style = tsCity;

  void _changeScale() {
    setState(() => scale = scale == 1.0 ? 2.0 : 1.0);
  }
  void _changeUmbrellaScale() {
    setState(() => umbrellaScale = umbrellaScale == 0.0 ? 2.0 : 0.0);
  }
  void _changeStyle() {
    setState(() => style = style == tsCity ? tsTitleBolt.copyWith(color: Colors.white) : tsCity);
  }

  @override
  Widget build(BuildContext context) {
    if (checkCity && context.read<WeatherBloc>().state.city.isNotEmpty) {
      _controller.text = context.read<WeatherBloc>().state.city;
      checkCity = false;
    }

    return Scaffold(
      backgroundColor: currentClr,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedScale(
                scale: umbrellaScale,
                duration: const Duration(seconds: 1),
                curve: Curves.fastOutSlowIn,
                child: const Image(
                  image: AssetImage('assets/images/weather.png'),
                  height: 100,
                  width: 100,
                  color: Colors.white,
                ),
              ),
              Hero(
                tag: 'up',
                child: Material(
                  type: MaterialType.transparency,
                  child: Container(
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    decoration: BoxDecoration(
                      gradient: bdGradient,
                      border: Border.all(
                        color: Colors.white,
                        width: 3,
                      ),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(brDef)),
                      //color: Colors.black,
                    ),
                    child: Center(
                      child: AnimatedScale(
                        scale: scale,
                        duration: const Duration(seconds: 1),
                        curve: Curves.fastOutSlowIn,
                        child: AnimatedDefaultTextStyle(
                          style: style,
                          duration: const Duration(seconds: 1),
                          child: const Text(
                            'Погода',
                            // style: tsCity,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 25),
              Hero(
                tag: 'black',
                child: Material(
                  type: MaterialType.transparency,
                  child: Container(
                    height: 100,
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(brDef)),
                      color: Colors.black,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _controller,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Введите город',
                              hintStyle: tsLite.copyWith(color: currentClr),
                            ),
                            style: tsLite.copyWith(color: currentClr),
                          ),
                        ),
                        AnimatedScale(
                          scale: scale,
                          duration: const Duration(seconds: 1),
                          curve: Curves.fastOutSlowIn,
                          onEnd: () {
                            context.read<WeatherBloc>().add(LoadWeatherEvent());
                            Navigator.pushReplacementNamed(
                                context, WeatherScreen.route);
                          },
                          child: OutlinedButton(
                            onPressed: () {
                              context
                                  .read<WeatherBloc>()
                                  .add(CityEvent(_controller.text));
                              _changeScale();
                              _changeStyle();
                              _changeUmbrellaScale();
                              //Future.delayed(const Duration(seconds: 1));
                              // context
                              //     .read<WeatherBloc>()
                              //     .add(CityEvent(_controller.text));
                              // context
                              //     .read<WeatherBloc>()
                              //     .add(LoadWeatherEvent());
                              // Navigator.pushReplacementNamed(
                              //     context, WeatherScreen.route);
                            },
                            child: Icon(
                              CupertinoIcons.tornado,
                              size: 30,
                              color: currentClr,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
