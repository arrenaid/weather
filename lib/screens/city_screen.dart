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
  double umbrellaScale = 2.0;
  TextStyle style = tsCityStart;
  RepositoryQualifier qualifier = RepositoryQualifier.openWeatherMap;

  void _changeScale() {
    setState(() => scale = scale == 1.0 ? 1.2 : 1.0);
  }

  void _changeUmbrellaScale() {
    setState(() => umbrellaScale = umbrellaScale == 1.0 ? 2.0 : 1.0);
  }

  void _changeStyle() {
    setState(() => style = style == tsCityStart ? tsCityEnd : tsCityStart);
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
      qualifier = context.read<WeatherBloc>().state.qualifier;
    }

    return Scaffold(
      backgroundColor: currentClr,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 3,
                child: Stack(
                  children: [
                    Hero(tag: 'img',
                      child: Align(
                        alignment: const FractionalOffset(0.5, 0.5),
                        child: AnimatedScale(
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
                      ),
                    ),
                    Hero(
                      tag: 'up',
                      child: Material(
                        type: MaterialType.transparency,
                        child: Center(
                          child: AnimatedScale(
                            scale: scale,
                            duration: const Duration(seconds: 1),
                            curve: Curves.fastOutSlowIn,
                            child: AnimatedDefaultTextStyle(
                              style: style,
                              duration: const Duration(seconds: 1),
                              child: const RotatedBox(
                                quarterTurns: 1,
                                child: Text(
                                  'Прогноз\nПогоды',
                                  // style: tsCity,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              Hero(
                tag: 'black',
                child: Material(
                  type: MaterialType.transparency,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    decoration: decorationFill,
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
                            context
                                .read<WeatherBloc>()
                                .add(ChangeRepositoryEvent(qualifier));
                            context.read<WeatherBloc>().add(LoadWeatherEvent());
                            Navigator.pushReplacementNamed(
                                context, WeatherScreen.route);
                          },
                          child: ArrowButton(
                              backgroundColor: currentClr,
                              execute: () {
                                context
                                    .read<WeatherBloc>()
                                    .add(CityEvent(_controller.text));
                                _changeScale();
                                _changeStyle();
                                _changeUmbrellaScale();
                              }),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              ///выбор репозитория
              const SizedBox(height: 15),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Выбор репозитория:',
                  style: tsDefault.copyWith(fontSize: 18),
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 4,
                child: ListView.builder(
                  itemCount: RepositoryQualifier.values.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: GestureDetector(
                        onTap: () => choice(RepositoryQualifier.values[index]),
                        child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            decoration:
                                RepositoryQualifier.values[index] == qualifier
                                    ? decorationFill
                                    : const BoxDecoration(),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                if (RepositoryQualifier.values[index] ==
                                    qualifier) ...[
                                  CustomPaint(
                                    size: const Size(60, 25),
                                    painter:
                                        ArrowCustomPainter(color: currentClr),
                                  )
                                ],
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
                              ],
                            )),
                      ),
                    );
                  },
                ),
              ),

              ///end
            ],
          ),
        ),
      ),
    );
  }
}
