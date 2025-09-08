import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/bloc/weather_bloc.dart';
import 'package:weather/constants.dart';
import 'package:weather/screens/weather_screen.dart';
import 'package:weather/widgets/arrow_button.dart';
import 'package:weather/widgets/arrow_paint.dart';
import '../utils.dart';

class CityScreen extends StatefulWidget {
  const CityScreen({Key? key}) : super(key: key);
  static const String route = 'city';
  static final GlobalKey globalKey = GlobalKey();

  @override
  State<CityScreen> createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  final TextEditingController _controller = TextEditingController();
  late final Color currentClr;

  @override
  void initState() {
    currentClr = getCurrentColor();
    _controller.addListener(() {});
    super.initState();
  }

  bool checkCity = true;
  double scale = 1.0;
  double umbrellaScale = 0.5;
  TextStyle style = tsCity;
  RepositoryQualifier qualifier = RepositoryQualifier.openWeatherMap;

  void _changeScale() {
    setState(() => scale = scale == 1.0 ? 2.0 : 1.0);
  }

  void _changeUmbrellaScale() {
    setState(() => umbrellaScale = umbrellaScale == 0.0 ? 2.0 : 0.0);
  }

  void _changeStyle() {
    setState(() => style =
        style == tsCity ? tsTitleBolt.copyWith(color: Colors.white) : tsCity);
  }

  void choice(RepositoryQualifier value) {
    setState(() {
      qualifier = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (checkCity && context.read<WeatherBloc>().state.city.isNotEmpty) {
      _controller.text = context.read<WeatherBloc>().state.city;
      checkCity = false;
      qualifier = context.read<WeatherBloc>().getCurrentRepositoryQualifier();
    }

    return Scaffold(
      backgroundColor: currentClr,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Transform.rotate(
              //   angle: pi / 2,
              //   child: Text.rich(
              //     textAlign: TextAlign.left,
              //     TextSpan(
              //       text: 'Прогноз\n',
              //       style: tsBigTemp.copyWith(fontSize: 90),
              //       children: [
              //         TextSpan(
              //           text: 'Погоды',
              //           style: tsLite.copyWith(fontSize: 100),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              // AnimatedScale(
              //   scale: umbrellaScale,
              //   duration: const Duration(seconds: 1),
              //   curve: Curves.fastOutSlowIn,
              //   child: const Image(
              //     image: AssetImage('assets/images/weather.png'),
              //     height: 100,
              //     width: 100,
              //     color: Colors.black,
              //   ),
              // ),
              const SizedBox(height: 25),
              Container(height: 100, width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 25),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(brDef)),
                  color: Colors.black,
                ),
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
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Найти',
                    style: tsDefault,
                  ),
                  ArrowButton(
                    execute: () {
                      context
                          .read<WeatherBloc>()
                          .add(ChangeRepositoryEvent(qualifier));
                      context
                          .read<WeatherBloc>()
                          .add(CityEvent(_controller.text));
                      context.read<WeatherBloc>().add(LoadWeatherEvent());
                      Navigator.pushReplacementNamed(
                          context, WeatherScreen.route);
                    },
                  ),
                ],
              ),

              const SizedBox(height: 15),
              Container(
                height: 300,
                child: ListView.builder(
                  itemCount: RepositoryQualifier.values.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          decoration:
                              RepositoryQualifier.values[index] == qualifier
                                  ? decorationFill
                                  : const BoxDecoration(),
                          child: Row(
                            children: [
                              Text(
                                RepositoryQualifier.values[index].name,
                                textAlign: TextAlign.center,
                                style: RepositoryQualifier.values[index] ==
                                        qualifier
                                    ? tsBigTemp.copyWith(
                                        fontSize: 22,
                                        color: currentClr,
                                      )
                                    : tsLite.copyWith(fontSize: 22),
                              ),
                              if (RepositoryQualifier.values[index] !=
                                  qualifier) ...[
                                Transform.rotate(
                                  angle: pi,
                                  child: ArrowButton(
                                    execute: () {
                                      choice(
                                          RepositoryQualifier.values[index]);
                                    },
                                  ),
                                ),
                              ] else ...[
                                CustomPaint(
                                  size: const Size(75, 25),
                                  painter:
                                      ArrowCustomPainter(color: currentClr),
                                )
                              ],
                            ],
                          )),
                    );
                  },
                ),
              )

              ///end
            ],
          ),
        ),
      ),
    );
  }
}
